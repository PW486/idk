import { Request, Response } from 'express';
import { JWT_EXPIRE } from '../../../../config/environments';
import { getTokenByIdAction } from '../action/user.getTokenById';

export async function getTokenHandler(req: Request, res: Response) {
  const accessToken = await getTokenByIdAction(req.user.id);

  res.status(200).json({ access_token: accessToken, expires_in: JWT_EXPIRE });
}
