import { useRouter } from 'vue-router'
import { Role } from '@/enums/role.enum'
import { useUser } from './useUser'
import type { RouteMeta } from 'vue-router'

export const usePermission = () => {
  const { user } = useUser()
  const router = useRouter()

  function hasPagePermission(name: string) {
    if (!user) {
      return false
    }

    const role = user.role
    const route = router.getRoutes().find((e) => e.name?.toString() === name)
    const meta = route?.meta as RouteMeta

    if (!route || !meta.permissions) {
      return true
    }

    const permissions = meta.permissions as Role[]

    if (permissions.length < 1 || permissions.includes(Role.ALL)) {
      return true
    }

    return permissions.includes(role as Role)
  }

  function isAdmin() {
    return user?.role === Role.ADMIN
  }

  function isUser() {
    return user?.role === Role.USER
  }

  return {
    isUser,
    isAdmin,
    hasPagePermission
  }
}
