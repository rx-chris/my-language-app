<script setup lang="ts">
import Layout from '@/layouts/Layout.vue';
import Container from '@/layouts/Container.vue';
import { Link } from '@inertiajs/vue3';
import { Input } from '@/components/ui/input';
import { Button } from '@/components/ui/button'
import AppBreadCrumb from '@/components/AppBreadCrumb.vue';
import { BookmarkCheck } from 'lucide-vue-next';

defineOptions({ layout: [Layout, Container] })

interface Props {
    card: any
}

const { card } = defineProps<Props>()

const capitalize = (word: string) => word.charAt(0).toUpperCase() + word.slice(1);

const breadCrumbProps = [
    {
        title: card.lesson.curriculum.title,
        href: card.lesson.curriculum.url
    },
    {
        title: card.lesson.title,
        href: card.lesson.url
    },
    {
        title: `${capitalize(card.mode)} Card`
    }
]
</script>
<template>
    <div>
        <!-- Breadcrumb -->
        <div class="flex justify-between items-center">
            <AppBreadCrumb :bread-crumb-props="breadCrumbProps" />
        </div>
        <div class="relative border rounded-md shadow w-full min-h-80 mt-5">
            {{ card.text_content }}
            <button class="absolute top-4 right-4">
                <BookmarkCheck />
            </button>
        </div>
        <p class="text-center my-3">{{ card.instruction }}</p>

        <form>
            <div class="my-3 mx-5">
                <Input placeholder="Type your answer here" />
            </div>
            <div class="flex justify-center">
                <div class="flex gap-3 items-center">
                    <Button type="submit">Answer</Button>
                    <Link href="#">Next</Link>
                </div>
            </div>
        </form>
    </div>
</template>

<style scoped></style>