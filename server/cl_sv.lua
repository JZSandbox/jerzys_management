-- Fechting all Data from Database
RegisterNetEvent('jerzys_management:server:init', function()
    local src = source
    local data = {}
    local clothing = MySQL.Sync.fetchAll('SELECT * FROM jerzys_m_clothing')
    data["clothing"] = clothing
    TriggerClientEvent('jerzys_management:client:init', src, data)
end)

-- Creating a new Clothing Zone
RegisterNetEvent('jerzys_management:server:createClothingZone', function (data)
    SELF.DebugModus("CREATING CLOTHING ZONE IN DATABASE", "CREATED")

    MySQL.insert('INSERT INTO jerzys_m_clothing (`zoneName`, `zone`, `points`, `showBlips`, `fraction`) VALUES (?, ?, ?, ?, ?)',
    {data["zoneName"], data["zone"], json.decode(data["points"]), data["showBlip"], data["fraction"]})

    SELF.UpdateData('clothing')
    SELF.DebugModus("ZONE CREATED", "CREATED")
end)

-- Removing a Clothing Zone
RegisterNetEvent('jerzys_management:server:removeClothingZone', function (data)
    SELF.DebugModus("START REMOVING CLOTHING ZONE IN DATABASE", "CREATED")
    MySQL.Async.execute('DELETE FROM jerzys_m_clothing WHERE id = ?', {data})

    SELF.UpdateData('clothing')
    SELF.DebugModus("FINISHED DELETING CLOTHING ZONE", "DELETE")
end)

-- Updating Data
RegisterNetEvent('jerzys_management:server:updateClothingZone', function(data)
    SELF.DebugModus("START UPDATING CLOTHING ZONE IN DATABASE", "UPDATE")

    MySQL.Async.execute('UPDATE jerzys_m_clothing SET zoneName = ?, zone = ?, points = ?, showBlips = ?, fraction = ? WHERE id = ?',
    {data["zoneName"], data["zone"], json.encode(data["points"]), data["showBlip"], data["fraction"], data["id"]})
    
    SELF.UpdateData('clothing')
    SELF.DebugModus("FINISHED UPADTING CLOTHING ZONE", "UPDATE")
end)

RegisterNetEvent('jerzys_management:server:updateData', function(type)
    local src = source
    local data = {}
    Wait(1500)
    MySQL.query('SELECT * FROM jerzys_m_clothing', function (result)
        if result[1] then
            data["clothing"] = result
            print(json.encode(data, {indent = true}))
            TriggerClientEvent('jerzys_management:client:update', src, data, 'all')
        end
    end)
end)


-- CALLBACKS
lib.callback.register('jerzys_management:clothing', function(source)
    local clothing = MySQL.Sync.fetchAll('SELECT * FROM jerzys_m_clothing')
    print(json.encode(clothing[1].zone))
    return clothing
end)

