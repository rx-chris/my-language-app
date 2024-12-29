<script setup lang="ts">
import {
    Select,
    SelectContent,
    SelectItem,
    SelectTrigger,
    SelectValue,
} from '@/components/ui/select'

interface Props {
    listItems: {
        value: string,
        label: string
    }[],
    placeholder?: string
}

const { listItems, placeholder = "Select a value" } = defineProps<Props>()

const selectedValue = defineModel<string>();

</script>
<template>
    <Select v-model="selectedValue">
        <SelectTrigger>
            <SelectValue :placeholder="placeholder" />
        </SelectTrigger>
        <SelectContent>
            <template v-for="item in listItems" :key="item.value">
                <SelectItem :value="item.value.toString()">
                    {{ item.label }}
                </SelectItem>
            </template>
        </SelectContent>
    </Select>
</template>


<style scoped></style>