<template>
  <v-container class="fill-height">
    <v-row justify="center">
      <v-col cols="12" md="4" align="center">
        <v-form @submit.prevent="login()" v-model="form">
          <v-card>
            <v-toolbar color="primary">
              <v-toolbar-title>Admin</v-toolbar-title>
            </v-toolbar>
            <v-card-text>
              <v-text-field
                :rules="[isEmail]"
                label="E-Mail"
                variant="outlined"
                color="primary"
                v-model="email"
                class="mb-2"
              />
              <v-text-field
                :rules="[isNotEmpty]"
                :type="showPassword ? 'text' : 'password'"
                :append-inner-icon="showPassword ? mdiEye : mdiEyeOff"
                @click:append-inner="() => (showPassword = !showPassword)"
                label="Password"
                variant="outlined"
                color="primary"
                v-model="password"
              />
            </v-card-text>
            <v-card-actions>
              <v-btn type="submit" :loading="loading" block variant="flat" color="success"
                >Sign in</v-btn
              >
            </v-card-actions>
          </v-card>
        </v-form>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup lang="ts">
import { mdiEye, mdiEyeOff } from '@mdi/js'
import { ref } from 'vue'
import { useFormRules } from '@/composables/useFormRules'
import { useApi } from '@/composables/useApi'
import { useStore } from '@/stores/useStore'
import { useRouter } from 'vue-router'

const email = ref('')
const password = ref('')
const showPassword = ref(false)
const form = ref(false)
const loading = ref(false)
const { isEmail, isNotEmpty } = useFormRules()
const api = useApi()
const store = useStore()
const router = useRouter()

async function login() {
  if (!form.value) return

  loading.value = true

  try {
    const user = await api.auth.login(email.value, password.value)
    store.setUser(user)
    router.push({ path: '/welcome' })
  } catch (error) {
    console.log(error)
  }

  loading.value = false
}
</script>

<style></style>
