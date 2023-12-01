import { Role } from '@/enums/role.enum'

export const useUtils = () => {
  const tableSizeOptions = [
    { value: 10, title: '10' },
    { value: 25, title: '25' },
    { value: 50, title: '50' },
    { value: 100, title: '100' }
  ]

  function getRandomArbitrary(min: number, max: number) {
    return Math.random() * (max - min) + min
  }

  function rolesToDropdown() {
    return Object.values(Role)
      .map((e) => {
        return { value: e, title: e }
      })
      .filter((e) => e.value !== Role.ALL)
  }

  return {
    tableSizeOptions,
    getRandomArbitrary,
    rolesToDropdown
  }
}
