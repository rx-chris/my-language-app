<script setup lang="ts">
import Layout from '@/layouts/Layout.vue';
import Container from '@/layouts/Container.vue';
import { Link, useForm } from '@inertiajs/vue3';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Button, buttonVariants } from '@/components/ui/button'
import AppBreadCrumb from '@/components/AppBreadCrumb.vue';
import { BookmarkCheck, Bookmark } from 'lucide-vue-next';
import getCsrfToken from '@/lib/getCsrfToken';

// ----------------------------------------------------------
// Props
// ----------------------------------------------------------

defineOptions({ layout: [Layout, Container] })

interface Props {
    card: any;
    prev_card_url: string;
    next_card_url: string;
    bookmark_card_url: string;
}

const {
    card,
    prev_card_url,
    next_card_url,
    bookmark_card_url
} = defineProps<Props>()

console.log(card)
console.log(next_card_url)

// create breadcrumb
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

// methods to check content type
const isAudioContent = () => card.blueprint.content_type === 'audio_content';
const isImageContent = () => card.blueprint.content_type === 'image_content';

// methods to check input type
const isMcqInput = () => card.blueprint.input_type === 'mcq';

// methods to check mode
const isLearningMode = () => card.mode === "learning";
const isTestMode = () => card.mode === "test";

const form = useForm({
    user_answer: ""
})

// event handler
const toggleBookmark = async () => {
    const response = await fetch(bookmark_card_url, {
        method: 'PATCH',
        headers: {
            'Content-Type': 'application/json',
            Accept: 'application/json',
            'X-CSRF-Token': getCsrfToken()
        }
    });

    if (!response.ok) return;
    card.bookmarked = !card.bookmarked
}
</script>
<template>
    <div>
        <!-- Breadcrumb -->
        <div class="flex justify-between items-center">
            <AppBreadCrumb :bread-crumb-props="breadCrumbProps" />
        </div>
        <!-- Render card content based on content type -->
        <div class="relative flex items-center justify-center border rounded-md shadow w-full min-h-80 mt-5 p-12">
            <div>
                <audio v-if="isAudioContent()" controls autoplay>
                    <source :src="card.audio_url" type="audio/mpeg" />
                    Your browser does not support the audio element.
                </audio>
                <img v-else-if="isImageContent()" :src="card.image_url" alt="card_image"
                    class="rounded-md max-w-[600px]" />
                <div v-else class="text-center font-semibold text-3xl">
                    {{ card.text_content }}
                </div>
                <p v-if="isLearningMode()" class="text-center mt-4 text-3xl">{{ card.model_answer }}</p>
            </div>
            <button type="button" @click="toggleBookmark" class="absolute top-4 right-4 hover:scale-110">
                <BookmarkCheck v-if="card.bookmarked" />
                <Bookmark v-else class="text-muted-foreground" />
            </button>
        </div>

        <template v-if="isTestMode()">
            <p class="text-center my-3">{{ card.blueprint.instruction }}</p>
            <form>
                <!-- Render inputs based on input type -->
                <template v-if="isMcqInput()">
                    <div class="flex justify-center m-6">
                        <div class="grid grid-cols-4 gap-4">
                            <div v-for="mcqOption in card.mcq_options" :key="mcqOption.id"
                                class="border rounded-md hover:bg-slate-200">
                                <input type="radio" :id="`mcq_option_${mcqOption.id}`" :value="mcqOption.id"
                                    v-model="form.user_answer" class="hidden" />
                                <Label :for="`mcq_option_${mcqOption.id}`" class="block w-full text-center p-3">
                                    {{ mcqOption.text_content }}
                                </Label>
                            </div>
                        </div>
                    </div>
                </template>
                <template v-else>
                    <div class="my-3 mx-5">
                        <Input placeholder="Type your answer here" />
                    </div>
                </template>
                <!-- answer and next buttons -->
                <div class="flex justify-center">
                    <div class="flex gap-3 items-center">
                        <Link :href="prev_card_url" :class="buttonVariants()">Previous</Link>
                        <Button type="submit">Answer</Button>
                        <Link :href="next_card_url" :class="buttonVariants()">Next</Link>
                    </div>
                </div>
            </form>
        </template>
        <template v-else-if="isLearningMode()">
            <!-- answer and next buttons -->
            <div class="flex justify-center gap-3">
                <Link :href="prev_card_url" :class="buttonVariants()">Previous</Link>
                <Link :href="next_card_url" :class="buttonVariants()">Next</Link>
            </div>
        </template>
    </div>
</template>

<style scoped>
div:has(>input[type="radio"]:checked) {
    background-color: orange;
}
</style>