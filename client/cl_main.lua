local Clothing = {}

RegisterKeyMapping('jerzys_management:client:open', 'Jerzys Management Tool', 'keyboard', Config.openMenuKey)

RegisterCommand('jerzys_management:client:open', function()
    if not IsNuiFocused() and not IsPauseMenuActive() then
        TriggerServerEvent('jerzys_management:server:init')
    end
end)


-- Clothing
