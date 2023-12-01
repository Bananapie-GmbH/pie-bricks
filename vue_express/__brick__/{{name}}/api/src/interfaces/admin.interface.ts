import { Role } from '@/enums/role.enum';

export interface Admin {
  id: string;
  email: string;
  userId?: string;
}
