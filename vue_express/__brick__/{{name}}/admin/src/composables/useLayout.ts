export const useLayout = (layout: string) => {
  return () => import(`../layouts/${layout}.vue`)
}
