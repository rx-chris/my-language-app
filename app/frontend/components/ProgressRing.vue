<script setup lang="ts">
import Chart from 'chart.js/auto'
import { computed, onMounted, ref } from 'vue';
import type { Ref } from 'vue';

interface Props {
    value: number
    size?: string
    options?: object
}

const { value = 0, size = '100%', options = {} } = defineProps<Props>()

const progressValue = computed(() => `${(value * 100).toFixed(1)}%`)

type K = HTMLCanvasElement | null
const ctx: Ref<K, K> = ref(null);

onMounted(() => {
    new Chart(ctx.value!, {
        type: 'doughnut',
        data: {
            datasets: [{
                data: [value, 1.0 - value],
                ...options
            }]
        },
    });
})
</script>

<template>
    <div :style="`width: ${size}; height: ${size};`" class="relative flex justify-center align-middle">
        <canvas ref="ctx"></canvas>
        <div class="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2">{{ progressValue }}</div>
    </div>
</template>

<style scoped></style>