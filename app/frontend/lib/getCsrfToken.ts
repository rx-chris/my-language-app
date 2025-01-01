export default function getCsrfToken() {
    const csrfToken = document.querySelector("[name='csrf-token']") as HTMLMetaElement
    
    return csrfToken?.content
}