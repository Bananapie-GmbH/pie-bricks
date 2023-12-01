<template>
  <div>
    <SectionHeader
      title="User Management"
      subtitle="Manage and configure roles for your team members."
    />
    <v-card>
      <v-toolbar>
        <v-spacer />
        <v-btn @click="openCreateUser()" variant="flat" color="success"
          >New <v-icon :icon="mdiPlus"
        /></v-btn>
      </v-toolbar>
      <v-card-text>
        <v-data-table-server
          v-model:page="page"
          v-model:items-per-page="size"
          :headers="headers"
          :items="state?.data"
          must-sort
          :items-per-page-options="utils.tableSizeOptions"
          :items-length="state?.count ?? 0"
        >
          <template #[`item.createdAt`]="{ item }">
            {{ new Date(item.createdAt).toLocaleString('de-DE') }}
          </template>
          <template #[`item.actions`]="{ item }">
            <v-btn @click="editUser(item.id)" icon variant="flat" size="small"
              ><v-icon :icon="mdiPen"></v-icon
            ></v-btn>
            <v-btn @click="openDeletePopup(item.id)" icon variant="flat" size="small"
              ><v-icon color="error" :icon="mdiDelete"></v-icon
            ></v-btn>
          </template>
        </v-data-table-server>
      </v-card-text>
    </v-card>

    <DialogPopUp v-model:show="showDeletePopup">
      <template #toolbar>
        <span>Delete User</span>
      </template>
      <template #content>
        <p>Do you really want to delete this user?</p>
      </template>
      <template #actions>
        <v-btn @click="showDeletePopup = false" variant="flat">Cancel</v-btn>
        <v-btn :loading="isDeleting" @click="deleteUser()" variant="flat" color="error"
          >Delete</v-btn
        >
      </template>
    </DialogPopUp>
  </div>
</template>

<script setup lang="ts">
import { useApi } from '@/composables/useApi'
import { useUtils } from '@/composables/useUtils'
import { usePaginatorAdapter } from '@/composables/usePaginatorAdapter'
import { useAsyncState } from '@vueuse/core'
import { watch } from 'vue'
import { mdiDelete, mdiPen, mdiPlus } from '@mdi/js'
import { useRouter } from 'vue-router'
import SectionHeader from '@/components/SectionHeader.vue'
import { ref } from 'vue'
import DialogPopUp from '@/components/DialogPopUp.vue'

const api = useApi()
const utils = useUtils()
const router = useRouter()
const isDeleting = ref(false)
const userDeleteId = ref('')
const showDeletePopup = ref(false)
const { page, fetch, size } = usePaginatorAdapter({
  fetch: async (page, size) => {
    console.log('NEW PAGE', page)
    return await api.users.getUsers(page, size)
  }
})
const { state, isReady, isLoading } = useAsyncState(async () => {
  return await fetch()
}, null)

watch([page, size], async () => {
  state.value = await fetch()
})

const headers: any = [
  {
    title: 'E-Mail',
    align: 'start',
    sortable: true,
    key: 'email'
  },
  {
    title: 'Role',
    align: 'start',
    sortable: true,
    key: 'role'
  },
  {
    title: 'Registered',
    align: 'start',
    sortable: true,
    key: 'createdAt'
  },
  {
    title: 'Actions',
    align: 'start',
    sortable: true,
    key: 'actions'
  }
]

function editUser(userId: string) {
  router.push(`/users/${userId}`)
}

function openDeletePopup(userId: string) {
  userDeleteId.value = userId
  showDeletePopup.value = true
}

async function deleteUser() {
  if (!userDeleteId.value) {
    return
  }
  isDeleting.value = true
  try {
    await api.users.deleteUser(userDeleteId.value)
    showDeletePopup.value = false
    state.value = await fetch()
  } catch (e) {
    console.log(e)
  }
  isDeleting.value = false
}

function openCreateUser() {
  router.push('/users/create')
}
</script>
