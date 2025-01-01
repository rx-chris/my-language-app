<script setup lang="ts">
import { Button } from '@/components/ui/button'
import {
    Dialog,
    DialogScrollContent,
    DialogDescription,
    DialogFooter,
    DialogHeader,
    DialogTitle,
    DialogTrigger
} from '@/components/ui/dialog'
import { Textarea } from '@/components/ui/textarea'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { router, useForm } from '@inertiajs/vue3'
import getCsrfToken from '@/lib/getCsrfToken'
import { ref } from 'vue'
import { Loader } from 'lucide-vue-next'
import { Checkbox } from '@/components/ui/checkbox'

// define props
interface Props {
    curriculum: any
    generate_lessons_url: string
    batch_create_lessons_url: string
    blueprints: any
}

const {
    curriculum,
    generate_lessons_url,
    batch_create_lessons_url,
    blueprints
} = defineProps<Props>()

// define form data
interface GenerateLessonsData {
    language_id: number
    lesson_count: number
    learning_objective: string
}

enum FormState {
    Loading,
    Generate,
    LessonsList,
    SelectBlueprints
}

const form = useForm<GenerateLessonsData>({
    language_id: curriculum.language_id,
    lesson_count: 0,
    learning_objective: ''
})

const lessons = ref<{ title: string; description: string }[]>([
    { title: 'test', description: 'test' },
    { title: 'test', description: 'test' }
])
const generateCards = ref(true)
const formState = ref(FormState.LessonsList)
const selectAllBlueprints = ref(true)
const selectedBlueprints = ref<
    {
        id: number
        checked: boolean
    }[]
>(blueprints.map(({ id }: { id: number }) => ({ id, checked: true })))

// event handlers
const generateLessons = async () => {
    formState.value = FormState.Loading
    const response = await fetch(generate_lessons_url, {
        method: 'POST',
        body: JSON.stringify(form.data()),
        headers: {
            'Content-Type': 'application/json',
            Accept: 'application/json',
            'X-CSRF-Token': getCsrfToken()
        }
    })
    if (response.ok) {
        lessons.value = (await response.json()).lessons
        formState.value = FormState.LessonsList
    }
    console.log(response)
}

const batchCreateLessons = () => {
    console.log('called')
    router.post(batch_create_lessons_url, {
        lessons: lessons.value,
        curriculum_id: curriculum.id
    })
}
</script>

<template>
    <Dialog>
        <DialogTrigger as-child>
            <Button> Generate lessons with AI </Button>
        </DialogTrigger>
        <DialogScrollContent class="sm:max-w-[600px]">
            <DialogHeader>
                <DialogTitle>Edit profile</DialogTitle>
                <DialogDescription>
                    Make changes to your profile here. Click save when you're done.
                </DialogDescription>
            </DialogHeader>

            <!-- Page 1: Form to generate lessons with Open AI -->
            <form v-if="formState === FormState.Generate" @submit.prevent="generateLessons">
                <div>
                    <Label>How many lessons do you want to generate?</Label>
                    <Input type="number" v-model="form.lesson_count" />
                </div>
                <div class="flex flex-col gap-2">
                    <Label for="learning_objective">What do I want to learn?</Label>
                    <Textarea id="learning_objective" v-model="form.learning_objective"></Textarea>
                </div>
                <DialogFooter>
                    <Button type="submit"> Generate Lessons </Button>
                    <Button v-if="lessons.length > 0" type="button" @click="() => (formState = FormState.LessonsList)">
                        Next
                    </Button>
                </DialogFooter>
            </form>

            <!-- Page 2: Display lessons generated from Open AI -->
            <form v-else-if="formState === FormState.LessonsList">
                <ul class="flex flex-col gap-2 mb-3 sm:max-h-[400px] overflow-y-auto">
                    <li v-for="(lesson, index) in lessons" :key="index" class="border p-4 rounded-2xl">
                        <h2 class="text-xs font-semibold">{{ lesson.title }}:</h2>
                        <p class="text-xs">{{ lesson.description }}</p>
                    </li>
                </ul>
                <div class="flex items-center gap-2">
                    <Checkbox id="generate_cards" class="ml-3" v-model:checked="generateCards" />
                    <Label for="generate_cards" class="text-muted-foreground">
                        Auto-generate lesson cards with AI
                    </Label>
                </div>
                <DialogFooter>
                    <Button type="button" @click="() => (formState = FormState.Generate)">Go back</Button>
                    <Button v-if="generateCards" type="button"
                        @click="() => (formState = FormState.SelectBlueprints)">Next</Button>
                    <Button v-else type="button" @click="batchCreateLessons">Create Lessons</Button>
                </DialogFooter>
            </form>

            <!-- Page 3: Form to select card blueprints for card generation with Open AI -->
            <form v-else-if="formState === FormState.SelectBlueprints">
                <ul>
                    <li class="flex items-center gap-1 mb-4 ml-3">
                        <Checkbox id="selectAllBlueprints" v-model:checked="selectAllBlueprints"
                            @update:checked="(checked) => selectedBlueprints = selectedBlueprints.map(x => ({ ...x, checked }))" />
                        <Label for="selectAllBlueprints">
                            Select All
                        </Label>
                    </li>
                    <hr>
                    <li v-for="(blueprint, index) in blueprints" :key="blueprint.id"
                        class="flex items-center gap-1 my-2 ml-3">
                        <Checkbox :id="`blueprint_${blueprint.id}`" :value="blueprint.id.toString()"
                            v-model:checked="selectedBlueprints[index].checked" />
                        <Label :for="`blueprint_${blueprint.id}`">
                            {{ blueprint.name }}
                        </Label>
                    </li>
                    <DialogFooter>
                        <Button type="button" @click="() => (formState = FormState.LessonsList)">Go back</Button>
                        <Button type="button" @click="batchCreateLessons">Create Lessons</Button>
                    </DialogFooter>
                    <button type="button"
                        @click="console.log(selectedBlueprints.filter(x => x.checked).map(x => x.id))">
                        test
                    </button>
                </ul>
            </form>
            <div v-else class="flex items-center justify-center">
                <Loader class="animate-spin" :size="30" />
            </div>
        </DialogScrollContent>
    </Dialog>
</template>
