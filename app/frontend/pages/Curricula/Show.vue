<script setup lang="ts">
import Layout from '@/layouts/Layout.vue';
import Container from '@/layouts/Container.vue';
import { Link, router } from '@inertiajs/vue3';
import { Card, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button'
import AppBreadCrumb from '@/components/AppBreadCrumb.vue';
import ConfirmButton from '@/components/ConfirmButton.vue';
import GenerateLessons from './components/GenerateLessons.vue';

defineOptions({ layout: [Layout, Container] })

interface Props {
    curriculum: any,
    generate_lessons_url: string,
    batch_create_lessons_url: string,
    blueprints: any
}

const {
    curriculum,
    generate_lessons_url,
    batch_create_lessons_url,
    blueprints
} = defineProps<Props>()

console.log(blueprints)

const breadCrumbProps = [{ title: curriculum.title }]
</script>
<template>
    <div>
        <!-- Breadcrumb -->
        <AppBreadCrumb :bread-crumb-props="breadCrumbProps" />

        <!-- Curriculum summary -->
        <div class="relative w-full border bg-orange-100 p-8 rounded-md shadow-md">
            <h1 class="text-3xl font-semibold mb-1">{{ curriculum.title }}</h1>
            <p class="text-muted-foreground text-sm mb-3">from {{ curriculum.start_date }} to {{ curriculum.end_date }}
            </p>
            <p>Learning objective:</p>
            <p class="mb-3">{{ curriculum.purpose }}</p>
            <div class="flex justify-end">
                <ConfirmButton @continue="router.delete(curriculum.url)">
                    <template v-slot:default>Delete Curriculum</template>
                    <template v-slot:description>
                        "{{ curriculum.title }}" will be permanently deleted and cannot be undone.
                    </template>
                </ConfirmButton>
            </div>
            <div class="absolute top-0 right-0 bg-orange-300 rounded-tr-md py-1 px-5 shadow-md">
                {{ curriculum.language.name }}
            </div>
        </div>
        <h2 class="my-5 text-2xl">Lessons:</h2>

        <!-- Lesson links -->
        <div v-if="curriculum.lessons.length" class="grid sm:grid-col md:grid-cols-3 lg:grid-cols-4 gap-6">
            <template v-for="lesson in curriculum.lessons">
                <Link :href="lesson.url">
                <Card class="flex flex-col justify-between min-h-[300px] hover:bg-gray-100">
                    <CardHeader>
                        <CardTitle class="text-xl">{{ lesson.title }}</CardTitle>
                        <CardDescription>{{ lesson.description }}</CardDescription>
                    </CardHeader>
                    <CardFooter class="flex justify-end">
                        <Button>Begin</Button>
                    </CardFooter>
                </Card>
                </Link>
            </template>
        </div>

        <!-- Render button to generate lessons if no lessons found -->
        <div v-else class="border rounded-md flex justify-center items-center h-[300px]">
            <div class="flex flex-col gap-3 items-center">
                <p class="text-muted-foreground text-lg">No lessons have been created for this curriculum yet.</p>
                <Button>Create a lesson</Button>
                <p>or</p>
                <GenerateLessons :curriculum="curriculum" :generate_lessons_url="generate_lessons_url"
                    :batch_create_lessons_url="batch_create_lessons_url" :blueprints="blueprints" />
            </div>
        </div>
    </div>
</template>


<style scoped></style>