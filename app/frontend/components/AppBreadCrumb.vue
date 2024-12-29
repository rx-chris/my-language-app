<script setup lang="ts">
import {
    Breadcrumb,
    BreadcrumbItem,
    BreadcrumbList,
    BreadcrumbPage,
    BreadcrumbSeparator,
} from '@/components/ui/breadcrumb'
import { Link } from '@inertiajs/vue3'
import { cn } from '@/lib/utils'
import { BookOpenCheck } from 'lucide-vue-next';

interface BreadCrumbProps {
    title: string,
    href?: string,
    maxChar?: null,
}

interface Props {
    breadCrumbProps: BreadCrumbProps[]
}

const { breadCrumbProps } = defineProps<Props>()

</script>

<template>
    <Breadcrumb :class="cn('mb-3', $attrs.class ?? '')">
        <BreadcrumbList>
            <BreadcrumbItem>
                <Link href="/curricula" class="transition-colors hover:text-foreground">
                <BookOpenCheck :size="16" />
                </Link>
            </BreadcrumbItem>
            <template v-for="(prop, index) in breadCrumbProps">
                <BreadcrumbSeparator />
                <BreadcrumbItem>
                    <Link v-if="index < (breadCrumbProps.length - 1)" :href="prop.href!"
                        class="transition-colors hover:text-foreground">
                    {{ prop.title }}
                    </Link>
                    <BreadcrumbPage v-else class="font-semibold">
                        {{ prop.title }}
                    </BreadcrumbPage>
                </BreadcrumbItem>
            </template>
        </BreadcrumbList>
    </Breadcrumb>
</template>