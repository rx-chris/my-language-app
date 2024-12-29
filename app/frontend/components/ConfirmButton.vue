<script setup lang="ts">
import {
    AlertDialog,
    AlertDialogAction,
    AlertDialogCancel,
    AlertDialogContent,
    AlertDialogDescription,
    AlertDialogFooter,
    AlertDialogHeader,
    AlertDialogTitle,
    AlertDialogTrigger,
} from '@/components/ui/alert-dialog'
import { Button } from '@/components/ui/button'

defineOptions({ inheritAttrs: false })

const emit = defineEmits(['cancel', 'continue'])

</script>
<template>
    <AlertDialog>
        <AlertDialogTrigger as-child>
            <Button v-bind="{ ...$attrs }">
                <slot></slot>
            </Button>
        </AlertDialogTrigger>
        <AlertDialogContent>
            <AlertDialogHeader>
                <AlertDialogTitle>
                    <slot name="title">Are you absolutely sure?</slot>
                </AlertDialogTitle>
                <AlertDialogDescription>
                    <slot name="description">
                        This action is permanent and cannot be undone.
                    </slot>
                </AlertDialogDescription>
            </AlertDialogHeader>
            <AlertDialogFooter>
                <AlertDialogCancel @click="$emit('cancel')">
                    <slot name="cancel">Cancel</slot>
                </AlertDialogCancel>
                <AlertDialogAction @click="$emit('continue')">
                    <slot name="continue">Continue</slot>
                </AlertDialogAction>
            </AlertDialogFooter>
        </AlertDialogContent>
    </AlertDialog>
</template>


<style scoped></style>