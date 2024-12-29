<script setup lang="ts">
import Layout from '@/layouts/Layout.vue';
import Container from '@/layouts/Container.vue';
import { Link } from '@inertiajs/vue3';
import { Card, CardDescription, CardFooter, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button'
import AppBreadCrumb from '@/components/AppBreadCrumb.vue';

defineOptions({ layout: [Layout, Container] })

interface Props {
    curriculum: any
}

const { curriculum } = defineProps<Props>()

const breadCrumbProps = [{ title: curriculum.title }]
</script>
<template>
    <div>
        <!-- Breadcrumb -->
        <AppBreadCrumb :bread-crumb-props="breadCrumbProps" />
        <!-- Curriculum summary -->
        <div class="relative w-full border bg-orange-100 p-8 rounded-md shadow-md">
            <h1 class="text-3xl font-semibold">{{ curriculum.title }}</h1>
            <p>from {{ curriculum.start_date }} to {{ curriculum.end_date }}</p>
            <p>Purpose: {{ curriculum.purpose }}</p>
            <p>Context: {{ curriculum.Context }}</p>
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
        <div v-else class="border rounded-md flex justify-center items-center h-[300px]">
            <div class="flex flex-col gap-3 items-center">
                <p>No lessons have been created for this curriculum yet</p>
                <Button>Generate Lessons</Button>
            </div>
        </div>
    </div>
</template>


<style scoped></style>