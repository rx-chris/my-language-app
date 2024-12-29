<script setup lang="ts">
import type { DateRange } from 'radix-vue'
import { Button } from '@/components/ui/button'

import { Popover, PopoverContent, PopoverTrigger } from '@/components/ui/popover'
import { RangeCalendar } from '@/components/ui/range-calendar'
import { cn } from '@/lib/utils'
import {
    DateFormatter,
    getLocalTimeZone,
    parseDate
} from '@internationalized/date'
import { CalendarIcon } from '@radix-icons/vue'
import { computed } from 'vue'

const startDate = defineModel<string>('startDate', { required: true });
const endDate = defineModel<string>('endDate', { required: true });

const df = new DateFormatter('en-US', { dateStyle: 'medium' })

const dateRange = computed({
    get(): DateRange {
        return {
            start: startDate.value ? parseDate(startDate.value) : undefined,
            end: endDate.value ? parseDate(endDate.value) : undefined,
        }
    },
    set(newValue) {
        startDate.value = newValue.start?.toString() ?? "";
        endDate.value = newValue.end?.toString() ?? "";
    }
})

</script>
<template>
    <Popover>
        <PopoverTrigger as-child>
            <Button variant="outline" :class="cn(
                'w-[280px] justify-start text-left font-normal',
                !dateRange && 'text-muted-foreground',
            )">
                <CalendarIcon class="mr-2 h-4 w-4" />
                <template v-if="dateRange.start">
                    <template v-if="dateRange.end">
                        {{ df.format(dateRange.start.toDate(getLocalTimeZone())) }} - {{
                            df.format(dateRange.end.toDate(getLocalTimeZone())) }}
                    </template>

                    <template v-else>
                        {{ df.format(dateRange.start.toDate(getLocalTimeZone())) }}
                    </template>
                </template>
                <template v-else>
                    Pick a date
                </template>
            </Button>
        </PopoverTrigger>
        <PopoverContent class="w-auto p-0">
            <RangeCalendar v-model="dateRange" initial-focus :number-of-months="2"
                @update:start-value="(startDate) => dateRange = { ...dateRange, start: startDate }" />
        </PopoverContent>
    </Popover>
</template>

<style scoped></style>