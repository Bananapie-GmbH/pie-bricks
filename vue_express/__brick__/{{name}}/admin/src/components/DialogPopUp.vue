<template>
  <v-dialog
    persistent
    scrollable
    :fullscreen="fullscreen"
    :max-width="!fullscreen ? maxWidth : ''"
    :max-height="!fullscreen ? maxHeight : ''"
    :model-value="show"
    @update:model-value="update"
  >
    <v-card>
      <v-toolbar flat color="primary">
        <v-toolbar-title> <slot name="toolbar" /> </v-toolbar-title>
        <v-spacer />
        <slot name="toolbar-actions" />
      </v-toolbar>
      <v-card-text>
        <slot name="content" />
      </v-card-text>
      <v-card-actions>
        <v-spacer />
        <slot name="actions"></slot>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script setup lang="ts">
defineProps({
  show: {
    type: Boolean
  },
  fullscreen: {
    type: Boolean,
    default: false
  },
  maxHeight: {
    type: Number,
    default: 600
  },
  maxWidth: {
    type: Number,
    default: 600
  }
})

const emit = defineEmits(['update:show'])

const update = (event: any) => {
  emit('update:show', event)
}
</script>

<style scoped></style>
