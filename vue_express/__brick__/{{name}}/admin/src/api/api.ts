import axios, { type AxiosInstance } from 'axios'
import ApiService from './utils/api_service'
import AuthService from './services/auth.service'
import { useRouter } from 'vue-router'
import { RoutePath } from '@/router/route_info'
import { useCookies } from '@vueuse/integrations/useCookies'
import router from '@/router'
import UserService from './services/user.service'

export default class API {
  axios: AxiosInstance
  services: ApiService[] = []
  cookies = useCookies()
  auth: AuthService
  users: UserService

  constructor(baseURL: string) {
    this.axios = axios.create({
      withCredentials: true,
      xsrfHeaderName: 'X-Csrf-Token',
      xsrfCookieName: 'CSRF',
      headers: {
        'Content-Type': 'application/json'
      },
      baseURL,
      responseType: 'json'
    })

    this.auth = new AuthService(this.axios)
    this.users = new UserService(this.axios)
    this.setUpInterceptors()
  }

  setUpInterceptors() {
    this.axios.interceptors.response.use(
      (config) => {
        return config
      },
      async (error) => {
        const originalRequest = error.config

        if (error.response && error.response.status === 401) {
          try {
            await this.axios.post('/refresh')
            return axios(originalRequest)
          } catch (err: any) {
            if (
              router.currentRoute.value.path !== RoutePath.LOGIN &&
              router.currentRoute.value.path !== '/' &&
              err.response.status === 403
            ) {
              // store.dispatch(StoreAction.FORBIDDEN_DIALOG, true)
              console.log('Forbidden')
            }
          }
        } else {
          return Promise.reject(error)
        }
      }
    )

    this.axios.interceptors.request.use((config) => {
      config.headers['x-csrf-token'] = this.cookies.get('CSRF')
      return config
    })
  }
}
