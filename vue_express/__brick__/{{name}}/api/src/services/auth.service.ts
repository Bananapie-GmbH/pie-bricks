import { compare, hash } from 'bcrypt';
import { sign } from 'jsonwebtoken';
import { NODE_ENV, SECRET_KEY, COOKIE_DOMAIN } from '@config';
import DB from '@databases';
import { CreateUserDto, LoginUserDto } from '@dtos/users.dto';
import { HttpException } from '@exceptions/HttpException';
import { DataStoredInToken, TokenData } from '@interfaces/auth.interface';
import { User } from '@interfaces/users.interface';
import { isEmpty } from '@utils/util';
import { Role } from '@/enums/role.enum';
import { AdminModel } from '@/models/admin.model';
import Tokens from 'csrf';
import Cookies from 'cookies';

class AuthService {
  public users = DB.Users;
  public admins = DB.Admins;
  ONE_DAY_IN_MILLISECONDS = 24 * 60 * 60 * 1000;
  FIFTEEN_MINUTES_IN_MILLISECONDS = 15 * 60 * 1000;

  public async isInitialized(): Promise<boolean> {
    const findUser: User = await this.users.findOne({ where: { role: Role.ADMIN } });
    if (findUser) return true;
    return false;
  }

  public async me(userId: string): Promise<User> {
    const findUser: User = await this.users.findOne({ where: { id: userId }, include: { model: AdminModel, as: 'roleProfile' } });

    if (!findUser) throw new HttpException(404, `User not found`);

    return findUser;
  }

  public async signup(userData: CreateUserDto): Promise<User> {
    if (isEmpty(userData)) throw new HttpException(400, 'userData is empty');

    const findUser: User = await this.users.findOne({ where: { email: userData.email } });
    if (findUser) throw new HttpException(409, `This email ${userData.email} already exists`);

    const hashedPassword = await hash(userData.password, 10);
    const createUserData: User = await this.users.create({ ...userData, password: hashedPassword });

    if (createUserData.role === Role.ADMIN) {
      await this.admins.create({ userId: createUserData.id, email: createUserData.email });
    }

    return createUserData;
  }

  public async login(userData: LoginUserDto): Promise<{ accessToken: TokenData; refreshToken: TokenData; findUser: User; csrf: string }> {
    if (isEmpty(userData)) throw new HttpException(400, 'userData is empty');

    const findUser: User = await this.users.findOne({ where: { email: userData.email }, include: { model: AdminModel, as: 'roleProfile' } });
    if (!findUser) throw new HttpException(409, `This email ${userData.email} was not found`);

    const isPasswordMatching: boolean = await compare(userData.password, findUser.password);
    if (!isPasswordMatching) throw new HttpException(409, 'Password not matching');

    const csrf = this.createCSRFToken(this.FIFTEEN_MINUTES_IN_MILLISECONDS);

    const payload: DataStoredInToken = { id: findUser.id, csrf };

    const accessToken = this.createToken(payload, this.FIFTEEN_MINUTES_IN_MILLISECONDS);
    const refreshToken = this.createToken(payload, this.ONE_DAY_IN_MILLISECONDS);

    return { accessToken, refreshToken, findUser, csrf };
  }

  public async refreshTokens(userId: string): Promise<{ accessToken: TokenData; csrf: string }> {
    const csrf = this.createCSRFToken(this.FIFTEEN_MINUTES_IN_MILLISECONDS);

    const payload: DataStoredInToken = { id: userId, csrf };

    const accessToken = this.createToken(payload, this.FIFTEEN_MINUTES_IN_MILLISECONDS);

    return { accessToken, csrf };
  }

  public async logout(userData: User): Promise<User> {
    if (isEmpty(userData)) throw new HttpException(400, 'userData is empty');

    const findUser: User = await this.users.findOne({ where: { email: userData.email, password: userData.password } });
    if (!findUser) throw new HttpException(409, "User doesn't exist");

    return findUser;
  }

  public createToken(payload: DataStoredInToken, expiresIn: number): TokenData {
    const secretKey: string = SECRET_KEY;

    return { expiresIn, token: sign(payload, secretKey, { expiresIn }) };
  }

  public createCookie(name: string, tokenData: TokenData): string {
    return NODE_ENV === 'development'
      ? `${name}=${tokenData.token}; HttpOnly; Max-Age=${tokenData.expiresIn}; Path=/`
      : `${name}=${tokenData.token}; HttpOnly; SameSite=None; Secure; Domain=.${COOKIE_DOMAIN}.de; Max-Age=${tokenData.expiresIn}; Path=/`;
  }

  public createCSRFToken(expiresIn: number): string {
    const tokens = new Tokens();
    const csrf = tokens.create(SECRET_KEY);
    return csrf;
  }
}

export default AuthService;
