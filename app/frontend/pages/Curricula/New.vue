<script setup lang="ts">
import Layout from '@/layouts/Layout.vue';
import Container from '@/layouts/Container.vue';
import { Label } from '@/components/ui/label';
import { Input } from '@/components/ui/input';
import { Button } from '@/components/ui/button'
import { Textarea } from '@/components/ui/textarea';
import { useForm } from '@inertiajs/vue3'
import DateRangePicker from '@/components/DateRangePicker.vue';
import SelectList from '@/components/SelectList.vue';

defineOptions({ layout: [Layout, Container] })

interface Props {
    curriculum: any,
    curricula_url: string,
    languages: any[]
}

const { curriculum, curricula_url, languages } = defineProps<Props>()
curriculum.start_date = '2024-12-29';
curriculum.end_date = '2025-01-07';
console.log(curriculum);

const form = useForm(curriculum)

const languageList = languages.map(({ id, name }) => ({ value: id, label: name }))

</script>
<template>
    <div class="w-[600px] mx-auto border rounded-md shadow p-12 bg-white">
        <h1 class="text-2xl font-semibold text-center mb-3">New curriculum</h1>
        <form @submit.prevent="form.post(curricula_url)" class="flex flex-col gap-3">
            <!-- languages -->
            <div class="flex flex-col gap-2">
                <Label class=" block">Language:</Label>
                <SelectList v-model="form.language_id" :list-items="languageList" placeholder="Select a language" />
                <div v-if="form.errors.language" class="text-red-500 text-sm">**{{ form.errors.language.join(", ") }}
                </div>
            </div>
            <!-- title -->
            <div class="flex flex-col gap-2">
                <Label for="title">Title:</Label>
                <Input type="text" id="title" v-model="form.title" placeholder="Name your curriculum" />
                <div v-if="form.errors.title" class="text-red-500 text-sm">**{{ form.errors.title.join(", ") }}</div>
            </div class="flex flex-col gap-2">
            <!-- purpose -->
            <div>
                <Label for=" purpose">Purpose:</Label>
                <Textarea id="purpose" v-model="form.purpose"
                    placeholder="Describe your motivation for learning this language" />
                <div v-if="form.errors.purpose" class="text-red-500 text-sm">
                    **{{ form.errors.purpose.join(", ") }}
                </div>
            </div>
            <!-- start date & end date -->
            <div class="flex flex-col gap-2">
                <Label class=" block">Dates:</Label>
                <DateRangePicker v-model:start-date="form.start_date" v-model:end-date="form.end_date" />
                <div v-if="form.errors.start_date" class="text-red-500 text-sm">
                    **{{ form.errors.start_date.join(", ") }}
                </div>
            </div>
            <div class="mt-6 flex justify-end">
                <Button type="submit">
                    Create Curriculum
                </Button>
            </div>
        </form>
    </div>
    <!-- <button @click="() => { console.log(form.data()); console.log(form.end_date.toString()) }">test</button> -->
</template>


<style scoped></style>