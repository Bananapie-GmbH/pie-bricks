import { ref } from 'vue'
import { defineStore } from 'pinia'
import type { IUser } from '@/interfaces/auth/user.interface'

export const useStore = defineStore('store', () => {
  const user = ref<IUser>()

  function setUser(newUser: IUser) {
    user.value = newUser
  }

  return { user, setUser }
})
