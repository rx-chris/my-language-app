<script setup lang="ts">
import { BookmarkCheck, Bookmark, CircleCheck, CircleX, LoaderCircle } from 'lucide-vue-next';
import { Badge } from './ui/badge';

interface Props {
    card: any
}

const { card } = defineProps<Props>()
</script>
<template>
    <div
        class="flex justify-between items-center p-3 border rounded-md gap-3 shadow-md bg-orange-100 hover:bg-orange-200">
        <div class="flex justify-center w-10">
            <BookmarkCheck v-if="card.bookmarked" />
            <Bookmark v-else class="text-muted-foreground opacity-50" />
        </div>
        <div class="grow">
            {{ card.blueprint.instruction }}
        </div>
        <Badge>
            {{ card.blueprint.name }}
        </Badge>
        <div class="flex justify-center w-10">
            <LoaderCircle v-if="card.correct === null" class="animate-spin text-muted-foreground" />
            <CircleCheck v-else-if="card.correct" class="text-green-600 animate-pulse" />
            <CircleX v-else class="text-red-600 animate-pulse" />
        </div>
    </div>
</template>


<style scoped></style>