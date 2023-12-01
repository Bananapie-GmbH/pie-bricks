import { NextFunction, Request, Response } from 'express';
import { CreateUserDto, LoginUserDto } from '@dtos/users.dto';
import { User } from '@interfaces/users.interface';
import { RequestWithUser } from '@interfaces/auth.interface';
import AuthService from '@services/auth.service';
import Cookies from 'cookies';
import { COOKIE_DOMAIN, NODE_ENV } from '@/config';

class AuthController {
  public authService = new AuthService();
  FIFTEEN_MINUTES_IN_MILLISECONDS = 900 * 1000;
  ONE_DAY_IN_MILLISECONDS = 86400 * 1000;

  public isInitialized = async (req: Request, res: Response, next: NextFunction) => {
    try {
      const hasAdmin = await this.authService.isInitialized();

      res.status(200).json({ isInitialized: hasAdmin });
    } catch (error) {
      next(error);
    }
  };

  public me = async (req: Request, res: Response, next: NextFunction) => {
    try {
      const userId = req.user.id;
      const user = await this.authService.me(userId);
      res.status(200).json(user);
    } catch (error) {
      next(error);
    }
  };

  public signUp = async (req: Request, res: Response, next: NextFunction) => {
    try {
      const userData: CreateUserDto = req.body;
      const signUpUserData: User = await this.authService.signup(userData);

      res.status(201).json({ signUpUserData });
    } catch (error) {
      next(error);
    }
  };

  public refresh = async (req: Request, res: Response, next: NextFunction) => {
    try {
      const userId = req.user.id;
      const { accessToken, csrf } = await this.authService.refreshTokens(userId);
      const cookies = new Cookies(req, res);

      cookies.set('Authorization', `${accessToken.token}`, {
        httpOnly: true,
        sameSite: NODE_ENV === 'production' ? 'none' : undefined,
        secure: NODE_ENV === 'production',
        maxAge: this.FIFTEEN_MINUTES_IN_MILLISECONDS,
        domain: NODE_ENV === 'production' ? `.${COOKIE_DOMAIN}` : 'localhost',
        path: '/',
      });

      return res.status(200).send();
    } catch (error) {
      next(error);
    }
  };

  public logIn = async (req: Request, res: Response, next: NextFunction) => {
    try {
      const userData: LoginUserDto = req.body;
      const { accessToken, refreshToken, findUser, csrf } = await this.authService.login(userData);

      const cookies = new Cookies(req, res);

      cookies.set('Authorization', `${accessToken.token}`, {
        httpOnly: true,
        sameSite: NODE_ENV === 'production' ? 'none' : undefined,
        secure: NODE_ENV === 'production',
        maxAge: this.FIFTEEN_MINUTES_IN_MILLISECONDS,
        domain: NODE_ENV === 'production' ? `.${COOKIE_DOMAIN}` : 'localhost',
        path: '/',
      });

      cookies.set('Refresh', `${refreshToken.token}`, {
        httpOnly: true,
        sameSite: NODE_ENV === 'production' ? 'none' : undefined,
        secure: NODE_ENV === 'production',
        maxAge: this.ONE_DAY_IN_MILLISECONDS,
        domain: NODE_ENV === 'production' ? `.${COOKIE_DOMAIN}` : 'localhost',
        path: '/',
      });

      cookies.set('CSRF', `${csrf}`, {
        httpOnly: false,
        sameSite: NODE_ENV === 'production' ? 'none' : undefined,
        secure: NODE_ENV === 'production',
        maxAge: this.ONE_DAY_IN_MILLISECONDS,
        domain: NODE_ENV === 'production' ? `.${COOKIE_DOMAIN}` : 'localhost',
        path: '/',
      });

      res.status(200).json(findUser);
    } catch (error) {
      next(error);
    }
  };

  public logOut = async (req: RequestWithUser, res: Response, next: NextFunction) => {
    try {
      const userData: User = req.user;
      const logOutUserData: User = await this.authService.logout(userData);

      res.setHeader('Set-Cookie', ['Authorization=; Max-age=0']);
      res.status(200).json({ logOutUserData });
    } catch (error) {
      next(error);
    }
  };
}

export default AuthController;
