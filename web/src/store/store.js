import { writable } from "svelte/store";

export const config = writable([]);
export const debugModus = writable(false);
export const language = writable([]);
export const debugData = writable([]);
export const currentMenu = writable();
export const clothing = writable([]);
export const showNotify = writable();
export const createdZonePoints = writable([]);
export const filter = writable([]);
export const currentZone = writable({});
export const isLoading = writable(false);

export const removeCloting = (id) => {
    clothing.update((clothing) => {
        return clothing.filter((item) => item.id !== id);
    });
};


export function loading(duration) {;
    if(!duration) duration = 2000;
    isLoading.set(true);
    setTimeout(() => {
       isLoading.set(false)
    }, duration);
}