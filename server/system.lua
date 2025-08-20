local database = require 'server.database'

local function sortPlayerIdentifiers(source)
    return identifiers = {
        license = GetPlayerIdentifierByType(source, 'license')
        license2 = GetPlayerIdentifierByType(source, 'license2')
        fivem = GetPlayerIdentifierByType(source, 'fivem')
        discord = GetPlayerIdentifierByType(source, 'discord')
        steam = GetPlayerIdentifierByType(source, 'steam')
    },
end

local function playerConnecting(name, _, deferrals)
    local player = source
    local identifiers = sortPlayerIdentifiers(player)
    
    deferrals.defer()

    Wait(0)

    deferrals.update(('Hi %s. We are checking your identifiers for login.'):format(name))

    local banned, reason = database.CheckBanned(identifiers)
    local inserted = database.InsertUser(name, identifiers)

    if banned then
        deferrals.done(('Banned for reason: %s. If you think is an error open an unban ticket in %s'):format(reason, GetConvar('Discord', 'https://discord.gg/WKtk65yBC6')))
        return
    end

    if not inserted then
        deferrals.done('Unable to connect to the server, a problem occurred registering the identifiers')
        return
    end
    
    deferrals.done()
end

AddEventHandler('playerConnecting', playerConnecting)