webhooks = {
    ['drop'] = 'https://discord.com/api/webhooks/1301151333134372884/40P7ZgfOrQ4rTFcO8fU9l_Y6x-GmtpwO_pBxKSyJJZQ-q-0PNTq7BoHSBFFO-VnQf7ZC',
    ['pickup'] = 'https://discord.com/api/webhooks/1301151333134372884/40P7ZgfOrQ4rTFcO8fU9l_Y6x-GmtpwO_pBxKSyJJZQ-q-0PNTq7BoHSBFFO-VnQf7ZC',
    ['give'] = 'https://discord.com/api/webhooks/1301151333134372884/40P7ZgfOrQ4rTFcO8fU9l_Y6x-GmtpwO_pBxKSyJJZQ-q-0PNTq7BoHSBFFO-VnQf7ZC',
    ['stash'] = 'https://discord.com/api/webhooks/1301151333134372884/40P7ZgfOrQ4rTFcO8fU9l_Y6x-GmtpwO_pBxKSyJJZQ-q-0PNTq7BoHSBFFO-VnQf7ZC',
    ['glovebox'] = 'https://discord.com/api/webhooks/1301151333134372884/40P7ZgfOrQ4rTFcO8fU9l_Y6x-GmtpwO_pBxKSyJJZQ-q-0PNTq7BoHSBFFO-VnQf7ZC',
    ['gloveboxplayer'] = 'https://discord.com/api/webhooks/1301151333134372884/40P7ZgfOrQ4rTFcO8fU9l_Y6x-GmtpwO_pBxKSyJJZQ-q-0PNTq7BoHSBFFO-VnQf7ZC',
    ['trunk'] = 'https://discord.com/api/webhooks/1301151333134372884/40P7ZgfOrQ4rTFcO8fU9l_Y6x-GmtpwO_pBxKSyJJZQ-q-0PNTq7BoHSBFFO-VnQf7ZC',
    ['playertrunk'] = 'https://discord.com/api/webhooks/1301151333134372884/40P7ZgfOrQ4rTFcO8fU9l_Y6x-GmtpwO_pBxKSyJJZQ-q-0PNTq7BoHSBFFO-VnQf7ZC',
}
hooks = {
    ['drop'] = {
        from = 'player',
        to = 'drop',
        callback = function(payload)
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            sendWebhook('drop', {
                {
                    title = 'Drop',
                    description = ('**Player Name:** %s\n**Player Identifier:** %s\n**Source ID:** %s\n**Item Name:** %s\n**Item Count:** x%s\n**Metadata:** %s\n**Location:** %s, %s, %s')
                        :format(
                            playerName,
                            playerIdentifier,
                            payload.source,
                            payload.fromSlot.name,
                            payload.fromSlot.count,
                            json.encode(payload.fromSlot.metadata),
                            playerCoords.x, playerCoords.y, playerCoords.z
                        ),
                    color = 0x00ff00
                }
            })
        end
    },
    ['inventory_to_glovebox'] = {
        from = 'player',
        to = 'glovebox',
        callback = function(payload)
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            sendWebhook('glovebox', {
                {
                    title = 'Glovebox Transfer',
                    description = ('**Player:** %s\n**Player Identifier:** %s\n**Source ID:** %s\n\n**Item Stored in Glovebox:** %s\n**Quantity:** x%s\n**Metadata:** %s\n\n**Glovebox ID:** %s\n**Player Coordinates:** %s, %s, %s')
                        :format(
                            playerName,
                            playerIdentifier,
                            payload.source,
                            payload.fromSlot.name,
                            payload.fromSlot.count,
                            json.encode(payload.fromSlot.metadata),
                            payload.toInventory, 
                            playerCoords.x, playerCoords.y, playerCoords.z
                        ),
                    color = 0x00ff00
                }
            })
        end
    },
    ['glovebox_to_inventory'] = {
        from = 'glovebox',
        to = 'player',
        callback = function(payload)
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            sendWebhook('gloveboxplayer', {
                {
                    title = 'Glovebox Retrieval',
                    description = ('**Player:** %s\n**Player Identifier:** %s\n**Source ID:** %s\n\n**Item Retrieved from Glovebox:** %s\n**Quantity:** x%s\n**Metadata:** %s\n\n**Glovebox ID:** %s\n**Player Coordinates:** %s, %s, %s')
                        :format(
                            playerName,
                            playerIdentifier,
                            payload.source,
                            payload.fromSlot.name,
                            payload.fromSlot.count,
                            json.encode(payload.fromSlot.metadata),
                            payload.fromInventory, 
                            playerCoords.x, playerCoords.y, playerCoords.z
                        ),
                    color = 0x00ff00
                }
            })
        end
    },
    ['trunk_to_inventory'] = {
        from = 'trunk',
        to = 'player',
        callback = function(payload)
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            sendWebhook('trunk', {
                {
                    title = 'Trunk Retrieval',
                    description = ('**Player:** %s\n**Player Identifier:** %s\n**Source ID:** %s\n\n**Item Retrieved from Trunk:** %s\n**Quantity:** x%s\n**Metadata:** %s\n\n**Trunk ID:** %s\n**Player Coordinates:** %s, %s, %s')
                        :format(
                            playerName,
                            playerIdentifier,
                            payload.source,
                            payload.fromSlot.name,
                            payload.fromSlot.count,
                            json.encode(payload.fromSlot.metadata),
                            payload.fromInventory,  -- assuming `fromInventory` refers to the glovebox ID
                            playerCoords.x, playerCoords.y, playerCoords.z
                        ),
                    color = 0x00ff00
                }
            })
        end
    },
    ['inventory_to_trunk'] = {
        from = 'player',
        to = 'trunk',
        callback = function(payload)
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            sendWebhook('playertrunk', {
                {
                    title = 'Trunk Transfer',
                    description = ('**Player:** %s\n**Player Identifier:** %s\n**Source ID:** %s\n\n**Item Storaged in Trunk:** %s\n**Quantity:** x%s\n**Metadata:** %s\n\n**Trunk ID:** %s\n**Player Coordinates:** %s, %s, %s')
                        :format(
                            playerName,
                            playerIdentifier,
                            payload.source,
                            payload.fromSlot.name,
                            payload.fromSlot.count,
                            json.encode(payload.fromSlot.metadata),
                            payload.toInventory,  -- assuming `fromInventory` refers to the glovebox ID
                            playerCoords.x, playerCoords.y, playerCoords.z
                        ),
                    color = 0x00ff00
                }
            })
        end
    },
    ['pickup'] = {
        from = 'drop',
        to = 'player',
        callback = function(payload)
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            sendWebhook('pickup', {
                {
                    title = 'Pickup',
                    description = ('**Player Name:** %s\n**Player Identifier:** %s\n**Source ID:** %s\n**Item Name:** %s\n**Item Count:** x%s\n**Metadata:** %s\n**Location:** %s, %s, %s')
                        :format(
                            playerName,
                            playerIdentifier,
                            payload.source,
                            payload.fromSlot.name,
                            payload.fromSlot.count,
                            json.encode(payload.fromSlot.metadata),
                            playerCoords.x, playerCoords.y, playerCoords.z
                        ),
                    color = 0x00ff00
                }
            })
        end
    },
    ['give'] = {
        from = 'player',
        to = 'player',
        callback = function(payload)
            if payload.fromInventory == payload.toInventory then return end
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            local targetSource = payload.toInventory
            local targetName = GetPlayerName(targetSource)
            local targetIdentifier = GetPlayerIdentifiers(targetSource)[1]
            local targetCoords = GetEntityCoords(GetPlayerPed(targetSource))
            sendWebhook('give', {
                {
                    title = 'Give',
                    description = ('**Giving Player:** %s\n**Player Identifier:** %s\n**Source ID:** %s\n\n**Receiving Player:** %s\n**Target Identifier:** %s\n**Target Source ID:** %s\n\n**Item Given:** %s\n**Quantity:** x%s\n**Metadata:** %s\n\n**Source Coordinates:** %s, %s, %s\n**Target Coordinates:** %s, %s, %s')
                        :format(
                            playerName,
                            playerIdentifier,
                            payload.source,
                            targetName,
                            targetIdentifier,
                            targetSource,
                            payload.fromSlot.name,
                            payload.fromSlot.count,
                            json.encode(payload.fromSlot.metadata),
                            playerCoords.x, playerCoords.y, playerCoords.z,
                            targetCoords.x, targetCoords.y, targetCoords.z
                        ),
                    color = 0x00ff00
                }
            })
        end
    },    
    ['stash_pick'] = {
        from = 'player',
        to = 'stash',
        callback = function(payload)
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            sendWebhook('stash', {
                {
                    title = 'player -> stash',
                    description = ('**Player:** %s\n**Player Identifier:** %s\n**Source ID:** %s\n\n**Item Added to Stash:** %s\n**Quantity:** x%s\n**Metadata:** %s\n\n**Stash Location:** %s\n**Player Coordinates:** %s, %s, %s')
                        :format(
                            playerName,
                            playerIdentifier,
                            payload.source,
                            payload.fromSlot.name,
                            payload.fromSlot.count,
                            json.encode(payload.fromSlot.metadata),
                            payload.toInventory,
                            playerCoords.x, playerCoords.y, playerCoords.z
                        ),
                    color = 0x00ff00
                }
            })
        end
    },
    ['stash'] = {
        from = 'stash',
        to = 'player',
        callback = function(payload)
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            sendWebhook('stash', {
                {
                    title = 'stash -> player',
                    description = ('**Player:** %s\n**Player Identifier:** %s\n**Source ID:** %s\n\n**Item Taken from Stash:** %s\n**Quantity:** x%s\n**Metadata:** %s\n\n**Stash Location:** %s\n**Player Coordinates:** %s, %s, %s')
                        :format(
                            playerName,
                            playerIdentifier,
                            payload.source,
                            payload.fromSlot.name,
                            payload.fromSlot.count,
                            json.encode(payload.fromSlot.metadata),
                            payload.fromInventory,
                            playerCoords.x, playerCoords.y, playerCoords.z
                        ),
                    color = 0x00ff00
                }
            })
        end
    },
}    
