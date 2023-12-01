import { NextFunction, Response } from 'express';
import { verify } from 'jsonwebtoken';
import { SECRET_KEY } from '@config';
import DB from '@databases';
import { HttpException } from '@exceptions/HttpException';
import { DataStoredInToken, RequestWithUser } from '@interfaces/auth.interface';
import Tokens from 'csrf';

const refreshMiddleware = async (req: RequestWithUser, res: Response, next: NextFunction) => {
  try {
    const Refresh = req.cookies['Refresh'] || (req.header('Refresh') ? req.header('Refresh').split('Bearer ')[1] : null);
    const csrf = req.headers['x-csrf-token'] as string;
    if (Refresh && csrf) {
      const secretKey: string = SECRET_KEY;
      const verificationResponse = verify(Refresh, secretKey) as DataStoredInToken;
      const tokens = new Tokens();
      if (verificationResponse.csrf === csrf && !tokens.verify(SECRET_KEY, csrf)) {
        throw new HttpException(401, 'CSRF Token is invalid');
      }
      const userId = verificationResponse.id;
      const findUser = await DB.Users.findByPk(userId);

      if (findUser) {
        req.user = findUser;
        next();
      } else {
        next(new HttpException(403, 'Wrong authentication token'));
      }
    } else {
      next(new HttpException(403, 'Refresh token missing'));
    }
  } catch (error) {
    next(new HttpException(403, 'Wrong authentication token'));
  }
};

export default refreshMiddleware;
