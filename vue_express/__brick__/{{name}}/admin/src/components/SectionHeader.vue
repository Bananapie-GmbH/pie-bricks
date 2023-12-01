<template>
  <div>
    <h2>{{ title }}</h2>
    <p class="my-2">{{ subtitle }}</p>
  </div>
</template>

<script setup lang="ts">
defineProps({
  title: {
    type: String,
    default: ''
  },
  subtitle: {
    type: String,
    default: ''
  }
})
</script>

<style scoped></style>
