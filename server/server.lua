local database = require 'server.modules.database'
local playerClass = require 'server.modules.player'

Players = {}

AddEventHandler('playerConnecting', function(playerName, _, deferrals)
    local playerId = source

    deferrals.defer()

    Wait(0)

    deferrals.update(('Hi %s, we are checking everything is ok to access the server...'):format(playerName))

    Wait(0)

    --- Rejected
    -- deferrals.done('Rejected')

    --- Accepted
    deferrals.done()
end)

AddEventHandler('playerDropped', function(reason)
    local playerId = source

    if not Players[playerId] then return end

    database.SavePlayer(Players[playerId])

    Players[playerId] = nil
end)