<script setup lang="ts">
import { cn } from '@/lib/utils';
import { computed, ref } from 'vue';
import { Label } from '@/components/ui/label';

// proprs
interface Props {
    id: number;
    user_answer_id: number | null;
    model_answer_id: number;
}

const { id, user_answer_id, model_answer_id } = defineProps<Props>();

// v-model
const model = defineModel()

// button state
enum ButtonState {
    Correct,
    Wrong,
    Neutral,
    Unanswered
}

const getButtonState = () => {
    if (user_answer_id === null) return ButtonState.Unanswered;
    if (id === model_answer_id) return ButtonState.Correct;
    if (id === user_answer_id && user_answer_id !== model_answer_id) return ButtonState.Wrong;
    return ButtonState.Neutral
}

const buttonState = ref<ButtonState>(getButtonState());

// button styles based on button state
const buttonStyles = computed(() => {
    switch (buttonState.value) {
        case ButtonState.Unanswered:
            return "hover:bg-slate-200";
        case ButtonState.Correct:
            return "bg-green-200"
        case ButtonState.Wrong:
            return "bg-red-200"
        case ButtonState.Neutral:
            return "text-muted-foreground"
        default:
            return ""
    }
})

const disabled = computed(() => buttonState.value !== ButtonState.Unanswered)
</script>

<template>
    <div :class="cn('border rounded-md', buttonStyles)">
        <input type="radio" :id="`mcq_option_${id}`" :value="id" v-model="model" class="hidden" :disabled="disabled" />
        <Label :for="`mcq_option_${id}`" class="block w-full text-center p-3">
            <slot></slot>
        </Label>
    </div>
</template>

<style scoped>
div:has(>input[type="radio"]:checked) {
    background-color: orange;
}
</style>