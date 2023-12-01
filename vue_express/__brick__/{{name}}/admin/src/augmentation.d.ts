import 'vue-router'
import API from './api/api'
// To ensure it is treated as a module, add at least one `export` statement
export {}

declare module 'vue-router' {
  interface RouteMeta {
    authRequired?: boolean
    icon?: string
    permissions?: Role[]
    isGroup?: boolean
    title?: string
  }
}

declare module 'vue' {
  interface ComponentCustomProperties {
    $api: API
  }
}
