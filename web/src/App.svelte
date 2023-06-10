<script>
  import {
    config,
    debugModus,
    language,
    debugData,
    currentMenu,
    clothing,
    isLoading,
  } from "./store/store.js";

  import ToolBox from "./lib/ToolBox.svelte";
  import BossMenu from "./lib/BossMenu.svelte";
  import Garage from "./lib/Garage.svelte";
  import Lager from "./lib/Lager.svelte";
  import Clothing from "./lib/Clothing.svelte";
  import { fetchNui } from "./store/fetch.js";
  import Notify from "./lib/Notify.svelte";
  import { showNotify } from "./store/store.js";

  let cMenu = "clothingmenu";
  let useNotify;

  let notifications = {
    error: {
      type: "error",
      message: "Ein Fehler ist aufgetreten",
    },
    success: {
      type: "success",
      message: "Erfolgreich gespeichert",
    },
    update: {
      type: "update",
      message: "Erfolgreich geupdated",
    },
    remove: {
      type: "error",
      message: "Erfolgreich gelöscht!",
    },
    add: {
      type: "success",
      message: "Erfolgreich hinzugefügt!",
    },
  };

  $debugModus = true;

  if ($debugModus) {
    function getRandomInt(max) {
      return Math.floor(Math.random() * max);
    }
    useNotify = true;
    console.log("[DEBUG] Debug Modus is enabled");
    let newId = 0;
    // @ts-ignore
    debugData.set({
      // @ts-ignore
      lang: {
        heading_title: "Jerzy's Tool Box",
        close: "Schließen",
        open: "Öffnen",
        menu: "Menu Öffnen",
        clothing_menu: "Kleidungschrank",
        garage_menu: "Garagen Optionen",
        boss_menu: "Boss Optionen",
        lager_menu: "Lager Optionen",
        search: "Suche nach etwas",
        clothing_items: {
          title: "Willkommen beim Kleidungs Menu",
          description: "Hier kannst du deine Kleidungsmenü anpassen",
          create: "Erstelle einen Kleidungspunkt",
          menu: "Tabelle Anzeigen",
          search: "Suche nach Klamotten Menü",
          table: {
            edit: "Editieren",
            menu: "Tabelle anzeigen",
            remove: "Löschen",
            name: "ID",
            fraction: "Fraktion",
            action: "Aktion",
          },
          modal: {
            title: "Kleidungspunkt bearbeiten",
            name: "Bezeichnung (Bsp: fraktion_clothing_1)",
            coords: "Koordinationen (Bsp: vec4(0,0,0,0)",
            blip: "Blip anzeigen?",
            points: "Trigger Punkte (Bsp: vec3(0,0,0)",
            placeholder_points: "vec3(0,0,0)",
            addPoints: "Trigger Punkte hinzufügen",
            removePoints: "Trigger Punkte entfernen",
            create: "Zone Erstellen",
            save: "Zone Speichern",
          },
        },
        boss: {
          title: "Willkommen beim Boss Menu",
          description: "Hier kannst du deine Boss Optionen anpassen",
        },
        garage: {
          title: "Willkommen beim Garagen Menu",
          description: "Hier kannst du deine Garagen Optionen anpassen",
        },
        lager: {
          title: "Willkommen beim Lager Menu",
          description: "Hier kannst du deine Lager Optionen anpassen",
        },
      },
      clothing: [
        {
          id: getRandomInt(1000),
          zoneName: "fib_punkt_1" + getRandomInt(1000),
          showBlip: false,
          zone: "vector3(0,0,0)",
          faction: "fib",
          points: ["vector3(0,0,0)", "vector3(0,0,0)", "vector3(0,0,0)"],
        },
        {
          id: getRandomInt(100),
          zoneName: "police_punkt_1" + getRandomInt(1900),
          showBlip: false,
          zone: "vector3(0,0,0)",
          faction: "fib",
          points: ["vector3(0,0,0)", "vector3(0,0,0)", "vector3(0,0,0)"],
        },
        {
          id: getRandomInt(1500),
          zoneName: "job_punkt_1" + getRandomInt(10660),
          showBlip: false,
          zone: "vector3(0,0,0)",
          faction: "fib",
          points: ["vector3(0,0,0)", "vector3(0,0,0)", "vector3(0,0,0)"],
        },
        {
          id: getRandomInt(100),
          zoneName: "test_punkt_" + getRandomInt(1040),
          showBlip: false,
          zone: "vector3(0,0,0)",
          faction: "fib",
          points: ["vector3(0,0,0)", "vector3(0,0,0)", "vector3(0,0,0)"],
        },
        {
          id: getRandomInt(1500),
          zoneName: "asd_punkt_1" + getRandomInt(1040),
          showBlip: false,
          zone: "vector3(0,0,0)",
          faction: "fib",
          points: ["vector3(0,0,0)", "vector3(0,0,0)", "vector3(0,0,0)"],
        },
        {
          id: getRandomInt(1200),
          zoneName: "asd_punkt_1" + getRandomInt(1300),
          showBlip: false,
          zone: "vector3(0,0,0)",
          faction: "fib",
          points: ["vector3(0,0,0)", "vector3(0,0,0)", "vector3(0,0,0)"],
        },
        {
          id: getRandomInt(1200),
          zoneName: "asd_punkt_1" + getRandomInt(1200),
          showBlip: false,
          zone: "vector3(0,0,0)",
          faction: "fib",
          points: ["vector3(0,0,0)", "vector3(0,0,0)", "vector3(0,0,0)"],
        },
        {
          id: getRandomInt(100),
          zoneName: "asd_punkt_1" + getRandomInt(1050),
          showBlip: false,
          zone: "vector3(0,0,0)",
          faction: "fib",
          points: ["vector3(0,0,0)", "vector3(0,0,0)", "vector3(0,0,0)"],
        },
        {
          id: getRandomInt(1007),
          zoneName: "asd_punkt_1" + getRandomInt(1500),
          showBlip: false,
          zone: "vector3(0,0,0)",
          faction: "fib",
          points: ["vector3(0,0,0)", "vector3(0,0,0)", "vector3(0,0,0)"],
        },
        {
          id: getRandomInt(1020),
          zoneName: "asd_punkt_1" + getRandomInt(1050),
          showBlip: false,
          zone: "vector3(0,0,0)",
          faction: "fib",
          points: ["vector3(0,0,0)", "vector3(0,0,0)", "vector3(0,0,0)"],
        },
        {
          id: getRandomInt(1900),
          zoneName: "asd_punkt_1" + getRandomInt(1070),
          showBlip: false,
          zone: "vector3(0,0,0)",
          faction: "fib",
          points: ["vector3(0,0,0)", "vector3(0,0,0)", "vector3(0,0,0)"],
        },
      ],
    });
    // @ts-ignore
    clothing.set($debugData.clothing);
    language.set($debugData.lang);
  }

  function setMenu(menu) {
    currentMenu.set(menu);
    cMenu = menu;
  }

  function refresh() {
    clothing.set([]);
    show = false;
  }

  debugData.set({
    // @ts-ignore
    lang: {
      heading_title: "Jerzy's Tool Box",
      close: "Schließen",
      open: "Öffnen",
      menu: "Menu Öffnen",
      clothing_menu: "Kleidungschrank",
      garage_menu: "Garagen Optionen",
      boss_menu: "Boss Optionen",
      lager_menu: "Lager Optionen",
      search: "Suche nach etwas",
      clothing_items: {
        title: "Willkommen beim Kleidungs Menu",
        description: "Hier kannst du deine Kleidungsmenü anpassen",
        create: "Erstelle einen Kleidungspunkt",
        menu: "Tabelle Anzeigen",
        search: "Suche nach Klamotten Menü",
        moreInfos: "Mehr Infos",
        titleTab: "Kleidungspunkt",
        fraction: 'Fraktion',
        showBlip: 'Blip Anzeige',
        edit: 'Bearbeiten',
        delete: 'Löschen',
        table: {
          edit: "Editieren",
          menu: "Tabelle anzeigen",
          remove: "Löschen",
          name: "ID",
          fraction: "Fraktion",
          action: "Aktion",
        },
        modal: {
          title: "Kleidungspunkt bearbeiten",
          name: "Bezeichnung (Bsp: fraktion_clothing_1)",
          coords: "Koordinationen (Bsp: vec4(0,0,0,0)",
          blip: "Blip anzeigen?",
          points: "Trigger Punkte (Bsp: vec3(0,0,0)",
          placeholder_points: "vec3(0,0,0)",
          addPoints: "Trigger Punkte hinzufügen",
          removePoints: "Trigger Punkte entfernen",
          create: "Zone Erstellen",
          save: "Zone Speichern",
          fraction: "Fraktion",
        },
      },
      boss: {
        title: "Willkommen beim Boss Menu",
        description: "Hier kannst du deine Boss Optionen anpassen",
      },
      garage: {
        title: "Willkommen beim Garagen Menu",
        description: "Hier kannst du deine Garagen Optionen anpassen",
      },
      lager: {
        title: "Willkommen beim Lager Menu",
        description: "Hier kannst du deine Lager Optionen anpassen",
      },
    },
  });

  language.set($debugData.lang);

  window.addEventListener("message", (event) => {
    if (event.data.action == "init") {
      nuiDebug('INIT DATA')
      clothing.set(event.data.data.clothing);
      useNotify = event.data.useNotify;
      show = true;
    } else if (event.data.action == "update") {
      nuiDebug('UPDATING DATA')
      console.log(event.data.data.clothing)
      nuiDebug('UPDATING DAsTA')
      clothing.set(event.data.data.clothing);
    }
  });

  function nuiDebug(message) {
    console.log('[JERZYS-M-NUI-DEBUG]'+ ' ' +message)
  }
  let show = false;
</script>

{#if show}
  <main>
    <div
      class="debug_background"
      style={$debugModus ? "display:block" : "display:none"}
    >
      <img src="https://i.imgur.com/vDGEfYg.jpeg" alt="" />
    </div>
    <div class="jerzys_tool_box {show ? 'slideInLeft' : 'hideInLeft'}">
      <div class="jerzys_tool_box_header">
        <span>{$language.heading_title}</span>
        <button
          on:click={() => ((show = false), fetchNui("close"))}
          class="close-btn show_tool_box"
        >
          <span class="material-symbols-outlined"> logout </span>
          <ToolBox title={$language.close} />
        </button>
      </div>
      <div class="jerzys_tool_box_body">
        <div class="jerzys_tool_box_body_nav">
          <ul class="nav-list">
            <li
              class="nav-item show_tool_box-left {cMenu == 'clothingmenu'
                ? 'active'
                : ''}"
              on:click={() => setMenu("clothingmenu")}
              on:keypress
            >
              <span class="material-symbols-outlined">
                local_laundry_service
              </span>
              <ToolBox title={$language.clothing_menu} />
            </li>
            <li
              class="nav-item show_tool_box-left {cMenu == 'garagemenu'
                ? 'active'
                : ''}"
              on:click={() => setMenu("garagemenu")}
              on:keypress
            >
              <span class="material-symbols-outlined"> garage </span>
              <ToolBox title={$language.garage_menu} />
            </li>
            <li
              class="nav-item show_tool_box-left {cMenu == 'bossmenu'
                ? 'active'
                : ''}"
              on:click={() => setMenu("bossmenu")}
              on:keypress
            >
              <span class="material-symbols-outlined"> summarize </span>
              <ToolBox title={$language.boss_menu} />
            </li>
            <li
              class="nav-item show_tool_box-left {cMenu == 'lager'
                ? 'active'
                : ''}"
              on:click={() => setMenu("lager")}
              on:keypress
            >
              <span class="material-symbols-outlined"> frame_inspect </span>
              <ToolBox title={$language.lager_menu} />
            </li>
          </ul>
        </div>
        <div class="jerzys_tool_box_body_container">
          {#if $isLoading}
            <div class="lds-ellipsis"><div></div><div></div><div></div></div>
          {:else}
            {#if cMenu == "clothingmenu"} <Clothing /> {/if}
            {#if cMenu == "garagemenu"} <Garage /> {/if}
            {#if cMenu == "bossmenu"} <BossMenu />{/if}
            {#if cMenu == "lager"} <Lager /> {/if}
          {/if}
        </div>
      </div>
    </div>
  </main>
{/if}

{#if $debugModus}
  <button on:click={() => (show = true)} class="menu_open"
    >{$language.menu}</button
  >
{/if}

{#if useNotify}
  {#if $showNotify === "update"}
    <Notify
      type={notifications.update.type}
      message={notifications.update.message}
    />
  {:else if $showNotify === "remove"}
    <Notify
      type={notifications.remove.type}
      message={notifications.remove.message}
    />
  {:else if $showNotify === "update"}
    <Notify
      type={notifications.edit.type}
      message={notifications.edit.message}
    />
  {:else if $showNotify === "add"}
    <Notify type={notifications.add.type} message={notifications.add.message} />
  {:else if $showNotify === "error"}
    <Notify
      type={notifications.error.type}
      message={notifications.error.message}
    />
  {/if}
{/if}

<style>
</style>
