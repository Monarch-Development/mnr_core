local playerClass = require 'server.modules.player'

Players = {}

local function OnPlayerConnecting(playerName, _, deferrals)
    local playerId = source

    deferrals.defer()

    Wait(0)

    deferrals.update(('Hi %s, we are checking everything is ok to access the server...'):format(playerName))

    Wait(0)

    --- Rejected
    deferrals.done('Rejected')

    --- Accepted
    deferrals.done()
end

AddEventHandler('playerConnecting', OnPlayerConnecting)