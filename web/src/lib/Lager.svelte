<script>
    import { language } from "../store/store.js";
    let currentMenu = 'lager'
</script>

<div class="jerzys_container_box opacity">
    <div class="jerzys_container_box_heading">
        <p>{$language[currentMenu].title}</p>
        <span>{$language[currentMenu].description}</span>
    </div>
    <div class="jerzys_container_body">
        <div class="jerzys_container_create">
            {$language[currentMenu].create}
        </div>
    </div>
</div>
