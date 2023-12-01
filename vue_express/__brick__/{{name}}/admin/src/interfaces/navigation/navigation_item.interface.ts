type NavigationItemOptions = {
  icon: string
  title: string
  pageName: string
  pagePath: string
  children: NavigationItem[]
}

export class NavigationItem {
  icon: string
  title: string
  pageName: string
  pagePath: string
  children: NavigationItem[]
  constructor(options: NavigationItemOptions) {
    this.icon = options.icon
    this.title = options.title
    this.pageName = options.pageName
    this.pagePath = options.pagePath
    this.children = options.children
  }
}
