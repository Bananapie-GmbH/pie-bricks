import API from '@/api/api'

const api = new API(import.meta.env.VITE_BASE_API_URL as string)

export const useApi = () => {
  return api
}
