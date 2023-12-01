import { Role } from '@/enums/role.enum';
import { IsString, IsEmail, IsEnum } from 'class-validator';

export class CreateUserDto {
  @IsEmail()
  public email: string;

  @IsString()
  public password: string;

  @IsEnum(Role)
  public role: Role;
}

export class LoginUserDto {
  @IsEmail()
  public email: string;

  @IsString()
  public password: string;
}
