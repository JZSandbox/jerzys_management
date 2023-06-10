<script>
    import { fetchNui } from "../store/fetch.js";
    import {
        debugData,
        language,
        clothing,
        debugModus,
        removeCloting,
        showNotify,
        createdZonePoints,
        currentZone,
        loading,
    } from "../store/store.js";
    import Notify from "./Notify.svelte";
    let currentMenu = "clothing_items";
    let easyMenu = $language[currentMenu];
    let showEdit = false;
    let showAdd = false;
    let showTable = true;
    let showRemove = false;
    let deleteModal = false;
    let currentInformationen = "";
    let visibleRows = [];
    let searchTerm = "";
    let currentClothingZone;
    let createClothingZone = {
        zone: "",
        zoneName: "",
        points: [],
        showBlip: false,
        fraction: "",
    };

    function addField() {
        createdZonePoints.update((points) => [...points, ""]);
    }

    function updateFieldValue(index, event, type) {
        createdZonePoints.update((points) => {
            points[index] = event.target.value;
            return points;
        });
        createClothingZone["points"] = $createdZonePoints;
        console.log(createClothingZone);
    }

    function removeField(type) {
        createdZonePoints.update((points) => {
            points.pop();
            return points;
        });
    }

    visibleRows = $clothing;

    function searchTable(event) {
        const searchTerm = event.target.value.toLowerCase();
        if (searchTerm.length >= 2) {
            filteredClothing = $clothing.filter((item) =>
                item.zoneName.toLowerCase().includes(searchTerm.toLowerCase())
            );
        } else {
            filteredClothing = $clothing;
        }
    }

    function createZone(object) {
        let items = JSON.stringify($createdZonePoints);
        createClothingZone["points"] = JSON.parse(items);

        if (validateZone(object)) {
            fetchNui("createClothingZone", object);
            loading(1000)
            refreshData();
        } else {
            console.log("[JERZYS-DEBUG] Not all fields are filled in!");
        }
    }

    function refreshData() {
        createClothingZone = {
            zone: "",
            zoneName: "",
            points: [],
            showBlip: false,
            fraction: "",
        };

        createdZonePoints.update((points) => (points = []));
        return createClothingZone;
    }

    function updateData(id, fraction, zone, zoneName, zones, showBlip) {
        if (showBlip) {
            showBlip = true;
        } else {
            showBlip = false;
        }

        currentClothingZone = {
            id: id,
            fraction: fraction,
            zone: zone,
            zoneName: zoneName,
            points: JSON.parse(zones),
            showBlip: showBlip,
        };

        currentZone.update((zone) => (zone = currentClothingZone));
        return currentClothingZone;
    }

    function validateZone(zoneObj) {
        for (const prop in zoneObj) {
            if (zoneObj[prop] === "" || zoneObj[prop].length === 0) {
                return false;
            }
        }
        return true;
    }

    function setCurrentClothingZone(table) {
        currentClothingZone = updateData(
            table.id,
            table.fraction,
            table.zoneName,
            table.zone,
            table.points,
            table.showBlip
        );
        $createdZonePoints = $currentZone.points;
        showMenu("edit");
    }

    function saveZone(zone, zones) {
        if ($debugModus) {
            removeCloting(zone.id);
            showNotify.set("update");
            return;
        }
        let saveZone = {
            id: zone.id,
            fraction: zone.fraction,
            zone: zone.zone,
            zoneName: zone.zoneName,
            points: zones,
            showBlip: zone.showBlip,
        };
        loading()
        fetchNui("saveClothingZone", saveZone);
    }

    $: filteredClothing = $clothing;
    console.log($clothing);

    $: table = $clothing;

    $: console.log($clothing),
        visibleRows,
        createClothingZone["points"],
        createClothingZone,
        createClothingZone;

    function showMenu(type) {
        if (type == "add") {
            showEdit = false;
            showAdd = true;
            showTable = false;
            showRemove = false;
        } else if (type == "edit") {
            showEdit = true;
            showAdd = false;
            showTable = false;
        } else if (type == "table") {
            showEdit = false;
            showAdd = false;
            showTable = true;
            showRemove = false;
        } else if ((type = "remove")) {
            showEdit = false;
            showAdd = false;
            showTable = false;
            showRemove = true;
        }
    }

    function removeTable(table) {
        if ($debugModus) {
            removeCloting(table.id);
            showNotify.set("remove");
            return;
        }
        fetchNui("removeClothingZone", table.id);
        loading(1000)
        removeCloting(table.id);
    }

    function showInformation(name) {
        currentInformationen = name;
    }
</script>

<div class="jerzys_container_box opacity">
    <div class="jerzys_container_box_heading">
        <p>{$language[currentMenu].title}</p>
        <span>{$language[currentMenu].description}</span>
    </div>
    <div class="jerzys_container_body">
        <div class="jerzys_container_body_item d-flex flex-row gap-5 space-b">
            <div
                class="jerzys_container_create default-btn"
                on:click={() => showMenu("add")}
                on:keypress
            >
                {$language[currentMenu].create}
            </div>
            <div
                class="jerzys_container_create default-btn"
                on:click={() => showMenu("table")}
                on:keypress
            >
                {$language[currentMenu].menu}
            </div>
        </div>
        {#if showTable}
            <div class="jerzys_container_body_item">
                <input
                    class="jerzys_container_search"
                    type="text"
                    bind:value={searchTerm}
                    on:input={searchTable}
                    placeholder={$language[currentMenu].search}
                />
            </div>
            <div
                class="jerzys_container_body_item no-background no-padding table-scroll"
            >
                {#each filteredClothing as item (item.id)}
                    <div class="jerzys_table_box">
                        <div class="jerzys_table_box_header heading-text">
                            Umkleide: {item.zoneName}
                        </div>
                        <div class="jerzys_table_box_body">
                            <div class="jerzys_table_box_body_left">
                                Weitere Infos
                            </div>
                            <div class="jerzys_table_box_body_right">
                                <span class="material-symbols-outlined arrow">
                                    expand_less
                                </span>
                            </div>
                        </div>
                        <div class="jerzys_table_box_desc">
                            <div class="jerzys_table_box_desc_box_n">
                                <div class="jerzys_table_box_desc_item">
                                    <div class="name">Fraktion:</div>
                                    <div class="desc">FIB</div>
                                </div>
                                <div class="jerzys_table_box_desc_item">
                                    <div class="name">Blip Anzeigen:</div>
                                    <div class="desc">False</div>
                                </div>
                            </div>
                            <div class="jerzys_table_box_desc_button_box">
                                <button
                                    class="jerzys_table_box_desc_button default-btn"
                                    on:click={() =>
                                        setCurrentClothingZone(item)}
                                >
                                    EDIT
                                </button>
                                <button
                                    class="jerzys_table_box_desc_button default-btn"
                                    on:click={() => removeTable(item)}
                                >
                                    DELETE
                                </button>
                            </div>
                        </div>
                    </div>
                {/each}
                <!--
                    <table>
                    <thead>
                        <tr>
                            <th>{$language[currentMenu].table.name}</th>
                            <th>{$language[currentMenu].table.fraction}</th>
                            <th>{$language[currentMenu].table.action}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {#each $clothing as table}
                            <tr>
                                <td>{table.zoneName}</td>
                                <td>{table.fraction}</td>
                                <td class="d-flex flex-row gap-5">
                                    <div
                                        class="jerzys_container_create default-btn"
                                        on:click={() => setCurrentClothingZone(table)}
                                        on:keypress
                                    >
                                        {$language[currentMenu].table.edit}
                                    </div>
                                    <div
                                        class="jerzys_container_create default-btn"
                                        on:click={() => removeTable(table)}
                                        on:keypress
                                    >
                                        {$language[currentMenu].table.remove}
                                    </div>
                                </td>
                            </tr>
                        {/each}
                    </tbody>
                </table>-->
            </div>
        {/if}
    </div>
</div>

{#if showRemove}{/if}

{#if showAdd}
    <div class="center_item">
        <div class="modal table-scroll">
            <div class="modal_header">{easyMenu.modal.title}</div>
            <div class="modal_body">
                <div
                    class="jerzys_container_body_item d-flex flex-row gap-5 space-b darker algin-center"
                >
                    <label for="" class="default-label"
                        >{easyMenu.modal.name}</label
                    >
                    <input
                        class="default-input"
                        type="text"
                        name=""
                        id=""
                        bind:value={createClothingZone["zoneName"]}
                    />
                </div>
                <div
                    class="jerzys_container_body_item d-flex flex-row gap-5 space-b darker algin-center"
                >
                    <label for="" class="default-label"
                        >{easyMenu.modal.coords}</label
                    >
                    <input
                        class="default-input"
                        type="text"
                        name=""
                        id=""
                        bind:value={createClothingZone["zone"]}
                    />
                </div>
                <div
                    class="jerzys_container_body_item d-flex flex-row gap-5 space-b darker algin-center"
                >
                    <label for="" class="default-label"
                        >{easyMenu.modal.fraction}</label
                    >
                    <input
                        class="default-input"
                        type="text"
                        name=""
                        id=""
                        bind:value={createClothingZone["fraction"]}
                    />
                </div>
                <div
                    class="jerzys_container_body_item d-flex flex-row gap-5 space-b darker algin-center"
                >
                    <label for="" class="default-label"
                        >{easyMenu.modal.blip}</label
                    >
                    <div class="content">
                        <label class="checkBox">
                            <input
                                id="ch1"
                                type="checkbox"
                                name=""
                                bind:checked={createClothingZone["showBlip"]}
                            />
                            <div class="transition" />
                        </label>
                    </div>
                </div>
                <div
                    class="jerzys_container_body_item d-flex flex-column gap-5 space-b darker"
                >
                    <label for="" class="default-label"
                        >{easyMenu.modal.points}</label
                    >
                    {#each $createdZonePoints as points, index}
                        <input
                            placeholder={easyMenu.modal.points}
                            class="default-input"
                            type="text"
                            value={points}
                            on:input={(event) =>
                                updateFieldValue(index, event, "create")}
                        />
                    {/each}
                    <div class="button_box d-flex gap-5">
                        <button on:click={addField} class="default-btn"
                            >{easyMenu.modal.addPoints}</button
                        >
                        <button on:click={removeField} class="default-btn"
                            >{easyMenu.modal.removePoints}</button
                        >
                    </div>
                    <button
                        on:click={() => createZone(createClothingZone)}
                        class="default-btn">{easyMenu.modal.create}</button
                    >
                </div>
            </div>
        </div>
    </div>
{/if}

{#if showEdit}
    <div class="center_item">
        <div class="modal table-scroll">
            <div class="modal_header">{easyMenu.modal.title}</div>
            <div class="modal_body">
                <div
                    class="jerzys_container_body_item d-flex flex-row gap-5 space-b darker algin-center"
                >
                    <label for="" class="default-label"
                        >{easyMenu.modal.name}</label
                    >
                    <input
                        class="default-input"
                        type="text"
                        name=""
                        id=""
                        bind:value={$currentZone["zoneName"]}
                    />
                </div>
                <div
                    class="jerzys_container_body_item d-flex flex-row gap-5 space-b darker algin-center"
                >
                    <label for="" class="default-label"
                        >{easyMenu.modal.coords}</label
                    >
                    <input
                        class="default-input"
                        type="text"
                        name=""
                        id=""
                        bind:value={$currentZone["zone"]}
                    />
                </div>
                <div
                    class="jerzys_container_body_item d-flex flex-row gap-5 space-b darker algin-center"
                >
                    <label for="" class="default-label"
                        >{easyMenu.modal.fraction}</label
                    >
                    <input
                        class="default-input"
                        type="text"
                        name=""
                        id=""
                        bind:value={$currentZone["fraction"]}
                    />
                </div>
                <div
                    class="jerzys_container_body_item d-flex flex-row gap-5 space-b darker algin-center"
                >
                    <label for="" class="default-label"
                        >{easyMenu.modal.blip}</label
                    >
                    <div class="content">
                        <label class="checkBox">
                            <input
                                id="ch1"
                                type="checkbox"
                                name=""
                                bind:checked={$currentZone["showBlip"]}
                            />
                            <div class="transition" />
                        </label>
                    </div>
                </div>
                <div
                    class="jerzys_container_body_item d-flex flex-column gap-5 space-b darker"
                >
                    <label for="" class="default-label"
                        >{easyMenu.modal.points}</label
                    >
                    {#if $debugModus}
                        {#each $createdZonePoints as points, index}
                            <input
                                placeholder={easyMenu.modal.points}
                                class="default-input"
                                type="text"
                                value={points}
                                on:input={(event) =>
                                    updateFieldValue(index, event)}
                            />
                        {/each}
                    {:else}
                        {#each $createdZonePoints as points, index}
                            <input
                                placeholder={easyMenu.modal.points}
                                class="default-input"
                                type="text"
                                value={points}
                                on:input={(event) =>
                                    updateFieldValue(index, event)}
                            />
                        {/each}
                    {/if}
                    <div class="button_box d-flex gap-5">
                        <button on:click={addField} class="default-btn"
                            >{easyMenu.modal.addPoints}</button
                        >
                        <button
                            on:click={() => removeField("update")}
                            class="default-btn"
                            >{easyMenu.modal.removePoints}</button
                        >
                    </div>
                    <button
                        on:click={() =>
                            saveZone($currentZone, $createdZonePoints)}
                        class="default-btn">{easyMenu.modal.save}</button
                    >
                </div>
            </div>
        </div>
    </div>
{/if}
