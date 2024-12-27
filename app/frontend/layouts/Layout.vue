<template>
    <div>
        <SidebarProvider :defaultOpen="true">
            <AppSidebar />
            <main style="width: calc(100vw - var(--sidebar-width-icon) - 2.5rem);">
                <slot></slot>
            </main>
        </SidebarProvider>
    </div>
</template>

<script setup lang="ts">
import AppSidebar from '@/components/AppSidebar.vue';
import { SidebarProvider } from '@/components/ui/sidebar';
</script>

<style scoped></style>