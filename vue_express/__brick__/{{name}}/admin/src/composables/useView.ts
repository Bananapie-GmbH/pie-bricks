export const useView = (view: string) => {
  return () => import(`../views/${view}.vue`)
}
