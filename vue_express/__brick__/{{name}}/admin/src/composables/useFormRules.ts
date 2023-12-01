export const useFormRules = () => {
  function isEmail(v: string) {
    if (!v) {
      return 'Please enter e-mail'
    }

    if (!/.+@.+\..+/.test(v)) {
      return 'Please use a valide e-mail address.'
    }

    return true
  }

  function isNotEmpty(v: string) {
    if (!v) {
      return 'This field is required'
    }

    return true
  }

  function isMin(v: string, min: number, message: string) {
    return v.length >= min || `${message}`
  }

  function isMax(v: string, max: number, message: string) {
    return v.length <= max || `${message}`
  }

  return {
    isMin,
    isMax,
    isEmail,
    isNotEmpty
  }
}
