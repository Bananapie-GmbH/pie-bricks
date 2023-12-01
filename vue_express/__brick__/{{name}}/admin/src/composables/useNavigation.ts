import { NavigationItem } from '@/interfaces/navigation/navigation_item.interface'
import { usePermission } from '@/composables/usePermission'
import { ref } from 'vue'
import { type RouteRecordRaw } from 'vue-router'
import navigationRoutes from '@/router/navigation'

export const useNavigation = () => {
  const { hasPagePermission } = usePermission()

  function routeToNavigationItem(
    route: RouteRecordRaw,
    children?: RouteRecordRaw[]
  ): NavigationItem {
    const meta = route.meta
    return {
      icon: meta?.icon,
      title: meta?.title,
      pageName: route.name,
      pagePath: route.path,
      children: children?.map((e) => routeToNavigationItem(e)) ?? []
    } as NavigationItem
  }

  function getAccessablePages() {
    const navigation = []

    for (const item of navigationRoutes) {
      if (item.children && item.children.length > 0) {
        const children = item.children.filter((e: any) =>
          hasPagePermission(e.name?.toString() ?? '')
        )

        if (children.length > 0 || item.meta?.isGroup) {
          navigation.push(routeToNavigationItem(item, children))
        }
      } else if (item.name && hasPagePermission(item.name.toString())) {
        navigation.push(routeToNavigationItem(item))
      }
    }

    return navigation
  }

  return {
    navigation: ref<NavigationItem[]>(getAccessablePages())
  }
}
