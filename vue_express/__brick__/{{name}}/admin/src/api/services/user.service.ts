import type { IUser, IUserCreate } from '@/interfaces/auth/user.interface'
import ApiService from '../utils/api_service'
import type IPagination from '@/interfaces/pagination.interface'

export default class UserService extends ApiService {
  async getUsers(page: number, size: number): Promise<IPagination<IUser>> {
    try {
      const res = await this.api.get('/users', {
        params: {
          page,
          size
        }
      })
      return res.data
    } catch (error) {
      return Promise.reject(error)
    }
  }

  async getUser(userId: string): Promise<IUser> {
    try {
      const res = await this.api.get('/users/' + userId)
      return res.data
    } catch (error) {
      return Promise.reject(error)
    }
  }

  async updateUser(userId: string, data: IUserCreate): Promise<IUser> {
    try {
      const res = await this.api.put('/users/' + userId, data)
      return res.data
    } catch (error) {
      return Promise.reject(error)
    }
  }

  async deleteUser(userId: string): Promise<void> {
    try {
      await this.api.delete('/users/' + userId)
    } catch (error) {
      return Promise.reject(error)
    }
  }

  async create(user: IUserCreate): Promise<IUser> {
    try {
      const res = await this.api.post('/users', user)
      return res.data
    } catch (error) {
      return Promise.reject(error)
    }
  }
}
