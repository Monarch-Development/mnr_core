local economy = require 'config.economy'
local licenses = require 'config.licenses'

local player = {}
player.__index = player

function player:new(data)
    local obj = setmetatable({}, player)
    obj.userId = data.userId
    obj.charId = data.charId

    return obj
end

function player:initBio(data)
    self.bio = {}

    self.bio.firstname = data.firstname or 'John'
    self.bio.lastname = data.lastname or 'Smith'
    self.bio.birthdate = data.birthdate or '00/00/0000'
    self.bio.gender = data.gender or 'X'
    self.bio.origin = data.origin or 'Earth'
end

function player:initMoney(data)
    self.money = {}

    for name, starter in pairs(economy) do
        self.money[name] = data[name] or starter
    end
end

function player:initLicenses(data)
    self.licenses = {}

    for name, starter in pairs(licenses) do
        self.licenses[name] = data[name] or starter
    end
end

function player:initGroups(data)
    self.groups = {}

    local maxGroups = GetConvarInt('mnr:maxGroups', 2)

    for i = 1, maxGroups do
        self.groups[i] = data[i] or { name = 'default', grade = 1 }
    end
end

function player:initStatus(data)
    self.status = {}

    self.status.dead = data.dead or false
    self.status.handcuffed = data.handcuffed or false
    self.status.jail = data.jail or { false, 0 }
    self.status.health = data.health or 200
    self.status.armor = data.armor or 0
    self.status.hunger = data.hunger or 100
    self.status.thirst = data.thirst or 100
    self.status.stress = data.stress or 0
end

return player