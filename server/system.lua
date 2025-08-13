local db = require 'server.db'

local function playerConnecting(name, _, deferrals)
    local player = source
    local rawIds = GetPlayerIdentifiers(player)
    
    deferrals.defer()

    Wait(0)

    deferrals.update(('Hi %s. We are checking your identifiers for login.'):format(name))

    local identifiers = {}
    for i = 1, #rawIds do
        local id = rawIds[i]
        local sepPos = string.find(id, ':')
        if sepPos then
            local cat = string.sub(id, 1, sepPos - 1)
            identifiers[cat] = id
        end
    end

    local result = db.InsertUser(identifiers)
    if result then
        deferrals.done()
    else
        deferrals.done('Unable to connect to the server')
    end
end

AddEventHandler('playerConnecting', playerConnecting)