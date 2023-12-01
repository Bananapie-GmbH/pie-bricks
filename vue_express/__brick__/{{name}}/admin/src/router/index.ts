import { createRouter, createWebHistory } from 'vue-router'
import { RouteName, RoutePath } from './route_info'
import navigationRoutes from './navigation'
import { useLayout } from '@/composables/useLayout'
import { useView } from '@/composables/useView'
import { useStore } from '@/stores/useStore'
import { useApi } from '@/composables/useApi'
import routes from './routes'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: RoutePath.HOME,
      name: RouteName.HOME,
      component: useLayout('DefaultLayout'),
      meta: {
        authRequired: true
      },
      redirect: { name: RouteName.WELCOME },
      children: [...navigationRoutes, ...routes]
    },
    {
      path: RoutePath.LOGIN,
      name: RouteName.LOGIN,
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: useView('LoginView')
    },
    {
      path: '/:pathMatch(.*)*',
      name: 'error',
      component: useView('ErrorView')
    }
  ]
})

router.beforeEach(async (to, from, next) => {
  const metaTo = to.meta

  // if (!metaTo?.authRequired) {
  //   return next()
  // }

  const store = useStore()
  const api = useApi()
  let user = store.user

  if (!user) {
    try {
      user = await api.auth.me()
      store.setUser(user)
    } catch (err) {
      console.log(err)
    }
  }

  if (to.name !== 'login' && metaTo?.authRequired && !user) {
    return next({ name: 'login' })
  } else if (to.name === 'login' && user) {
    return next({ name: 'home' })
  }

  next()
})

export default router
