import type { RouteRecordRaw } from 'vue-router'
import { Role } from '@/enums/role.enum'
import { mdiAccount, mdiCog, mdiHome } from '@mdi/js'
import { useEmptyView } from '@/composables/useEmptyView'
import { useView } from '@/composables/useView'

/* 

Routes which are added here can be accessed via useNavigator() composable.
The routes are also used to generate the navigation menu.

*/
const navigationRoutes: RouteRecordRaw[] = [
  {
    path: '/welcome',
    name: 'welcome',
    component: useView('WelcomeView'),
    meta: {
      permissions: [Role.ALL],
      title: 'Welcome',
      icon: mdiHome
    }
  },
  {
    path: '/users',
    name: 'users',
    component: useView('UserManagementView'),
    meta: {
      permissions: [Role.ADMIN],
      title: 'Users',
      icon: mdiAccount
    }
  },
  {
    path: '/settings',
    name: 'settings',
    component: useView('SettingsView'),
    meta: {
      title: 'Settings',
      icon: mdiCog
    }
  }
  /* Nested Routes example
  {
    path: '/parent',
    name: 'parent',
    component: useEmptyView(),
    meta: {
      permissions: [Role.ADMIN],
      title: 'Welcome',
      icon: mdiHome
    },
    children: [
      {
        path: '/parent',
        name: 'parent-root',
        component: useView('ParentView'),
        meta: {
          title: 'ParentView',
          icon: mdiCog
        }
      },
      {
        path: '/parent/other',
        name: 'parent-other',
        component: useView('OtherView'),
        meta: {
          title: 'OtherView',
          icon: mdiCog
        }
      }
    ]
  }
  */
]

export default navigationRoutes
