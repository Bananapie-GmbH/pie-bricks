import { Role } from '@/enums/role.enum';

export interface User {
  id: string;
  email: string;
  password: string;
  role: Role;
}
