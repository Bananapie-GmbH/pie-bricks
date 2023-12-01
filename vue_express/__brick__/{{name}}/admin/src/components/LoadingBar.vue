<template>
  <v-row class="fill-height" align-content="center" justify="center">
    <v-col class="text-subtitle-1 text-center" cols="12"> {{ text }} </v-col>
    <v-col cols="6">
      <v-progress-linear color="primary" indeterminate rounded height="6"></v-progress-linear>
    </v-col>
  </v-row>
</template>

<script setup lang="ts">
defineProps({
  text: {
    type: String,
    default: 'Loading...'
  }
})
</script>

<style scoped></style>
