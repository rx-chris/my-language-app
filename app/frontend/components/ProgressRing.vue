<script setup lang="ts">
import { templateRef } from '@vueuse/core';
import Chart from 'chart.js/auto'
import { computed, onMounted } from 'vue';

interface Props {
    value: number
    size?: string
    options?: object
}

const { value = 0, size = '100%', options = {} } = defineProps<Props>()

const progressValue = computed(() => `${(value * 100).toFixed(1)}%`)

const ctx = templateRef('ctx');

onMounted(() => {
    new Chart(ctx.value!, {
        type: 'doughnut',
        data: {
            datasets: [{
                data: [value, 1.0 - value],
                backgroundColor: [
                    'rgb(104, 222, 136)',
                    'rgb(225, 225, 225)',
                ],
                ...options
            }]
        },
        options: {
            aspectRatio: 1,
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    callbacks: {
                        label: (item) => `${(Number(item.formattedValue) * 100).toFixed(1)}%`
                    }
                }
            }
        }
    });
})
</script>

<template>
    <div :style="`width: ${size}; height: ${size};`" class="relative flex justify-center items-center">
        <canvas ref="ctx"></canvas>
        <div class="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2">{{ progressValue }}</div>
    </div>
</template>

<style scoped></style>