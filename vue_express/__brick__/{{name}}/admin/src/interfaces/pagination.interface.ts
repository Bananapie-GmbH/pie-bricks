export default interface IPagination<T> {
  data: T[]
  count: number
  totalPages: number
  page: number
}
