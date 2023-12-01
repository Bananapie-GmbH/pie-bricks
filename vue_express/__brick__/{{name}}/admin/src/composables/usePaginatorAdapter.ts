import type IPagination from '@/interfaces/pagination.interface'
import { ref } from 'vue'

type PaginatorFetchOptions<T> = {
  fetch: (page: number, size: number) => Promise<IPagination<T>>
  initialSize?: number
}

export const usePaginatorAdapter = <T>(fetchOptions: PaginatorFetchOptions<T>) => {
  const page = ref(1)
  const size = ref(fetchOptions.initialSize ?? 10)
  const lastPage = ref(0)
  const isLoadingMore = ref(false)
  const pending = ref(false)

  async function fetch(): Promise<IPagination<T>> {
    try {
      // Subtract one from page because the backend starts to count at 0
      pending.value = true
      const data = await fetchOptions.fetch(page.value - 1, size.value)
      pending.value = false
      return data
    } catch (err) {
      pending.value = false
      return Promise.reject(err)
    }
  }

  function hasMore(prev: IPagination<T>) {
    return page.value - 1 < prev.totalPages
  }

  async function loadMore(prev: IPagination<T>, top?: boolean) {
    if (!hasMore(prev)) {
      return prev
    }

    try {
      isLoadingMore.value = true
      nextPage()
      const pagination = await fetchOptions.fetch(page.value - 1, size.value)
      if (top) {
        pagination.data = [...pagination.data, ...prev.data]
      } else {
        pagination.data = prev.data.concat(pagination?.data ?? [])
      }

      isLoadingMore.value = false
      return pagination
    } catch (err) {
      isLoadingMore.value = false
      return Promise.reject(err)
    }
  }

  function setPage(index: number) {
    lastPage.value = page.value
    page.value = index
  }

  function nextPage() {
    lastPage.value = page.value
    page.value++
  }

  function prevPage() {
    if (page.value > 0) {
      page.value--
    }
  }

  function clear() {
    page.value = 1
    lastPage.value = 1
  }

  return {
    nextPage,
    prevPage,
    hasMore,
    clear,
    loadMore,
    fetch,
    page,
    size,
    lastPage,
    isLoadingMore,
    pending,
    setPage
  }
}
