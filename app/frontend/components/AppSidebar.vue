<script setup lang="ts">
import { Link } from '@inertiajs/vue3'
import {
    Sidebar,
    SidebarContent,
    SidebarFooter,
    SidebarHeader,
    SidebarMenu,
    SidebarMenuButton,
    SidebarMenuItem,
    SidebarRail,
    useSidebar,
} from './ui/sidebar';
import { Settings, MessageCircleQuestion, CircleUserRound, LogOut, BookOpenCheck, BookmarkCheck } from 'lucide-vue-next';

const { open } = useSidebar()

const headerMenuItems = [
    {
        title: "My Curricula",
        url: "/curricula",
        icon: BookOpenCheck
    },
    {
        title: "Bookmarks",
        url: "/bookmarks",
        icon: BookmarkCheck
    }
]

const footerMenuItems = [
    {
        title: "Settings",
        url: "#",
        icon: Settings
    },
    {
        title: "FAQ",
        url: "#",
        icon: MessageCircleQuestion
    },
    {
        title: "Account",
        url: "#",
        icon: CircleUserRound
    },
    {
        title: "Sign Out",
        url: "#",
        icon: LogOut
    },
]
</script>

<template>
    <Sidebar collapsible="icon" variant="floating">
        <SidebarHeader />
        <SidebarContent>
            <SidebarMenu>
                <template v-for="item in headerMenuItems" :key="item.title">
                    <Link :href="item.url">
                    <SidebarMenuItem :class="`flex justify-center`">
                        <SidebarMenuButton class="hover:bg-blue-900 mx-2">
                            <div :class="`flex items-center ${open ? 'gap-2 p-0' : ''}`">
                                <component :is="item.icon" :size="20" />
                                <span :class="`${open ? '' : 'hidden'}`">
                                    {{ item.title }}
                                </span>
                            </div>
                        </SidebarMenuButton>
                    </SidebarMenuItem>
                    </Link>
                </template>
            </SidebarMenu>
        </SidebarContent>
        <SidebarFooter>
            <SidebarMenu>
                <template v-for="item in footerMenuItems" :key="item.title">
                    <SidebarMenuItem>
                        <SidebarMenuButton class="hover:bg-blue-900">
                            <Link :href="item.url" class="flex gap-2">
                            <component :is="item.icon" :size="20" />
                            <span :class="`${open ? '' : 'hidden'}`">{{ item.title }}</span>
                            </Link>
                        </SidebarMenuButton>
                    </SidebarMenuItem>
                </template>
            </SidebarMenu>
        </SidebarFooter>
        <SidebarRail class="my-2 hover:bg-gray-300 rounded-md opacity-30 w-3 -translate-x-[1.125rem]" />
    </Sidebar>
</template>

<style>
div[data-sidebar="sidebar"] {
    background-color: rgb(23, 37, 84);
}

div[data-sidebar="sidebar"] * {
    color: white
}
</style>