-- FUNCTION HANDLER
SELF = {}
-- STATE HANDLER
STATE = {}

-- This function is triggering a NUI (Native UI) event with a specified name and data. It sets the NUI
-- focus to true and keeps the input focus as well. It then sends a message to the NUI with the
-- specified action and data.
SELF.TriggerNUI = function(name, data)
    SELF.SetState('OPENMENU', true)
    SetNuiFocus(true, true)
    SetNuiFocusKeepInput(true)
    SendNUIMessage({
        action = name,
        data = data,
        notify = Config.useNUINotification
    })
end

--  `SELF.UpdateData` is a function that takes in a parameter `type`. If the `type` parameter is equal
--   to the string `'clothing'`, it triggers an event with the name
--   `'jerzys_management:client:updateData'` and the parameter `'clothing'`. It also calls the
--  `SELF.DebugModus` function with the parameters `"UPDATED CLOTHING DATA"` and `"UPDATE"`. This
-- function is likely used to update data related to clothing in the game's UI.
SELF.UpdateData = function (type)
    if type == 'clothing' then
        TriggerEvent('jerzys_management:client:updateData')
        SELF.DebugModus("UPDATED CLOTHING DATA", "UPDATE")
    end
end

-- `SELF.CloseUI` is a function that is used to close the NUI (Native UI) window. It sets the NUI focus
-- to false and releases the input focus as well. It then calls the callback function `cb` with the
-- string "ok" as a parameter.
SELF.CloseUI = function()
    SELF.SetState('OPENMENU', false)
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    cb('ok')
end


-- `SELF.Notification` is a function that takes in four parameters: `title`, `msg`, `type`, and
-- `duration`. It then calls a `lib.notify` function with an object containing the `title`,
-- `description`, `type`, and `duration` properties. This function is likely used to display
-- notifications to the user in the game's UI.
SELF.Notification = function(title, msg, type, duration)
    if Config.useNUINotification then return end
    if Config.customNotification then CUSTOM.Notify(title, msg, type, duration) return end
    lib.notify({
        title = title,
        description = msg,
        type = type,
        duration = duration or 5000
    })
end

-- [[STATE HANDLLER]]--
-- `SELF.SetState` is a function that takes in two parameters: `key` and `value`. It sets the value of
-- the `key` property in the `STATE` object to the `value` parameter passed to the function. This
-- function is likely used to manage the state of the game's UI.
SELF.SetState = function(key, value)
    STATE[key] = value
end

-- The `SELF.DebugModus` function is used for debugging purposes. It takes in two parameters: `option`
-- and `text`. It then prints a message to the console with the text `[JERZYS-MANAGEMENT]` followed by
-- the `text` parameter and the `option` parameter concatenated together.
SELF.DebugModus = function(option, text)
    if not Config.DebugMode then return end
    print('[JERZYS-MANAGEMENT] '..' '..text..' '..option)
end


SELF.OpenClothingMenu = function()
    TriggerEvent('illenium-appearance:client:openClothingShopMenu')
    SELF.DebugModus('CLOTHING STORE', 'OPENED')
end