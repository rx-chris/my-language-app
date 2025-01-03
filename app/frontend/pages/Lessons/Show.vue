<script setup lang="ts">
import Layout from '@/layouts/Layout.vue';
import Container from '@/layouts/Container.vue';
import { Link } from '@inertiajs/vue3';
import { Card, CardContent, CardDescription, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button'
import ProgressRing from '@/components/ProgressRing.vue';
import LessonCardItem from '@/components/LessonCardItem.vue';
import AppBreadCrumb from '@/components/AppBreadCrumb.vue';

defineOptions({ layout: [Layout, Container] })

interface Props {
    lesson: any
}

const { lesson } = defineProps<Props>()

const breadCrumbProps = [
    {
        title: lesson.curriculum.title,
        href: lesson.curriculum.url
    },
    {
        title: lesson.title,
    }
]
</script>

<template>
    <div>
        <!-- Breadcrumb -->
        <AppBreadCrumb :bread-crumb-props="breadCrumbProps" />
        <!-- Lesson Summary -->
        <Card>
            <CardContent class="flex p-6 gap-12">
                <div class="flex flex-col justify-between grow">
                    <div>
                        <CardTitle class="text-4xl">{{ lesson.title }}</CardTitle>
                        <CardDescription class="my-4">{{ lesson.description }}</CardDescription>
                    </div>
                    <div class="flex gap-3">
                        <Button>Learn</Button>
                        <Button>Begin Quiz</Button>
                        <Button>Next Lesson</Button>
                    </div>
                </div>
                <div>
                    <ProgressRing :value="0.75" size="200px" />
                </div>
            </CardContent>
        </Card>

        <h2 class="mb-2 mt-4 text-xl font-semibold">Cards:</h2>
        <!-- Cards -->
        <div class="flex flex-col gap-1.5 mt-3">
            <template v-for="card in lesson.cards" :key="card.id">
                <Link :href="card.learning_url">
                <LessonCardItem :card="card" />
                </Link>
            </template>
        </div>
    </div>
</template>

<style scoped></style>