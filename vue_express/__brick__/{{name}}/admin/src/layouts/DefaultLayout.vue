<template>
  <v-app>
    <v-navigation-drawer v-model="drawer" permanent :expand-on-hover="!pinMenu" :rail="!pinMenu">
      <v-list-item :title="getUsername()" nav>
        <template #prepend>
          <v-avatar v-if="user?.profilePicture" class="avatar mr-2 flex-shrink-0"> </v-avatar>
          <v-avatar v-else color="primary">
            <span class="white--text">{{ getShortName() }}</span>
          </v-avatar>
        </template>
        <template #append>
          <v-btn
            size="small"
            variant="text"
            :icon="!pinMenu ? mdiPin : mdiPinOff"
            @click.stop="pinMenu = !pinMenu"
          ></v-btn>
        </template>
      </v-list-item>
      <v-divider></v-divider>
      <v-list v-model:opened="open" nav density="compact">
        <template v-for="item in navigation" :key="item.pageName">
          <v-list-group v-if="item.children.length > 0" :value="item.pageName" :title="item.title">
            <template #activator="{ props }">
              <v-list-item
                v-bind="props"
                :prepend-icon="item.icon"
                :title="item.title"
              ></v-list-item>
            </template>
            <v-list-item
              v-for="itemChild in item.children"
              :key="itemChild.pageName"
              :to="itemChild.pagePath"
              link
              :active="isActive(itemChild.pageName)"
              color="secondary"
            >
              <v-list-item-title>{{ itemChild.title }}</v-list-item-title>
            </v-list-item>
          </v-list-group>
          <v-list-item
            v-else
            :to="item.pagePath"
            link
            :active="isActive(item.pageName)"
            color="secondary"
          >
            <template #prepend>
              <v-icon color="black" :icon="item.icon" />
            </template>
            <v-list-item-title>{{ item.title }}</v-list-item-title>
          </v-list-item>
        </template>
      </v-list>
    </v-navigation-drawer>

    <v-app-bar color="primary">
      <v-app-bar-title>Admin Dashboard</v-app-bar-title>
    </v-app-bar>

    <v-main>
      <v-container fluid>
        <router-view />
      </v-container>
    </v-main>
  </v-app>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useUser } from '@/composables/useUser'
import { mdiPin, mdiPinOff } from '@mdi/js'
import { useNavigation } from '@/composables/useNavigation'
import { useRouter } from 'vue-router'
const drawer = ref(true)
const { getUsername, user, getShortName } = useUser()
const router = useRouter()
const pinMenu = ref(true)
const open = ref<string[]>([])
const { navigation } = useNavigation()

function isActive(name: string) {
  const currentPath = router.currentRoute.value.name

  return name === currentPath
}
</script>
