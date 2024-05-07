local VERSION = 2.5
MultiplierManager = MultiplierManager or {}

if MultiplierManager and MultiplierManager.Version and VERSION <= MultiplierManager.Version then return end

MultiplierManager.Version = VERSION


local LiquidPoopEffect = {
	NONE = 0,
	NORMAL = 1<<0,
	STONE = 1<<1,
	CORNY = 1<<2,
	BURNING = 1<<3,
	STINKY = 1<<4,
	BLACK = 1<<5,
	HOLY = 1<<6,
}

local StatsGenericMin = {
	DAMAGE = 3.5,
	TEARS = 2.73,
	SPEED = 1,
	RANGE = 6.5,
	SHOTSPEED = 1,
	LUCK = 0
}


local function CheckString(str)
	local str = string.gsub(string.gsub(string.upper(str), "[%_, %-, % ]", ""), "BASE", "")
	local sameNameTable = {
		["DMG"] = "DAMAGE",
		["TEAR"] = "TEARS",
		["MOVESPEED"] = "SPEED",
		["MOVEMENT"] = "SPEED",
		["TEARRANGE"] = "RANGE",
		["TEARSPEED"] = "SHOTSPEED",
		["TEARVELOCITY"] = "SHOTSPEED",
	}
	if sameNameTable[str] then
		return sameNameTable[str]
	end
	return str
end

local function ThrowError(str)
	local str = tostring(str)
	error(str, 2)
end

local function GetPlayerIndex(playerPtr)
	if playerPtr:GetPlayerType() == PlayerType.PLAYER_THESOUL_B and playerPtr:GetMainTwin() ~= nil then
		playerPtr = playerPtr:GetMainTwin()
	end
	return tostring(GetPtrHash(playerPtr))
end



MultiplierManager.PlayerMult = {
	[PlayerType.PLAYER_CAIN] 			= {Damage = 1.2},
	[PlayerType.PLAYER_JUDAS] 			= {Damage = 1.35},
	[PlayerType.PLAYER_BLUEBABY] 		= {Damage = 1.05},
	[PlayerType.PLAYER_EVE] 			= {Damage = function (_, player)
									    	if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON) then return 1 end
									    	return 0.75
									    end},
	[PlayerType.PLAYER_AZAZEL] 			= {Damage = 1.5, Tears = 0.267},
	[PlayerType.PLAYER_LAZARUS2] 		= {Damage = 1.4},
	[PlayerType.PLAYER_BLACKJUDAS] 		= {Damage = 2},
	[PlayerType.PLAYER_KEEPER]			= {Damage = 1.2},
	[PlayerType.PLAYER_THEFORGOTTEN] 	= {Damage = 1.5, Tears = 0.5},

	--Tainted Characters
	[PlayerType.PLAYER_MAGDALENE_B] 	= {Damage = 0.75},
	[PlayerType.PLAYER_CAIN_B]			= {Damage = 1.2},
	[PlayerType.PLAYER_EVE_B]			= {Damage = 1.2, Tears = 0.66},
	[PlayerType.PLAYER_AZAZEL_B] 		= {Damage = 1.5, Tears = 0.33},
	[PlayerType.PLAYER_THELOST_B] 		= {Damage = 1.3},
	[PlayerType.PLAYER_THEFORGOTTEN_B]	= {Damage = 1.5, Tears = 0.5},
	[PlayerType.PLAYER_LAZARUS2_B] 		= {Damage = 1.5},
}


MultiplierManager.ItemMult = {
	[CollectibleType.COLLECTIBLE_INNER_EYE]				= {Tears = function(_, player)
															if player:HasCollectible(CollectibleType.COLLECTIBLE_20_20) then return 1 end
															return 0.51
														end},
    [CollectibleType.COLLECTIBLE_CRICKETS_HEAD] 		= {Damage = 1.5},
    [CollectibleType.COLLECTIBLE_MY_REFLECTION]			= {Range = 2, ShotSpeed = 1.6},
    [CollectibleType.COLLECTIBLE_NUMBER_ONE]			= {Range = 0.8},
    [CollectibleType.COLLECTIBLE_BLOOD_OF_THE_MARTYR]	= {Damage = function(_, player)
															if not player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL) then return 1 end
															if player:HasCollectible(CollectibleType.COLLECTIBLE_CRICKETS_HEAD) or
																player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM) then 
																return 1
															end
															return 1.5
													    end},
    [CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM] 		= {Damage = function(_, player)
													    	if player:HasCollectible(CollectibleType.COLLECTIBLE_CRICKETS_HEAD) then return 1 end
													    	return 1.5
													    end},
	[CollectibleType.COLLECTIBLE_DR_FETUS]				= {Tears = function(_, player)
															if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_HAEMOLACRIA) or
																player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_KNIFE) or
																player:HasCollectible(CollectibleType.COLLECTIBLE_MONSTROS_LUNG)
																then
																return 1
															end
															return 0.4
														end},
	[CollectibleType.COLLECTIBLE_BRIMSTONE]				= {Damage = function(_, player)
															if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_HAEMOLACRIA) or
																player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_KNIFE) then
																return 1 
															elseif player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_BRIMSTONE) >= 2 then
																return 1.2
															elseif player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) then
																return 1.5
															end

															return 1
														end,
														Tears = function(_, player)
															if player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_KNIFE) then return 1 end
															return 0.33
														end},
    [CollectibleType.COLLECTIBLE_ODD_MUSHROOM_THIN] 	= {Damage = 0.9},
    [CollectibleType.COLLECTIBLE_IPECAC]				= {Tears = 0.33,
    													Range = function(_, player)
    														if player:HasCollectible(CollectibleType.COLLECTIBLE_NUMBER_ONE) then return 1 end
    														return 0.8
    													end,
    													ShotSpeed = 0.2},
	[CollectibleType.COLLECTIBLE_TECHNOLOGY_2]			= {Tears = 0.66},
	[CollectibleType.COLLECTIBLE_MUTANT_SPIDER]			= {Tears = function(_, player)
															if player:HasCollectible(CollectibleType.COLLECTIBLE_20_20) then return 1 end
															return 0.42
														end},
    [CollectibleType.COLLECTIBLE_POLYPHEMUS] 			= {Damage = 2,
    													Tears = function(_, player)
    														if player:HasCollectible(CollectibleType.COLLECTIBLE_INNER_EYE) or
    															player:HasCollectible(CollectibleType.COLLECTIBLE_MUTANT_SPIDER) or
    															player:HasCollectible(CollectibleType.COLLECTIBLE_20_20) or
    															player:HasCollectible(CollectibleType.COLLECTIBLE_C_SECTION) then
    															return 1
    														end
    														return 0.42
    													end},
    [CollectibleType.COLLECTIBLE_SACRED_HEART] 			= {Damage = 2.3},
    [CollectibleType.COLLECTIBLE_CRICKETS_BODY]			= {Range = function(_, player)
    														if player:HasCollectible(CollectibleType.COLLECTIBLE_IPECAC) then
    															return 1
    														end
    														return 0.8
    													end},
    [CollectibleType.COLLECTIBLE_MONSTROS_LUNG]			= {Tears = function(_, player)
    														if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BRIMSTONE) or
    															player:HasCollectible(CollectibleType.COLLECTIBLE_EPIC_FETUS) or
    															player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_KNIFE) or
    															player:HasCollectible(CollectibleType.COLLECTIBLE_LUDOVICO_TECHNIQUE) or
    															player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) or
    															player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SWORD) or
    															player:HasCollectible(CollectibleType.COLLECTIBLE_C_SECTION) then
    															return 1
    														elseif player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_X) then
    															return 0.32 --close enough
    														end
    	        											return 0.23
        												end},
    [CollectibleType.COLLECTIBLE_20_20] 				= {Damage = 0.8},
    [CollectibleType.COLLECTIBLE_EVES_MASCARA] 			= {Damage = 2, Tears = 0.66},
    [CollectibleType.COLLECTIBLE_SOY_MILK] 				= {Damage = function(_, player)
															if player:HasCollectible(CollectibleType.COLLECTIBLE_ALMOND_MILK) then return 1 end
															return 0.2
													    end,
														Tears = function(_, player)
															if player:HasCollectible(CollectibleType.COLLECTIBLE_ALMOND_MILK) then return 1 end
															return 5.5
														end},
	[CollectibleType.COLLECTIBLE_DEAD_EYE] 				= {Damage = function(_, player)
															if not (REPENTOGON and REPENTOGON["Real"]) or
																player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_X) then
																return 1
															end
															return 1 + (player:GetDeadEyeCharge() * 0.25)
														end},
    [CollectibleType.COLLECTIBLE_CROWN_OF_LIGHT] 		= {Damage = function(_, player)
															if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_CROWN_OF_LIGHT) then return 2 end
															return 1
													    end},
	[CollectibleType.COLLECTIBLE_HAEMOLACRIA] 			= {Damage = 1.5,
														Tears = function(_, player)
															if player:HasCollectible(CollectibleType.COLLECTIBLE_MONSTROS_LUNG) or
    															player:HasCollectible(CollectibleType.COLLECTIBLE_EPIC_FETUS) or
    															player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_KNIFE) or
    															player:HasCollectible(CollectibleType.COLLECTIBLE_LUDOVICO_TECHNIQUE) or
    															player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SWORD) or
    															player:HasCollectible(CollectibleType.COLLECTIBLE_C_SECTION) then
																return 1
															elseif player:HasCollectible(CollectibleType.COLLECTIBLE_IPECAC) then return 0.76 end -- is closer
    														return 0.5
    													end,
														Range = function(_, player)
    														if player:HasCollectible(CollectibleType.COLLECTIBLE_IPECAC) or
    															player:HasCollectible(CollectibleType.COLLECTIBLE_CRICKETS_BODY) then
    															return 1
    														end
    														return 0.8
    													end},
    [CollectibleType.COLLECTIBLE_ALMOND_MILK] 			= {Damage = 0.33, Tears = 4},
    [CollectibleType.COLLECTIBLE_IMMACULATE_HEART] 		= {Damage = 1.2},
    [CollectibleType.COLLECTIBLE_MEGA_MUSH] 			= {Damage = function(_, player)
													    	if not player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_MEGA_MUSH) then return 1 end
													    	return 4
													    end},
	[CollectibleType.COLLECTIBLE_BERSERK]				= {Tears = function(_, player)
															if not player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BERSERK) then return 1 end
															if player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN or
																player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN_B then
																return 1
															end
															return 0.5
														end}
}


MultiplierManager.TrinketMult = {}


local function checkHolyAura(_, player)
		for _, ent in pairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_LIQUID_POOP)) do
	        local effect = ent:ToEffect()
	        if effect.State == 64 and player.Position:DistanceSquared(ent.Position) <= 380 then
	            return true
	        end
	    end
		for _, ent in pairs(Isaac.FindByType(1000, EffectVariant.HALLOWED_GROUND, -1, false, false)) do
			if ent.Parent then
				local parent = ent.Parent
				if (parent.Type == EntityType.ENTITY_POOP and parent.Variant == 16) or (parent.Type == EntityType.ENTITY_FAMILIAR and parent.Variant == FamiliarVariant.STAR_OF_BETHLEHEM) then
					if ent.Position:DistanceSquared(player.Position) <= 6400 then
						return true
					end
				elseif (parent.Type == EntityType.ENTITY_FAMILIAR and parent.Variant == FamiliarVariant.DIP and parent.SubType == 6) then
					if ent.Position:DistanceSquared(player.Position) <= 1000 then
						return true
					end
				end
			end
		end
		return false
	end

MultiplierManager.MiscMult = {
	["DAMAGE"] = {
		["D8 Mult"] = {
			Condition = function() return (REPENTOGON and REPENTOGON["Real"]) end,
			Mult = function(_, player) return player:GetD8DamageModifier() end
		},
		["Holy Aura"] = {
			Condition = checkHolyAura,
			Mult = function(_, player)
				for _, ent in pairs(Isaac.FindByType(3, FamiliarVariant.STAR_OF_BETHLEHEM, -1, false, false)) do
					if ent.Position:DistanceSquared(player.Position) <= 6400 then
						return 1.8
					end
				end
				return 1.2
			end
		}
	},
	["TEARS"] = {
		["D8 Mult"] = {
			Condition = function() return (REPENTOGON and REPENTOGON["Real"]) end,
			Mult = function(_, player) return player:GetD8FireDelayModifier() end
		},
		["Epiphora Mult"] = {
			Condition = function() return (REPENTOGON and REPENTOGON["Real"]) end,
			Mult = function(_, player)
				local charge = player:GetEpiphoraCharge()
			    if charge >= 270 then
			        return 2
			    elseif charge >= 180 then
			        return 1.66
			    elseif charge >= 90 then
			        return 1.33
			    end
			    return 1
			end
		},
		["Holy Aura"] = {
			Condition = checkHolyAura,
			Mult = 2.5
		}
	},
	["SPEED"] = {
		["D8 Mult"] = {
			Condition = function() return (REPENTOGON and REPENTOGON["Real"]) end,
			Mult = function(_, player) return player:GetD8SpeedModifier() end
		},
	},
	["RANGE"] = {
		["D8 Mult"] = {
			Condition = function() return (REPENTOGON and REPENTOGON["Real"]) end,
			Mult = function(_, player) return player:GetD8RangeModifier() end
		},
	},
	["SHOTSPEED"] = {},
	["LUCK"] = {}
}

--[[
mult = {
	Damage = function(_, player, isBaseStats) [return :  float] / float,
	Tears = function(_, player, isBaseStats) [return :  float] / float,
	Speed = function(_, player, isBaseStats) [return :  float] / float,
	ShotSpeed = function(_, player, isBaseStats) [return :  float] / float,
	Range = function(_, player, isBaseStats) [return :  float] / float,
	Luck = function(_, player, isBaseStats) [return :  float] / float,
}
]]

---@param itemID	- CollectibleType (int)
---@param mult 		- table
function MultiplierManager:RegisterItem(itemID, mult)
	MultiplierManager.ItemMult[itemID] = mult
end
function MultiplierManager:RegisterItemMultipliers(itemID, mult) MultiplierManager:RegisterItem(itemID, mult) end -- old name to not cause errors

---@param trinketID	- TrinketType (int)
---@param mult 		- table
function MultiplierManager:RegisterTrinket(trinketID, mult)
	MultiplierManager.TrinketMult[trinketID] = mult
end
function MultiplierManager:RegisterTrinketMultipliers(trinketID, mult) MultiplierManager:RegisterTrinket(trinketID, mult) end -- old name to not cause errors

---@param playerID	- PlayerType (int)
---@param mult 		- table
function MultiplierManager:RegisterPlayer(playerID, mult)
	MultiplierManager.PlayerMult[playerID] = mult
end
function MultiplierManager:RegisterPlayerMultipliers(playerID, mult) MultiplierManager:RegisterPlayer(playerID, mult) end -- old name to not cause errors



---@param itemID	- CollectibleType (int)
---@return table
function MultiplierManager:GetItem(itemID)
	local ItemMults = MultiplierManager.ItemMult[itemID] or {}
	return {
		Damage 		= ItemMults.Damage or 1,
		Tears 		= ItemMults.Tears or 1,
		Speed 		= ItemMults.Speed or 1,
		ShotSpeed 	= ItemMults.ShotSpeed or 1,
		Range 		= ItemMults.Range or 1,
		Luck 		= ItemMults.Luck or 1,
	}
end
function MultiplierManager:GetItemMultipliers(itemID) return MultiplierManager:GetItem(itemID) end -- old name to not cause errors

---@param trinketID	- TrinketType (int)
---@return table
function MultiplierManager:GetTrinket(trinketID)
	local TrinketMults = MultiplierManager.TrinketMult[trinketID] or {}
	return {
		Damage 		= TrinketMults.Damage or 1,
		Tears 		= TrinketMults.Tears or 1,
		Speed 		= TrinketMults.Speed or 1,
		ShotSpeed 	= TrinketMults.ShotSpeed or 1,
		Range 		= TrinketMults.Range or 1,
		Luck 		= TrinketMults.Luck or 1,
	}
end
function MultiplierManager:GetTrinketMultipliers(trinketID) return MultiplierManager:GetTrinket(trinketID) end -- old name to not cause errors

---@param playerID	- PlayerType (int)
---@return table
function MultiplierManager:GetPlayer(playerID)
	local PlayerMults = MultiplierManager.PlayerMult[playerID] or {}
	return {
		Damage 		= PlayerMults.Damage or 1,
		Tears 		= PlayerMults.Tears or 1,
		Speed 		= PlayerMults.Speed or 1,
		ShotSpeed 	= PlayerMults.ShotSpeed or 1,
		Range 		= PlayerMults.Range or 1,
		Luck 		= PlayerMults.Luck or 1,
	}
end
function MultiplierManager:GetPlayerMultipliers(playerID) return MultiplierManager:GetPlayer(playerID) end -- old name to not cause errors



---@param player	- EntityPlayer (usedata)
---@return float
function MultiplierManager:GetCrackedCrown(player)
	return 1 + (player:GetTrinketMultiplier(TrinketType.TRINKET_CRACKED_CROWN) * 0.2)
end
function MultiplierManager:GetCrackedCrownMultiplier(player) return MultiplierManager:GetCrackedCrown(player) end -- old name to not cause errors


---@param player	- EntityPlayer (usedata)
---@param StatType 	- string
---@return bool
function MultiplierManager:CanGiveCrackedCrowMult(player, StatType)
	local StatType = CheckString(StatType)
	if StatsGenericMin[StatType] and StatType ~= "LUCK" then
		local PlayersStats = {
			DAMAGE = player.Damage,
			TEARS = player.MaxFireDelay,
			SPEED = player.MoveSpeed,
			RANGE = player.TearRange,
			SHOTSPEED = player.ShotSpeed
		}
		return PlayersStats[StatType] > MultiplierManager:ApplyMultiplier(StatsGenericMin[StatType], player, StatType)
	end
	return false
end



---@param MultName		- string
---@param Condition		- function(_, player, isBaseStats) [return : bool] / bool
---@param Mult			- function(_, player, isBaseStats) [return : float] / float
function MultiplierManager:AddMiscMultiplier(StatType, MultName, Condition, Mult)
	local StatType = CheckString(StatType)
	local MultName = tostring(MultName)

	if not MultName then
		ThrowError("Error MultiplierManager:AddMiscMultiplier : Argument #2 is nil")
		return
	elseif not MultiplierManager.MiscMult[StatType] then
		ThrowError("Error MultiplierManager:AddMiscMultiplier : Trying to add a stat that doesn't exist")
		return 
	end

	if MultiplierManager.MiscMult[StatType][MultName] then
		Isaac.DebugString("MultiplierManager:AddMiscMultiplier : Over writing \"".. MultName .."\"")
	end

	MultiplierManager.MiscMult[StatType][MultName] = {}
	MultiplierManager.MiscMult[StatType][MultName].Condition = Condition or true
	MultiplierManager.MiscMult[StatType][MultName].Mult = Mult or 1
end
function MultiplierManager:AddMultiplierCondition(StatType, MultName, Condition, Mult) MultiplierManager:AddMiscMultiplier(StatType, MultName, Condition, Mult) end -- old name to not cause errors


---@param MultName	- string
---@return table
function MultiplierManager:GetMiscMultiplier(StatType, MultName)
	local StatType = CheckString(StatType)
	if not MultiplierManager.MiscMult[StatType] then
		ThrowError("Error MultiplierManager:GetMiscMultiplier : Trying to get a stat that doesn't exist")
		return {Condition = false, Mult = 1}
	end
	return MultiplierManager.MiscMult[StatType][MultName] or {Condition = false, Mult = 1}
end
function MultiplierManager:GetMultiplierCondition(StatType, MultName) -- old name to not cause errors
	local mults = MultiplierManager:GetMiscMultiplier(StatType, MultName)
	return {Condition = mults.Condition, Result = mults.Mult} -- serve the old way :)
end




---@param player		- EntityPlayer (usedata)
function MultiplierManager:GetPlayerDamage(player)
	local pCache = player:GetData().MultiplierManager_CacheEvaluation
	if pCache and pCache.Damage and pCache.Damage.Mult and (pCache.Damage.FrameCached and pCache.Damage.FrameCached == Game():GetFrameCount()) then
		return pCache.Damage.Mult
	end


	local totalMult = MultiplierManager:GetPlayer(player:GetPlayerType()).Damage

	if type(totalMult) == "function" then totalMult = totalMult(_, player) end

	for itemID, itemMult in pairs(MultiplierManager.ItemMult) do
		local addDamage = itemMult.Damage
		if (player:HasCollectible(itemID) or player:GetEffects():HasCollectibleEffect(itemID)) and addDamage then
			if type(addDamage) == "function" then
				totalMult = totalMult * addDamage(_, player)
			else
				totalMult = totalMult * addDamage
			end
		end
	end

	for trinketID, trinketMult in pairs(MultiplierManager.TrinketMult) do
		local addDamage = trinketMult.Damage
		if (player:HasTrinket(trinketID) or player:GetEffects():HasTrinketEffect(trinketID)) and addDamage then
			if type(addDamage) == "function" then
				totalMult = totalMult * addDamage(_, player)
			else
				totalMult = totalMult * addDamage
			end
		end
	end

	for name, ConData in pairs(MultiplierManager.MiscMult.DAMAGE) do
		local condition = ConData.Condition
		local addDamage = ConData.Mult
		if type(condition) == "function" then
			condition = condition(_, player)
		end
		if condition then
			if type(addDamage) == "function" then
				totalMult = totalMult * addDamage(_, player)
			else
				totalMult = totalMult * addDamage
			end
		end
	end

	if (player:HasTrinket(TrinketType.TRINKET_CRACKED_CROWN) or player:GetEffects():HasTrinketEffect(TrinketType.TRINKET_CRACKED_CROWN)) then
		if player.Damage > totalMult * StatsGenericMin.DAMAGE then
			totalMult = totalMult * MultiplierManager:GetCrackedCrown(player)
		end
	end

	player:GetData().MultiplierManager_CacheEvaluation = pCache or {}
	player:GetData().MultiplierManager_CacheEvaluation.Damage = {Mult = totalMult, FrameCached = Game():GetFrameCount()}
	return totalMult
end
function MultiplierManager:GetDamageMultiplier(player, IsBaseStats) return MultiplierManager:GetPlayerDamage(player, IsBaseStats) end -- old name to not cause errors


---@param player		- EntityPlayer (usedata)
function MultiplierManager:GetPlayerTears(player)
	local pCache = player:GetData().MultiplierManager_CacheEvaluation
	if pCache and pCache.Tears and pCache.Tears.Mult and (pCache.Tears.FrameCached and pCache.Tears.FrameCached == Game():GetFrameCount()) then
		return pCache.Tears.Mult
	end


	local totalMult = MultiplierManager:GetPlayer(player:GetPlayerType()).Tears

	if type(totalMult) == "function" then totalMult = totalMult(_, player) end

	for itemID, itemMult in pairs(MultiplierManager.ItemMult) do
		local addTears = itemMult.Tears
		if (player:HasCollectible(itemID) or player:GetEffects():HasCollectibleEffect(itemID)) and addTears then
			if type(addTears) == "function" then
				totalMult = totalMult * addTears(_, player)
			else
				totalMult = totalMult * addTears
			end
		end
	end

	for trinketID, trinketMult in pairs(MultiplierManager.TrinketMult) do
		local addTears = trinketMult.Tears
		if (player:HasTrinket(trinketID) or player:GetEffects():HasTrinketEffect(trinketID)) and addTears then
			if type(addTears) == "function" then
				totalMult = totalMult * addTears(_, player)
			else
				totalMult = totalMult * addTears
			end
		end
	end

	for name, ConData in pairs(MultiplierManager.MiscMult.TEARS) do
		local condition = ConData.Condition
		local addTears = ConData.Mult
		if type(condition) == "function" then
			condition = condition(_, player)
		end
		if condition then
			if type(addTears) == "function" then
				totalMult = totalMult * addTears(_, player)
			else
				totalMult = totalMult * addTears
			end
		end
	end

	if (player:HasTrinket(TrinketType.TRINKET_CRACKED_CROWN) or player:GetEffects():HasTrinketEffect(TrinketType.TRINKET_CRACKED_CROWN)) then
		if player.MaxFireDelay > totalMult * StatsGenericMin.TEARS then
			totalMult = totalMult * MultiplierManager:GetCrackedCrown(player)
		end
	end

	player:GetData().MultiplierManager_CacheEvaluation = pCache or {}
	player:GetData().MultiplierManager_CacheEvaluation.Tears = {Mult = totalMult, FrameCached = Game():GetFrameCount()}
	return totalMult
end
function MultiplierManager:GetTearsMultiplier(player, IsBaseStats) return MultiplierManager:GetPlayerTears(player, IsBaseStats) end -- old name to not cause errors


---@param player		- EntityPlayer (usedata)
function MultiplierManager:GetPlayerSpeed(player)
	local pCache = player:GetData().MultiplierManager_CacheEvaluation
	if pCache and pCache.Speed and pCache.Speed.Mult and (pCache.Speed.FrameCached and pCache.Speed.FrameCached == Game():GetFrameCount()) then
		return pCache.Speed.Mult
	end


	local totalMult = MultiplierManager:GetPlayer(player:GetPlayerType()).Speed

	if type(totalMult) == "function" then totalMult = totalMult(_, player) end

	for itemID, itemMult in pairs(MultiplierManager.ItemMult) do
		local addSpeed = itemMult.Speed
		if (player:HasCollectible(itemID) or player:GetEffects():HasCollectibleEffect(itemID)) and addSpeed then
			if type(addSpeed) == "function" then
				totalMult = totalMult * addSpeed(_, player)
			else
				totalMult = totalMult * addSpeed
			end
		end
	end

	for trinketID, trinketMult in pairs(MultiplierManager.TrinketMult) do
		local addSpeed = trinketMult.Speed
		if (player:HasTrinket(trinketID) or player:GetEffects():HasTrinketEffect(trinketID)) and addSpeed then
			if type(addSpeed) == "function" then
				totalMult = totalMult * addSpeed(_, player)
			else
				totalMult = totalMult * addSpeed
			end
		end
	end

	for name, ConData in pairs(MultiplierManager.MiscMult.SPEED) do
		local condition = ConData.Condition
		local addSpeed = ConData.Mult
		if type(condition) == "function" then
			condition = condition(_, player)
		end
		if condition then
			if type(addSpeed) == "function" then
				totalMult = totalMult * addSpeed(_, player)
			else
				totalMult = totalMult * addSpeed
			end
		end
	end

	if (player:HasTrinket(TrinketType.TRINKET_CRACKED_CROWN) or player:GetEffects():HasTrinketEffect(TrinketType.TRINKET_CRACKED_CROWN)) then
		if player.MoveSpeed > totalMult * StatsGenericMin.SPEED then
			totalMult = totalMult * MultiplierManager:GetCrackedCrown(player)
		end
	end

	player:GetData().MultiplierManager_CacheEvaluation = pCache or {}
	player:GetData().MultiplierManager_CacheEvaluation.Speed = {Mult = totalMult, FrameCached = Game():GetFrameCount()}
	return totalMult
end
function MultiplierManager:GetSpeedMultiplier(player, IsBaseStats) return MultiplierManager:GetPlayerSpeed(player, IsBaseStats) end -- old name to not cause errors


---@param player		- EntityPlayer (usedata)
function MultiplierManager:GetPlayerRange(player)
	local pCache = player:GetData().MultiplierManager_CacheEvaluation
	if pCache and pCache.Range and pCache.Range.Mult and (pCache.Range.FrameCached and pCache.Range.FrameCached == Game():GetFrameCount()) then
		return pCache.Range.Mult
	end


	local totalMult = MultiplierManager:GetPlayer(player:GetPlayerType()).Range

	if type(totalMult) == "function" then totalMult = totalMult(_, player) end

	for itemID, itemMult in pairs(MultiplierManager.ItemMult) do
		local addRange = itemMult.Range
		if (player:HasCollectible(itemID) or player:GetEffects():HasCollectibleEffect(itemID)) and addRange then
			if type(addRange) == "function" then
				totalMult = totalMult * addRange(_, player)
			else
				totalMult = totalMult * addRange
			end
		end
	end

	for trinketID, trinketMult in pairs(MultiplierManager.TrinketMult) do
		local addRange = trinketMult.Range
		if (player:HasTrinket(trinketID) or player:GetEffects():HasTrinketEffect(trinketID)) and addRange then
			if type(addRange) == "function" then
				totalMult = totalMult * addRange(_, player)
			else
				totalMult = totalMult * addRange
			end
		end
	end

	for name, ConData in pairs(MultiplierManager.MiscMult.RANGE) do
		local condition = ConData.Condition
		local addRange = ConData.Mult
		if type(condition) == "function" then
			condition = condition(_, player)
		end
		if condition then
			if type(addRange) == "function" then
				totalMult = totalMult * addRange(_, player)
			else
				totalMult = totalMult * addRange
			end
		end
	end

	if (player:HasTrinket(TrinketType.TRINKET_CRACKED_CROWN) or player:GetEffects():HasTrinketEffect(TrinketType.TRINKET_CRACKED_CROWN)) then
		if player.TearRange > totalMult * StatsGenericMin.RANGE then
			totalMult = totalMult * MultiplierManager:GetCrackedCrown(player)
		end
	end

	player:GetData().MultiplierManager_CacheEvaluation = pCache or {}
	player:GetData().MultiplierManager_CacheEvaluation.Range = {Mult = totalMult, FrameCached = Game():GetFrameCount()}
	return totalMult
end
function MultiplierManager:GetRangeMultiplier(player, IsBaseStats) return MultiplierManager:GetPlayerRange(player, IsBaseStats) end -- old name to not cause errors


---@param player		- EntityPlayer (usedata)
function MultiplierManager:GetPlayerShotSpeed(player)
	local pCache = player:GetData().MultiplierManager_CacheEvaluation
	if pCache and pCache.ShotSpeed and pCache.ShotSpeed.Mult and (pCache.ShotSpeed.FrameCached and pCache.ShotSpeed.FrameCached == Game():GetFrameCount()) then
		return pCache.ShotSpeed.Mult
	end


	local totalMult = MultiplierManager:GetPlayer(player:GetPlayerType()).ShotSpeed

	if type(totalMult) == "function" then totalMult = totalMult(_, player) end

	for itemID, itemMult in pairs(MultiplierManager.ItemMult) do
		local addShotSpeed = itemMult.ShotSpeed
		if (player:HasCollectible(itemID) or player:GetEffects():HasCollectibleEffect(itemID)) and addShotSpeed then
			if type(addShotSpeed) == "function" then
				totalMult = totalMult * addShotSpeed(_, player)
			else
				totalMult = totalMult * addShotSpeed
			end
		end
	end

	for trinketID, trinketMult in pairs(MultiplierManager.TrinketMult) do
		local addShotSpeed = trinketMult.ShotSpeed
		if (player:HasTrinket(trinketID) or player:GetEffects():HasTrinketEffect(trinketID)) and addShotSpeed then
			if type(addShotSpeed) == "function" then
				totalMult = totalMult * addShotSpeed(_, player)
			else
				totalMult = totalMult * addShotSpeed
			end
		end
	end

	for name, ConData in pairs(MultiplierManager.MiscMult.SHOTSPEED) do
		local condition = ConData.Condition
		local addShotSpeed = ConData.Mult
		if type(condition) == "function" then
			condition = condition(_, player)
		end
		if condition then
			if type(addShotSpeed) == "function" then
				totalMult = totalMult * addShotSpeed(_, player)
			else
				totalMult = totalMult * addShotSpeed
			end
		end
	end

	if (player:HasTrinket(TrinketType.TRINKET_CRACKED_CROWN) or player:GetEffects():HasTrinketEffect(TrinketType.TRINKET_CRACKED_CROWN)) then
		if player.ShotSpeed > totalMult * StatsGenericMin.SHOTSPEED then
			totalMult = totalMult * MultiplierManager:GetCrackedCrown(player)
		end
	end

	player:GetData().MultiplierManager_CacheEvaluation = pCache or {}
	player:GetData().MultiplierManager_CacheEvaluation.ShotSpeed = {Mult = totalMult, FrameCached = Game():GetFrameCount()}
	return totalMult
end
function MultiplierManager:GetShotSpeedMultiplier(player, IsBaseStats) return MultiplierManager:GetPlayerShotSpeed(player, IsBaseStats) end -- old name to not cause errors


---@param player		- EntityPlayer (usedata)
function MultiplierManager:GetPlayerLuck(player)
	local pCache = player:GetData().MultiplierManager_CacheEvaluation
	if pCache and pCache.Luck and pCache.Luck.Mult and (pCache.Luck.FrameCached and pCache.Luck.FrameCached == Game():GetFrameCount()) then
		return pCache.Luck.Mult
	end


	local totalMult = MultiplierManager:GetPlayer(player:GetPlayerType()).Luck

	if type(totalMult) == "function" then totalMult = totalMult(_, player) end

	for itemID, itemMult in pairs(MultiplierManager.ItemMult) do
		local addLuck = itemMult.Luck
		if (player:HasCollectible(itemID) or player:GetEffects():HasCollectibleEffect(itemID)) and addLuck then
			if type(addLuck) == "function" then
				totalMult = totalMult * addLuck(_, player)
			else
				totalMult = totalMult * addLuck
			end
		end
	end

	for trinketID, trinketMult in pairs(MultiplierManager.TrinketMult) do
		local addLuck = trinketMult.Luck
		if (player:HasTrinket(trinketID) or player:GetEffects():HasTrinketEffect(trinketID)) and addLuck then
			if type(addLuck) == "function" then
				totalMult = totalMult * addLuck(_, player)
			else
				totalMult = totalMult * addLuck
			end
		end
	end

	for name, ConData in pairs(MultiplierManager.MiscMult.LUCK) do
		local condition = ConData.Condition
		local addLuck = ConData.Mult
		if type(condition) == "function" then
			condition = condition(_, player)
		end
		if condition then
			if type(addLuck) == "function" then
				totalMult = totalMult * addLuck(_, player)
			else
				totalMult = totalMult * addLuck
			end
		end
	end

	player:GetData().MultiplierManager_CacheEvaluation = pCache or {}
	player:GetData().MultiplierManager_CacheEvaluation.Luck = {Mult = totalMult, FrameCached = Game():GetFrameCount()}
	return totalMult
end
function MultiplierManager:GetLuckMultiplier(player, IsBaseStats) return MultiplierManager:GetPlayerLuck(player, IsBaseStats) end -- old name to not cause errors


---@param AddStat		- float
---@param player		- EntityPlayer (usedata)
---@param StatType		- string
function MultiplierManager:ApplyMultiplier(AddStat, player, StatType)
	local AddStat = type(AddStat) == "number" and AddStat or 0

	if type(StatType) ~= "string" then
		ThrowError("Error MultiplierManager:ApplyMultiplier : Argument #3 isn't a string")
		return 0
	end
	local StatType = CheckString(StatType)


	if StatType == "TEARS" then
		return AddStat * MultiplierManager:GetPlayerTears(player)
	elseif StatType == "DAMAGE" then
		return AddStat * MultiplierManager:GetPlayerDamage(player)
	elseif StatType == "SPEED" then
		return AddStat * MultiplierManager:GetPlayerSpeed(player)
	elseif StatType == "RANGE" then
		return AddStat * MultiplierManager:GetPlayerRange(player)
	elseif StatType == "SHOTSPEED" then
		return AddStat * MultiplierManager:GetPlayerShotSpeed(player)
	elseif StatType == "LUCK" then
		return AddStat * MultiplierManager:GetPlayerLuck(player)
	end

	ThrowError("Error MultiplierManager:ApplyMultiplier : Argument #3 is an unknown value")
	return 0
end
function MultiplierManager:ApplyMultipliers(AddStat, player, StatType) return MultiplierManager:ApplyMultiplier(AddStat, player, StatType) end -- old name to not cause errors