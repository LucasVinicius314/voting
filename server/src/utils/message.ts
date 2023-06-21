export function createMessage(message: string): string {
    return JSON.stringify({ message: message });
}