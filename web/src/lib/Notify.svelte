<!-- Notification.svelte -->
<script>
    import { fade } from 'svelte/transition';
    import { afterUpdate } from 'svelte';
    import { showNotify,debugModus } from '../store/store';
  
    export let message = '';
    export let type = 'info';
    export let duration = 3000;
  
    const types = {
      info: 'bg-blue-500',
      success: 'bg-green-500',
      warning: 'bg-yellow-500',
      error: 'bg-red-500',
    };
  
    let show = true;
  
    const closeNotification = () => {
      show = false;
      showNotify.set('')
    };
  
    afterUpdate(() => {
      if (show && duration !== Infinity) {
        setTimeout(() => {
          closeNotification();
        }, duration);
      }
    });
  </script>
  
  {#if show}
    <div
      class="notify_box {type}"
      transition:fade
      on:outroend={closeNotification}
    >
    <span class="notify_box_message">{message}</span>
    <button class="notify_box_close" on:click={closeNotification}>
      <span class="material-symbols-outlined">
        cancel
        </span>
    </button>
    </div>
  {/if}