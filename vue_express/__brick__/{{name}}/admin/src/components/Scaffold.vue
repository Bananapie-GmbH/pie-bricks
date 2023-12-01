<template>
  <div>
    <LoadingBar v-if="loading" :text="loadingText" />
    <div v-else>
      <slot />
    </div>
  </div>
</template>

<script setup lang="ts">
import LoadingBar from './LoadingBar.vue'

defineProps({
  loading: {
    type: Boolean,
    default: false
  },
  loadingText: {
    type: String,
    default: 'Loading...'
  }
})
</script>

<style scoped></style>
