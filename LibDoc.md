# Multiplier Manager

---

All the functions can be access with the global "MultiplierManager"

## RegisterItem

```lua
function MultiplierManager:RegisterItem(CollectibleType : Int, Multipliers : table)
```

- ` CollectibleType` : Integer - Item ID

- `Multipliers` : Table -
  
  - `Damage` : Float or Function(EntitiePlayer)[ Return : Float ]
  
  - `Tears` : Float or Function(EntitiePlayer)[ Return : Float ]
  
  - `Speed` : Float or Function(EntitiePlayer)[ Return : Float ]
  
  - `Range` : Float or Function(EntitiePlayer)[ Return : Float ]
  
  - `ShotSpeed` : Float or Function(EntitiePlayer)[ Return : Float ]
  
  - `Luck` : Float or Function(EntitiePlayer)[ Return : Float ]

### Example

```lua
local YourMod = RegisterMod("Your Mod", 1)
local CustomItemId = Isaac.GetItemIdByName("CustomItem")

function YourMod:RangeMult(player)
    -- give x0.6 range multiplier but it isnt in effect if the player has Crickets Body
    if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_CRICKETS_BODY) then
        return 1
    end
    return 0.6
end

MultiplierManager:RegisterItem(CustomItemId, {
    Damage = 1.5,
    Range = YourMod.RangeMult
})
```

## RegisterTrinket

```lua
function MultiplierManager:RegisterTrinket(TrinketType : Int, Multipliers : table)
```

- `TrinketType` : Integer - Trinket ID

- `Multipliers` : Table -
  
  - `Damage` : Float or Function(EntitiePlayer)[ Return : Float ]
  
  - `Tears` : Float or Function(EntitiePlayer)[ Return : Float ]
  
  - `Speed` : Float or Function(EntitiePlayer)[ Return : Float ]
  
  - `Range` : Float or Function(EntitiePlayer)[ Return : Float ]
  
  - `ShotSpeed` : Float or Function(EntitiePlayer)[ Return : Float ]
  
  - `Luck` : Float or Function(EntitiePlayer)[ Return : Float ]

### Example

```lua
local YourMod = RegisterMod("Your Mod", 1)
local CustomTrinketId = Isaac.GetTrinketIdByName("CustomTrinket")

function YourMod:TearsMult(player)
    -- if the player gives a x1.05 tear multiplier
    return 1 + player:GetTrinket(CustomTrinketId) * 0.05
end

MultiplierManager:RegisterTrinket(CustomTrinketId, {
    Tears = YourMod.TearsMult,
    ShotSpeed = 0.8
})
```

## RegisterPlayer

```lua
function MultiplierManager:RegisterPlayer(PlayerType : Int, Multipliers : table)
```

- `PlayerType` : Integer - Player ID

- `Multipliers` : Table -
  
  - `Damage` : Float or Function(EntitiePlayer)[ Return : Float ]
  
  - `Tears` : Float or Function(EntitiePlayer)[ Return : Float ]
  
  - `Speed` : Float or Function(EntitiePlayer)[ Return : Float ]
  
  - `Range` : Float or Function(EntitiePlayer)[ Return : Float ]
  
  - `ShotSpeed` : Float or Function(EntitiePlayer)[ Return : Float ]
  
  - `Luck` : Float or Function(EntitiePlayer)[ Return : Float ]

### Example

```lua
local YourMod = RegisterMod("Your Mod", 1)
local CustomCharacterId = Isaac.GetPlayerTypeByName("CustomCharacter")

function YourMod:TearsMult(player)
    -- if the player has sad onion gives a x1.2 tears multiplier else it gives x0.9 tears multiplier
    if player:HasCollectible(CollectibleType.COLLECTIBLE_SAD_ONION) then
        return 1.2
    end
    return 0.9
end

MultiplierManager:RegisterPlayer(CustomCharacterId, {
    Damage = 1.3, 
    Tears = YourMod.TearsMult
})
```

----

## GetItem

```lua
function MultiplierManager:GetItem(CollectibleType : Int)
```

- `CollectibleType` : Integer - Item ID

- `Return` : Table -
  
  - `Damage` : Float or Function(EntitiePlayer)[ Return : Float ] or 1
  
  - `Tears` : Float or Function(EntitiePlayer)[ Return : Float ] or 1
  
  - `Speed` : Float or Function(EntitiePlayer)[ Return : Float ] or 1
  
  - `Range` : Float or Function(EntitiePlayer)[ Return : Float ] or 1
  
  - `ShotSpeed` : Float or Function(EntitiePlayer)[ Return : Float ] or 1
  
  - `Luck` : Float or Function(EntitiePlayer)[ Return : Float ] or 1

### Example

```lua
local Mod = RegisterMod("YourMod", 1)

function Mod:DoCache(player, cacheflag)
    -- prints all Heamolacria multipliers
    for StatType, Multiplier in pairs(MultiplierManager:GetItem(CollectibleType.COLLECTIBLE_HAEMOLACRIA)) do
        local printMult = 0
        if type(Multiplier) == "function" then
            printMult = Multiplier(_, player)
        else
            printMult = Multiplier
        end
        print(StatType .. ": " .. tostring(printMult))
    end
end
Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Mod.DoCache)
```

## GetTrinket

```lua
function MultiplierManager:GetTrinket(TrinketType : Int)
```

- `TrinketType` : Integer - Trinket ID

- `Return` : Table -
  
  - `Damage` : Float or Function(EntitiePlayer)[ Return : Float ] or 1
  
  - `Tears` : Float or Function(EntitiePlayer)[ Return : Float ] or 1
  
  - `Speed` : Float or Function(EntitiePlayer)[ Return : Float ] or 1
  
  - `Range` : Float or Function(EntitiePlayer)[ Return : Float ] or 1
  
  - `ShotSpeed` : Float or Function(EntitiePlayer)[ Return : Float ] or 1
  
  - `Luck` : Float or Function(EntitiePlayer)[ Return : Float ] or 1

### Example

```lua
local Mod = RegisterMod("YourMod", 1)

function Mod:DoCache(player, cacheflag)
    -- prints all Cracked Crown multipliers
    for StatType, Multiplier in pairs(MultiplierManager:GetTrinket(TrinektType.TRINKET_CRACKED_CROWN)) do
        local printMult = 0
        if type(Multiplier) == "function" then
            printMult = Multiplier(_, player)
        else
            printMult = Multiplier
        end
        print(StatType .. ": " .. tostring(printMult))
    end
end
Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Mod.DoCache)
```

## GetPlayer

```lua
function MultiplierManager:GetPlayer(PlayerType : Int)
```

- `PlayerType` : Integer - Player ID

- `Return` : Table -
  
  - `Damage` : Float or Function(EntitiePlayer)[ Return : Float ] or 1
  
  - `Tears` : Float or Function(EntitiePlayer)[ Return : Float ] or 1
  
  - `Speed` : Float or Function(EntitiePlayer)[ Return : Float ] or 1
  
  - `Range` : Float or Function(EntitiePlayer)[ Return : Float ] or 1
  
  - `ShotSpeed` : Float or Function(EntitiePlayer)[ Return : Float ] or 1
  
  - `Luck` : Float or Function(EntitiePlayer)[ Return : Float ] or 1

### Example

```lua
local Mod = RegisterMod("YourMod", 1)

function Mod:DoCache(player, cacheflag)
    if player:GetPlayerType() ~= PlayerType.PLAYER_ISAAC then return end
    -- prints isaac damage multiplier
    print(MultiplierManager:GetPlayer(PlayerType.PLAYER_ISAAC).Damage)
end
Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Mod.DoCache)
```

```lua
local Mod = RegisterMod("YourMod", 1)

function Mod:DoCache(player, cacheflag)
    if player:GetPlayerType() ~= PlayerType.PLAYER_EVE_B then return end
    -- prints all tainted eves multipliers
    for StatType, Multiplier in pairs(MultiplierManager:GetPlayer(PlayerType.PLAYER_EVE_B)) do
        local printMult = 0
        if type(Multiplier) == "function" then
            printMult = Multiplier(_, player)
        else
            printMult = Multiplier
        end
        print(StatType .. ": " .. tostring(printMult))
    end
end
Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Mod.DoCache)
```

## GetCrackedCrown

```lua
function MultiplierManager:GetCrackedCrown(EntityPlayer : userdata)
```

- `EntityPlayer` : userdata

- `Return` : Float

### Example

```lua
local Mod = RegisterMod("YourMod", 1)

function Mod:DoChache(player, cacheflag)
    -- print the player Cracked Crown multiplier
    print(MultiplierManager:GetCrackedCrown(player))
end
Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Mod.DoCache)
```

## CanGiveCrackedCrowMult

```lua
function MultiplierManager:CanGiveCrackedCrowMult(EntityPlayer : userdata, StatType : string)
```

- `EntityPlayer` : userdata

- `StatType` : String - Stat type (damage, tears, range, etc)

- `Return` : Boolean

### Example

```lua
local Mod = RegisterMod("YourMod", 1)

function Mod:DoChache(player, cacheflag)
    -- print if can give Cracked Crown multiplier to the player damage
    print(MultiplierManager:CanGiveCrackedCrowMult(player, "damage"))
end
Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Mod.DoCache)
```

## GetPlayerDamage

```lua
function MultiplierManager:GetPlayerDamage(EntityPlayer : userdata)
```

- `EntityPlayer` : userdata

- `Return` : Float

### Example

```lua
local Mod = RegisterMod("YourMod", 1)

function Mod:DoChache(player, cacheflag)
    -- prints the player total damage multiplier
    print(MultiplierManager:GetPlayerDamage(player))
end
Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Mod.DoCache)
```

## GetPlayerTears

```lua
function MultiplierManager:GetPlayerTears(EntityPlayer : userdata)
```

- `EntityPlayer` : userdata

- `Return` : Float

### Example

```lua
local Mod = RegisterMod("YourMod", 1)

function Mod:DoCache(player, cacheflag)
    -- prints the player total tear multiplier
    print(MultiplierManager:GetPlayerTears(player))
end
Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Mod.DoCache)
```

## GetPlayerSpeed

```lua
function MultiplierManager:GetPlayerSpeed(EntityPlayer : userdata)
```

- `EntityPlayer` : userdata

- `Return` : Float

### Example

```lua
local Mod = RegisterMod("YourMod", 1)

function Mod:DoCache(player, cacheflag)
    -- prints the player total speed multiplier
    print(MultiplierManager:GetPlayerSpeed(player))
end
Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Mod.DoCache)
```

## GetPlayerRange

```lua
function MultiplierManager:GetPlayerRange(EntityPlayer : userdata)
```

- `EntityPlayer` : userdata

- `Return` : Float

### Example

```lua
local Mod = RegisterMod("YourMod", 1)

function Mod:DoCache(player, cacheflag)
    -- prints the player total range multiplier
    print(MultiplierManager:GetPlayerRange(player))
end
Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Mod.DoCache)
```

## GetPlayerShotSpeed

```lua
function MultiplierManager:GetPlayerShotSpeed(EntityPlayer : userdata)
```

- `EntityPlayer` : userdata

- `Return` : Float

### Example

```lua
local Mod = RegisterMod("YourMod", 1)

function Mod:DoCache(player, cacheflag)
    -- prints the player total shotspeed multiplier
    print(MultiplierManager:GetPlayerShotSpeed(player))
end
Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Mod.DoCache)
```

## GetPlayerLuck

```lua
function MultiplierManager:GetPlayerLuck(EntityPlayer : userdata)
```

- `EntityPlayer` : userdata

- `Return` : Float

In the game there is no object or trinket that multiplies luck, but added just in case there is one in the future

### Example

```lua
local Mod = RegisterMod("YourMod", 1)

function Mod:DoCache(player, cacheflag)
    -- print the player luck multiplier
    print(MultiplierManager:GetPlayerLuck(player))
end
Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Mod.DoCache)
```

---

## ApplyMultiplier

```lua
function MultiplierManager:ApplyMultiplier(AddStat : float, EntityPlayer : userdata, MultiplierType : string)
```

- `AddStat` : Float - Stat that will be added and multiplied to the player stat

- `EntityPlayer` : userdata

- `MultiplierType` : String - Name of the stat (tears, damage, speed, range, shotspeed, luck). You can add "base" to declare that it is a base stat

- `Return` : Float

### Example

```lua
local Mod = RegisterMod("YourMod", 1)

function Mod:DoCache(player, cacheflag)
    if (cacheflag & CacheFlag.CACHE_DAMAGE) == CacheFlag.CACHE_DAMAGE then
        -- Removes 0.5 of damage and it wont be affected by Cracked Crown
        player.Damage = player.Damage - MultiplierManager:ApplyMultiplier(0.5, player, "BaseDamage" )
    elseif (cacheflag & CacheFlag.CACHE_LUCK) == CacheFlag.CACHE_LUCK then
        -- Adds 1 of luck. Cracked Crown by default doesn't affect the luck stat, but you can add the "Base" if you want
        player.Luck = player.Luck + MultiplierManager:ApplyMultiplier(1, player, "Luck")
    end
end
Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Mod.DoCache)
```

```lua
local Mod = RegisterMod("YourMod", 1)
local CustomItem = Isaac.GetItemIdByName("CustomItemName")

function Mod:DoCache(player, cacheflag)
    if not player:HasCollectible(CustomItem) then return end
    local ItemNum = player:GetCollectibleNum(CustomItem, false)

    if (cacheflag & CacheFlag.CACHE_FIREDELAY) == CacheFlag.CACHE_FIREDELAY then
        local tears = 30.0 / (player.MaxFireDelay + 1)
        -- Add 0.2 and Multiplies by the number of the same item and then applys the items multipliers
        player.MaxFireDelay = 30 / (tears + MultiplierManager:ApplyMultiplier(0.2 * ItemNum, player, "Tears") ) - 1
    elseif (cacheflag & CacheFlag.CACHE_SHOTSPEED) == CacheFlag.CACHE_SHOTSPEED then
        -- Add 0.1 and Multiplies by the number of the same item and then applys the items multipliers
        player.ShotSpeed = player.ShotSpeed + MultiplierManager:ApplyMultiplier(0.1 * ItemNum, player, "ShotSpeed")
    elseif (cacheflag & CacheFlag.CACHE_DAMAGE) == CacheFlag.CACHE_DAMAGE then
        -- Add 1.5 and Multiplies by the number of the same item and then applys the items multipliers
        player.Damage = player.Damage + MultiplierManager:ApplyMultiplier(1.5 * ItemNum, player, "Damage")
    end
    -- Because this stats aren't mark as "base" stats can be affected by Cracked Crown
end
Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Mod.DoCache)
```

---

## AddMiscMultiplier

```lua
function MultiplierManager:AddMiscMultiplier(StatType : string, MultName : string, Condition : function(_, player : userdata, IsBaseStat : bool) or bool,  Mult : function(_, player : userdata, IsBaseStat : bool) or float)
```

- `StatType` : String - Stat type (damage, tears, range, etc)

- `MultName` : String - Name of the condition

- `Condition` : Function or Bool - Returns '**True**' or '**False**' if the condition is met. You can set it as '**True**' to be allway be execute

- `Mult` : function or float - Returns the multiplier to apply

### Example

```lua
function MultiplierManager:AddMiscMultiplier(
    "Damage", -- stat type
    "Pentagram multiplier", -- name of the condition
    function(_, player) -- condition
        -- return true if the player has more than 1 pentagram
        return player:GetCollectibleNum(CollectibleType.COLLECTIBLE_PENTAGRAM) > 1
    end,
    -- give 1.5 damage multiplier
    1.5
)


function MultiplierManager:AddMiscMultiplier(
    "Tears", -- stat type
    "Cry Onion multiplier", -- name of the condition
    true, -- is allways gives a result
    -- give + 20% tears multiplier by how many crying onions has the player
    function(_, player)
        local onionNum = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_CRYING_ONION)
        return 1 + 0.2 * onionNum
    end
)
```

## GetMiscMultiplier

```lua
function MultiplierManager:GetMiscMultiplier(StatType : string, MultName : string)
```

- `StatType` : String - Stat type (damage, tears, range, etc)

- `MultName` : String - Name of the condition

- `Return` : Table -
  
  - `Condition` - Function(_, player : userdata, IsBaseStat : Bool) [return : Bool] or Bool
  
  - `Mult` - Function(_, player : userdata, IsBaseStat : Bool) [return : Float] or Float

---

## REPENTOGON Exclusive

The next items / multipliers only apply if REPENTOGON is installed

- `Dead Eye`

- `D8`

- `Epiphora`
