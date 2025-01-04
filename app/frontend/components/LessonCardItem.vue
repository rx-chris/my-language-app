<script setup lang="ts">
import { BookmarkCheck, Bookmark, CircleCheck, CircleX, LoaderCircle, BookOpenText, CircleDashed, CircleDotDashed } from 'lucide-vue-next';
import { Badge } from './ui/badge';

interface Props {
    card: any,
    mode?: string | null
}

const { card, mode = "learning" } = defineProps<Props>()

const isLearningMode = () => mode === 'learning';

</script>
<template>
    <div
        class="flex justify-between items-center p-3 border rounded-md gap-3 shadow-md bg-orange-100 hover:bg-orange-200">
        <div class="flex justify-center w-10">
            <BookmarkCheck v-if="card.bookmarked" />
            <Bookmark v-else class="text-muted-foreground opacity-50" />
        </div>
        <div class="grow">
            {{ isLearningMode() ? card.model_text_answer : card.blueprint.instruction }}
        </div>
        <Badge v-if="!isLearningMode()">
            {{ card.blueprint.name }}
        </Badge>
        <div class="flex justify-center w-10">
            <BookOpenText v-if="isLearningMode()" class="text-muted-foreground" />
            <CircleDotDashed v-else-if="card.correct === null" class="text-muted-foreground animate-pulse" />
            <CircleCheck v-else-if="card.correct" class="text-green-600" />
            <CircleX v-else class="text-red-600" />
        </div>
    </div>
</template>


<style scoped></style>