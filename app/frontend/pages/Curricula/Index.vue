<script setup lang="ts">
import Layout from '@/layouts/Layout.vue';
import Container from '@/layouts/Container.vue';
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Link } from '@inertiajs/vue3'
import ProgressRing from '@/components/ProgressRing.vue';

defineOptions({ layout: [Layout, Container] })

interface Props {
  curricula: any
}

const { curricula } = defineProps<Props>()
</script>

<template>
  <h1 class="font-bold text-4xl">My Curricula</h1>

  <Button>+ New Curriculum</Button>

  <template v-for="curriculum in curricula" :key="curriculum.id">
    <Link :href="curriculum.url">
    <Card class="w-full">
      <CardContent class="flex justify-between p-6">
        <CardHeader>
          <CardTitle>{{ curriculum.title }}</CardTitle>
          <CardDescription>Number of lessons: {{ curriculum.lessons.length }}</CardDescription>
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
</template>


<style scoped></style>
