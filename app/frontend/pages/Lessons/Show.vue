<script setup lang="ts">
import Layout from '@/layouts/Layout.vue';
import Container from '@/layouts/Container.vue';
import { Link } from '@inertiajs/vue3';
import { Card, CardContent, CardDescription, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button'
import { Label } from '@/components/ui/label';
import ProgressRing from '@/components/ProgressRing.vue';
import LessonCardItem from '@/components/LessonCardItem.vue';
import AppBreadCrumb from '@/components/AppBreadCrumb.vue';
import { Switch } from '@/components/ui/switch';
import { ref } from 'vue';

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

const isLearningMode = ref(true)
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

        <!-- Cards -->
        <div class="flex items-center gap-4 mb-2 mt-6">
            <h2 class="text-xl font-semibold grow">Cards:</h2>
            <Label for="mode">{{ isLearningMode ? 'Learning' : 'Quiz' }} Mode</Label>
            <Switch id="mode" v-model:checked="isLearningMode" />
        </div>
        <div class="flex flex-col gap-1.5 mt-3">
            <template v-for="card in lesson.cards" :key="card.id">
                <Link :href="isLearningMode ? card.learning_url : card.test_url">
                <LessonCardItem :card="card" />
                </Link>
            </template>
        </div>
    </div>
</template>

<style scoped></style>