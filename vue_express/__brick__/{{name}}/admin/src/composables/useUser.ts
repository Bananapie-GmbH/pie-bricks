import { useStore } from '@/stores/useStore'

export const useUser = () => {
  const store = useStore()

  const getUsername = () => {
    return store.user?.email ?? 'Anonymous'
  }

  const getShortName = () => {
    if (store.user && store.user.username) {
      return store.user.username[0]
    }

    return ''
  }

  return {
    getShortName,
    getUsername,
    user: store.user
  }
}
