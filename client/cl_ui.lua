RegisterNetEvent("jerzys_management:client:init", function(data)
    SELF.TriggerNUI("init", data)
    TriggerEvent('illenium-appearance:client:openClothingShopMenu')
end)

RegisterNetEvent('jerzys_management:client:update', function(data)
    print(data)
    SELF.TriggerNUI('update', data)
end)

RegisterNetEvent('jerzys_management:client:updateData', function(type)
    TriggerServerEvent('jerzys_management:server:updateData', type)
end)

-- NUI Callbacks
RegisterNuiCallback('close', function(cb)
    SELF.CloseUI()
    cb(1)
end)

RegisterNuiCallback('createClothingZone', function(data, cb)
    TriggerServerEvent('jerzys_management:server:createClothingZone', data)

    SELF.UpdateData('clothing')
    SELF.Notification("JERZYS_MANAGEMENT", "Clothing zone created", "success")
    SELF.DebugModus("CLOTHING CREATED", "CREATED")
    cb(1)
end)

RegisterNUICallback('saveClothingZone', function (data, cb)
    TriggerServerEvent('jerzys_management:server:updateClothingZone', data)

    SELF.UpdateData('clothing')
    SELF.Notification("JERZYS_MANAGEMENT", "Clothing zone updated", "success")
    SELF.DebugModus("CLOTHING UPDATED", "UPDATED")
    cb(1)
end)

RegisterNuiCallback('removeClothingZone', function (data, cb)
    TriggerServerEvent('jerzys_management:server:removeClothingZone', data)

    SELF.UpdateData('clothing')
    SELF.Notification("JERZYS_MANAGEMENT", "Clothing zone deleted", "success")
    SELF.DebugModus("CLOTHING DELETED", "DELETED")
    cb(1)
end)