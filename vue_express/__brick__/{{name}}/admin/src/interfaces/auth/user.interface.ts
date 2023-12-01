export interface IUser {
  id: string
  emailVerified: boolean
  role: string
  online: boolean
  lastLogin: string
  username: string
  email: string
  password: string
  updatedAt: string
  createdAt: string
  status: string
  isArchived: boolean
  profilePicture: string
  newsletterAccepted: boolean
  termsAccepted: boolean
  roleProfile: IRole
}

export interface IUserCreate {
  role: string
  password: string
  email: string
}

export interface IRole {
  updatedAt: string
  createdAt: string
}
