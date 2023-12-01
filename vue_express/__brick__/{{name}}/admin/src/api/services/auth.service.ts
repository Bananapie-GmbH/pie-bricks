import type { IUser } from '@/interfaces/auth/user.interface'
import ApiService from '../utils/api_service'

export default class AuthService extends ApiService {
  async isInitialized(): Promise<{ initialized: boolean }> {
    try {
      const res = await this.api.get('/init')
      return res.data
    } catch (error) {
      return Promise.reject(error)
    }
  }

  async login(email: string, password: string): Promise<IUser> {
    try {
      const res = await this.api.post('/login', { email, password })
      return res.data
    } catch (error) {
      return Promise.reject(error)
    }
  }

  async logout(): Promise<void> {
    try {
      await this.api.post('/logout')
    } catch (error) {
      return Promise.reject(error)
    }
  }

  async register(email: string, password: string): Promise<void> {
    try {
      await this.api.post('/register', { email, password })
    } catch (error) {
      return Promise.reject(error)
    }
  }

  async me(): Promise<IUser> {
    try {
      const res = await this.api.get('/me')
      return res.data
    } catch (error) {
      return Promise.reject(error)
    }
  }
}
