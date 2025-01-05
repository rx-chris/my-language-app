<script setup lang="ts">
import Layout from '@/layouts/Layout.vue';
import Container from '@/layouts/Container.vue';
import LessonCardItem from '@/components/LessonCardItem.vue';
import { Link } from '@inertiajs/vue3';

defineOptions({ layout: [Layout, Container] })

interface Props {
    curricula: any;
}

const {
    curricula,
} = defineProps<Props>()

console.log(curricula)

const headingId = (heading: string) => heading.toLowerCase().replaceAll(/\s+/g, '-')
</script>

<template>
    <div class="flex">
        <div class="w-[400px]">
            <h1 class="text-3xl mb-6 font-bold">My Bookmarks</h1>
            <ol class="list-decimal">
                <li v-for="curriculum in curricula" :key="curriculum.id">
                    <a :href="`#${headingId(curriculum.title)}`"
                        class="mt-1 text-md font-light underline hover:font-normal">
                        {{ curriculum.title }}
                    </a>
                </li>
            </ol>
        </div>
        <div class="w-full shrink flex flex-col space-y-6">
            <div v-for="curriculum in curricula" :key="curriculum.id">
                <h2 :id="headingId(curriculum.title)" class="text-2xl font-semibold">{{ curriculum.title }}</h2>
                <template v-for="lesson in curriculum.lessons" :key="lesson.id">
                    <h3 class="text-lg my-3 font-normal">{{ lesson.title }}</h3>
                    <Link v-for="card in lesson.cards" :key="card.id" :href="card.learning_url">
                    <LessonCardItem :card="card" mode="learning" class="mt-1.5" />
                    </Link>
                </template>
            </div>
        </div>
    </div>
</template>

<style scoped></style>