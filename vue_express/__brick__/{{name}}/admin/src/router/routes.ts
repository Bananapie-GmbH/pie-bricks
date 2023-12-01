import type { RouteRecordRaw } from 'vue-router'
import { Role } from '@/enums/role.enum'
import { useView } from '@/composables/useView'

/* 

Routes which are not appearing in the navigation menu can be added here.

*/
const routes: RouteRecordRaw[] = [
  {
    path: '/users/create',
    name: 'users-create',
    component: useView('CreateUserView'),
    meta: {
      permissions: [Role.ADMIN]
    }
  },
  {
    path: '/users/:id',
    name: 'users-edit-id',
    component: useView('CreateUserView'),
    meta: {
      permissions: [Role.ADMIN]
    }
  }
]

export default routes
