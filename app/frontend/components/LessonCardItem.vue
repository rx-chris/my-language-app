<script setup lang="ts">
import { BookmarkCheck, CircleCheck, CircleX, LoaderCircle } from 'lucide-vue-next';
import { computed } from 'vue';
import { Badge } from './ui/badge';

interface Props {
    card: any
}

const { card } = defineProps<Props>()

const statusIcon = computed(() => {
    if (card.correct === null) return LoaderCircle
    return card.correct ? CircleCheck : CircleX
})
</script>
<template>
    <div
        class="flex justify-between items-center p-3 border rounded-md gap-3 shadow-md bg-orange-100 hover:bg-orange-200">
        <div class="w-10">
            <BookmarkCheck />
        </div>
        <div class="grow">
            {{ card.blueprint.instruction }}
        </div>
        <Badge>
            {{ card.blueprint.name }}
        </Badge>
        <div>
            <component :is="statusIcon" />
        </div>
    </div>
</template>


<style scoped></style>