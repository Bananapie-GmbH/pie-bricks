import type { AxiosInstance } from 'axios'

export default class ApiService {
  api: AxiosInstance
  constructor(api: AxiosInstance) {
    this.api = api
  }
}
