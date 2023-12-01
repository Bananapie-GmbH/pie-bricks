<template>
  <div>
    <Scaffold :loading="isLoading">
      <template #default>
        <SectionHeader
          :title="userId ? 'Edit User' : 'Create User'"
          :subtitle="userId ? 'Update an users informations.' : 'Add a new user to your team.'"
        />
        <v-card>
          <v-form ref="formRef">
            <v-card-text>
              <v-text-field
                variant="outlined"
                v-model="form.email"
                label="Email"
                outlined
                :rules="[formRules.isEmail]"
                dense
                required
              />
              <v-text-field
                variant="outlined"
                :type="showPassword ? 'text' : 'password'"
                :disabled="userId != null"
                :append-inner-icon="showPassword ? mdiEye : mdiEyeOff"
                v-model="form.password"
                @click:append-inner="() => (showPassword = !showPassword)"
                label="Password"
                :rules="[formRules.isNotEmpty]"
                outlined
                dense
                required
              />
              <v-select
                variant="outlined"
                :items="utils.rolesToDropdown()"
                :rules="[formRules.isNotEmpty]"
                v-model="form.role"
                label="Role"
                outlined
                dense
                required
              />
            </v-card-text>
          </v-form>
          <v-card-actions>
            <v-spacer />
            <v-btn :loading="isSaving" variant="flat" color="success" @click="handleAction()">{{
              userId != null ? 'Save changes' : 'Save'
            }}</v-btn>
          </v-card-actions>
        </v-card>
      </template>
    </Scaffold>
  </div>
</template>

<script setup lang="ts">
import Scaffold from '@/components/Scaffold.vue'
import SectionHeader from '@/components/SectionHeader.vue'
import { useApi } from '@/composables/useApi'
import { useFormRules } from '@/composables/useFormRules'
import { useUtils } from '@/composables/useUtils'
import type { IUserCreate } from '@/interfaces/auth/user.interface'
import { mdiEye, mdiEyeOff } from '@mdi/js'
import { useAsyncState } from '@vueuse/core'
import { ref } from 'vue'
import { useRoute } from 'vue-router'
import { useRouter } from 'vue-router'

const utils = useUtils()
const formRules = useFormRules()
const api = useApi()
const formRef = ref(null)
const router = useRouter()
const showPassword = ref(false)
const route = useRoute()
const userId = ref<string>(route.params.id as string)
const isSaving = ref(false)
const form = ref<IUserCreate>({
  email: '',
  password: '',
  role: ''
})

const {
  state: user,
  isReady,
  isLoading,
  execute
} = useAsyncState(async () => {
  if (userId.value) {
    const user = await api.users.getUser(userId.value)
    form.value = {
      email: user.email,
      password: user.password,
      role: user.role
    }
    return user
  }
  return null
}, null)

async function handleAction() {
  if (!(formRef.value as any)?.validate()) {
    return
  }
  try {
    isSaving.value = true
    if (userId.value) {
      await updateUser()
    } else {
      await createUser()
    }
    router.push('/users')
  } catch (err) {
    console.log(err)
  }
  isSaving.value = false
}

async function createUser() {
  try {
    await api.users.create(form.value)
  } catch (e) {
    return Promise.reject(e)
  }

  isSaving.value = false
}

async function updateUser() {
  try {
    await api.users.updateUser(userId.value, form.value)
  } catch (e) {
    return Promise.reject(e)
  }

  isSaving.value = false
}
</script>

<style scoped></style>
