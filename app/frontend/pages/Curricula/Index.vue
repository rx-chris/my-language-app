<script setup lang="ts">
import Layout from '@/layouts/Layout.vue';
import Container from '@/layouts/Container.vue';
import { buttonVariants } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Link } from '@inertiajs/vue3'
import ProgressRing from '@/components/ProgressRing.vue';

defineOptions({ layout: [Layout, Container] })

interface Props {
  curricula: any,
  new_curriculum_url: string
}

const { curricula, new_curriculum_url } = defineProps<Props>()
</script>

<template>
  <div class="max-w-[800px] mx-auto">
    <div class="flex items-center justify-between mb-10">
      <h1 class="font-bold text-4xl">My Curricula</h1>
      <Link :href="new_curriculum_url" :class="buttonVariants()">+ New Curriculum</Link>
    </div>

    <div class="flex flex-col gap-3 items-center">
      <template v-for="curriculum in curricula" :key="curriculum.id">
        <Link :href="curriculum.url" class="w-full">
        <Card class="w-full">
          <CardContent class="flex justify-between p-6">
            <CardHeader>
              <CardTitle class="text-xl">{{ curriculum.title }}</CardTitle>
              <CardDescription>Number of lessons: {{ curriculum.lessons.length }}</CardDescription>
              <CardDescription>Purpose: {{ curriculum.purpose }}</CardDescription>
            </CardHeader>
            <ProgressRing :value="0.7" size="10rem" :options="{
              cutout: '60%',
              backgroundColor: [
                'rgb(255, 99, 132)',
                'rgb(54, 162, 235)'
              ],
              borderWidth: 5,
            }" />
          </CardContent>
        </Card>
        </Link>
      </template>
    </div>
  </div>
</template>


<style scoped></style>
