local VERSION = 1.3
MultiplierManager = MultiplierManager or {}

if MultiplierManager and MultiplierManager.Version and VERSION <= MultiplierManager.Version then return end

MultiplierManager.Version = VERSION

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
															if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_20_20) then return 1 end
															return 0.51
														end},
    [CollectibleType.COLLECTIBLE_CRICKETS_HEAD] 		= {Damage = 1.5},
    [CollectibleType.COLLECTIBLE_MY_REFLECTION]			= {Range = 2, ShotSpeed = 1.6},
    [CollectibleType.COLLECTIBLE_NUMBER_ONE]			= {Range = 0.8},
    [CollectibleType.COLLECTIBLE_BLOOD_OF_THE_MARTYR]	= {Damage = function(_, player)
															if not player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL) then return 1 end
															if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_CRICKETS_HEAD) or
																player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM) then 
																return 1
															end
															return 1.5
													    end},
    [CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM] 		= {Damage = function(_, player)
													    	if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_CRICKETS_HEAD) then return 1 end
													    	return 1.5
													    end},
	[CollectibleType.COLLECTIBLE_DR_FETUS]				= {Tears = function(_, player)
															if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_HAEMOLACRIA) or
																player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_MOMS_KNIFE) or
																player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_MONSTROS_LUNG)
																then
																return 1
															end
															return 0.4
														end},
	[CollectibleType.COLLECTIBLE_BRIMSTONE]				= {Damage = function(_, player)
															if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_HAEMOLACRIA) or
																player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_MOMS_KNIFE) then
																return 1 
															elseif player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_BRIMSTONE) >= 2 then
																return 1.2
															elseif player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_TECHNOLOGY) then
																return 1.5
															end

															return 1
														end,
														Tears = function(_, player)
															if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_MOMS_KNIFE) then return 1 end
															return 0.33
														end},
    [CollectibleType.COLLECTIBLE_ODD_MUSHROOM_THIN] 	= {Damage = 0.9},
    [CollectibleType.COLLECTIBLE_IPECAC]				= {Tears = 0.33,
    													Range = function(_, player)
    														if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_NUMBER_ONE) then return 1 end
    														return 0.8
    													end,
    													ShotSpeed = 0.2},
	[CollectibleType.COLLECTIBLE_TECHNOLOGY_2]			= {Tears = 0.66},
	[CollectibleType.COLLECTIBLE_MUTANT_SPIDER]			= {Tears = function(_, player)
															if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_20_20) then return 1 end
															return 0.42
														end},
    [CollectibleType.COLLECTIBLE_POLYPHEMUS] 			= {Damage = 2,
    													Tears = function(_, player)
    														if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_INNER_EYE) or
    															player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_MUTANT_SPIDER) or
    															player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_20_20) or
    															player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_C_SECTION) then
    															return 1
    														end
    														return 0.42
    													end},
    [CollectibleType.COLLECTIBLE_SACRED_HEART] 			= {Damage = 2.3},
    [CollectibleType.COLLECTIBLE_CRICKETS_BODY]			= {Range = function(_, player)
    														if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_IPECAC) then
    															return 1
    														end
    														return 0.8
    													end},
    [CollectibleType.COLLECTIBLE_MONSTROS_LUNG]			= {Tears = function(_, player)
    														if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BRIMSTONE) or
    															player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_EPIC_FETUS) or
    															player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_MOMS_KNIFE) or
    															player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_LUDOVICO_TECHNIQUE) or
    															player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_TECHNOLOGY) or
    															player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_SPIRIT_SWORD) or
    															player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_C_SECTION) then
    															return 1
    														elseif player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_TECH_X) then
    															return 0.32 --close enough
    														end
    	        											return 0.23
        												end},
    [CollectibleType.COLLECTIBLE_20_20] 				= {Damage = 0.8},
    [CollectibleType.COLLECTIBLE_EVES_MASCARA] 			= {Damage = 2, Tears = 0.66},
    [CollectibleType.COLLECTIBLE_SOY_MILK] 				= {Damage = function(_, player)
															if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_ALMOND_MILK) then return 1 end
															return 0.2
													    end,
														Tears = function(_, player)
															if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_ALMOND_MILK) then return 1 end
															return 5.5
														end},
	[CollectibleType.COLLECTIBLE_DEAD_EYE] 				= {Damage = function(_, player)
															if not (REPENTOGON and REPENTOGON["Real"]) or
																player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_TECH_X) then
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
															if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_MONSTROS_LUNG) or
    															player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_EPIC_FETUS) or
    															player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_MOMS_KNIFE) or
    															player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_LUDOVICO_TECHNIQUE) or
    															player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_SPIRIT_SWORD) or
    															player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_C_SECTION) then
																return 1
															elseif player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_IPECAC) then return 0.3 end
    														return 0.5
    													end,
														Range = function(_, player)
    														if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_IPECAC) or
    															player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_CRICKETS_BODY) then
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


MultiplierManager.TrinketMult = {
	[TrinketType.TRINKET_CRACKED_CROWN] = {
		Damage = MultiplierManager.GetCrackedCrownMultiplier,
		Tears = MultiplierManager.GetCrackedCrownMultiplier,
		Speed = MultiplierManager.GetCrackedCrownMultiplier,
		Range = MultiplierManager.GetCrackedCrownMultiplier,
		ShotSpeed = MultiplierManager.GetCrackedCrownMultiplier
	}
}


MultiplierManager.MultCondition = {
	["DAMAGE"] = {
		["D8 Mult"] = {
			Condition = function() return (REPENTOGON and REPENTOGON["Real"]) end,
			Result = function(_, player)
				return player:GetD8DamageModifier()
			end
		},
		["Holy Aura"] = {
			Condition = function(_, player)
				for _, ent in pairs(Isaac.FindByType(1000, EffectVariant.HALLOWED_GROUND, -1, false, false)) do
					if ent.Position:DistanceSquared(player.Position) <= 6800 then
						return true
					end
				end
				return false
			end,
			Result = function(_, player)
				for _, ent in pairs(Isaac.FindByType(3, FamiliarVariant.STAR_OF_BETHLEHEM, -1, false, false)) do
					if ent.Position:DistanceSquared(player.Position) <= 6800 then
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
			Result = function(_, player)
				return player:GetD8FireDelayModifier()
			end
		},
		["Holy Aura"] = {
			Condition = function(_, player)
				for _, ent in pairs(Isaac.FindByType(1000, EffectVariant.HALLOWED_GROUND, -1, false, false)) do
					if ent.Position:DistanceSquared(player.Position) <= 6800 then
						return true
					end
				end
				return false
			end,
			Result = 2.5
		}
	},
	["SPEED"] = {
		["D8 Mult"] = {
			Condition = function() return (REPENTOGON and REPENTOGON["Real"]) end,
			Result = function(_, player)
				return player:GetD8SpeedModifier()
			end
		},
	},
	["RANGE"] = {
		["D8 Mult"] = {
			Condition = function() return (REPENTOGON and REPENTOGON["Real"]) end,
			Result = function(_, player)
				return player:GetD8RangeModifier()
			end
		},
	},
	["SHOTSPEED"] = {},
	["LUCK"] = {}
}


local function CheckString(str)
	local str, base = string.gsub(string.gsub(string.upper(str), "[%_, %-, % ]", ""), "BASE", "")
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
		return sameNameTable[str], base
	end
	return str, base
end

local function ThrowError(str)
	local str = tostring(str)
	error(str, 2)
	Isaac.DebugString(str)
end

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
function MultiplierManager:RegisterItemMultipliers(itemID, mult)
	MultiplierManager.ItemMult[itemID] = mult
end

---@param trinketID	- TrinketType (int)
---@param mult 		- table
function MultiplierManager:RegisterTrinketMultipliers(trinketID, mult)
	MultiplierManager.TrinketMult[trinketID] = mult
end

---@param playerID	- PlayerType (int)
---@param mult 		- table
function MultiplierManager:RegisterPlayerMultipliers(playerID, mult)
	MultiplierManager.PlayerMult[playerID] = mult
end


---@param itemID	- CollectibleType (int)
---@return table
function MultiplierManager:GetItemMultipliers(itemID)
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

---@param trinketID	- TrinketType (int)
---@return table
function MultiplierManager:GetTrinketMultipliers(trinketID)
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

---@param playerID	- PlayerType (int)
---@return table
function MultiplierManager:GetPlayerMultipliers(playerID)
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


---@param player	- EntityPlayer (usedata)
---@return float
function MultiplierManager:GetCrackedCrownMultiplier(player)
	return 1 + (player:GetTrinketMultiplier(TrinketType.TRINKET_CRACKED_CROWN) * 0.2)
end


---@param ConditionName	- string
---@param Condition		- function(_, player, isBaseStats) [return : bool] / bool
---@param Result		- function(_, player, isBaseStats) [return : float] / float
function MultiplierManager:AddMultiplierCondition(StatType, ConditionName, Condition, Result)
	local StatType = CheckString(StatType)
	local ConditionName = tostring(ConditionName)

	if not ConditionName then
		ThrowError("Error MultiplierManager:GetMultiplierCondition : Argument #2 is nil")
		return
	elseif not MultiplierManager.MultCondition[StatType] then
		ThrowError("Error MultiplierManager:GetMultiplierCondition : Trying to add a stat that doesn't exist")
		return 
	end

	if MultiplierManager.MultCondition[StatType][ConditionName] then
		Isaac.DebugString("MultiplierManager : AddMultiplierCondition - Over writing \"".. ConditionName .."\"")
	end

	MultiplierManager.MultCondition[StatType][ConditionName] = {}
	MultiplierManager.MultCondition[StatType][ConditionName].Condition = Condition or true
	MultiplierManager.MultCondition[StatType][ConditionName].Result = Result or 1
end

---@param ConditionName	- string
---@return table
function MultiplierManager:GetMultiplierCondition(StatType, ConditionName)
	local StatType = CheckString(StatType)
	if not MultiplierManager.MultCondition[StatType] then
		ThrowError("Error MultiplierManager:GetMultiplierCondition : Trying to get a stat that doesn't exist")
		return {Condition = false, Result = 1}
	end
	return MultiplierManager.MultCondition[StatType][ConditionName] or {Condition = false, Result = 1}
end




---@param player		- EntityPlayer (usedata)
---@param IsBaseStats	- boolean - Default false
function MultiplierManager:GetDamageMultiplier(player, IsBaseStats)
	local IsBaseStats = IsBaseStats or false
	local totalMult = MultiplierManager:GetPlayerMultipliers(player:GetPlayerType()).Damage

	if type(totalMult) == "function" then totalMult = totalMult(_, player) end

	for itemID, itemMult in pairs(MultiplierManager.ItemMult) do
		local addDamage = itemMult.Damage
		if (player:HasCollectible(itemID) or player:GetEffects():HasCollectibleEffect(itemID)) and addDamage then
			if type(addDamage) == "function" then
				totalMult = totalMult * addDamage(_, player, IsBaseStats)
			else
				totalMult = totalMult * addDamage
			end
		end
	end

	for trinketID, trinketMult in pairs(MultiplierManager.TrinketMult) do
		local addDamage = trinketMult.Damage
		if (player:HasTrinket(trinketID) or player:GetEffects():HasTrinketEffect(trinketID)) and addDamage then
			if type(addDamage) == "function" then
				totalMult = totalMult * addDamage(_, player, IsBaseStats)
			else
				totalMult = totalMult * addDamage
			end
		end
	end
	
	for name, ConData in pairs(MultiplierManager.MultCondition.DAMAGE) do
		local condition = ConData.Condition
		local addDamage = ConData.Result
		if type(condition) == "function" then
			condition = condition(_, player, IsBaseStats)
		end
		if condition then
			if type(addDamage) == "function" then
				totalMult = totalMult * addDamage(_, player, IsBaseStats)
			else
				totalMult = totalMult * addDamage
			end
		end
	end


	return totalMult
end


---@param player		- EntityPlayer (usedata)
---@param IsBaseStats	- boolean - Default false
function MultiplierManager:GetTearsMultiplier(player, IsBaseStats)
	local IsBaseStats = IsBaseStats or false
	local totalMult = MultiplierManager:GetPlayerMultipliers(player:GetPlayerType()).Tears

	if type(totalMult) == "function" then totalMult = totalMult(_, player) end

	for itemID, itemMult in pairs(MultiplierManager.ItemMult) do
		local addTears = itemMult.Tears
		if (player:HasCollectible(itemID) or player:GetEffects():HasCollectibleEffect(itemID)) and addTears then
			if type(addTears) == "function" then
				totalMult = totalMult * addTears(_, player, IsBaseStats)
			else
				totalMult = totalMult * addTears
			end
		end
	end

	for trinketID, trinketMult in pairs(MultiplierManager.TrinketMult) do
		local addTears = trinketMult.Tears
		if (player:HasTrinket(trinketID) or player:GetEffects():HasTrinketEffect(trinketID)) and addTears then
			if type(addTears) == "function" then
				totalMult = totalMult * addTears(_, player, IsBaseStats)
			else
				totalMult = totalMult * addTears
			end
		end
	end

	for name, ConData in pairs(MultiplierManager.MultCondition.TEARS) do
		local condition = ConData.Condition
		local addTears = ConData.Result
		if type(condition) == "function" then
			condition = condition(_, player, IsBaseStats)
		end
		if condition then
			if type(addTears) == "function" then
				totalMult = totalMult * addTears(_, player, IsBaseStats)
			else
				totalMult = totalMult * addTears
			end
		end
	end


	return totalMult
end


---@param player		- EntityPlayer (usedata)
---@param IsBaseStats	- boolean - Default false
function MultiplierManager:GetSpeedMultiplier(player, IsBaseStats)
	local IsBaseStats = IsBaseStats or false
	local totalMult = MultiplierManager:GetPlayerMultipliers(player:GetPlayerType()).Speed

	if type(totalMult) == "function" then totalMult = totalMult(_, player) end

	for itemID, itemMult in pairs(MultiplierManager.ItemMult) do
		local addSpeed = itemMult.Speed
		if (player:HasCollectible(itemID) or player:GetEffects():HasCollectibleEffect(itemID)) and addSpeed then
			if type(addSpeed) == "function" then
				totalMult = totalMult * addSpeed(_, player, IsBaseStats)
			else
				totalMult = totalMult * addSpeed
			end
		end
	end

	for trinketID, trinketMult in pairs(MultiplierManager.TrinketMult) do
		local addSpeed = trinketMult.Speed
		if (player:HasTrinket(trinketID) or player:GetEffects():HasTrinketEffect(trinketID)) and addSpeed then
			if type(addSpeed) == "function" then
				totalMult = totalMult * addSpeed(_, player, IsBaseStats)
			else
				totalMult = totalMult * addSpeed
			end
		end
	end

	for name, ConData in pairs(MultiplierManager.MultCondition.SPEED) do
		local condition = ConData.Condition
		local addSpeed = ConData.Result
		if type(condition) == "function" then
			condition = condition(_, player, IsBaseStats)
		end
		if condition then
			if type(addSpeed) == "function" then
				totalMult = totalMult * addSpeed(_, player, IsBaseStats)
			else
				totalMult = totalMult * addSpeed
			end
		end
	end


	return totalMult
end


---@param player		- EntityPlayer (usedata)
---@param IsBaseStats	- boolean - Default false
function MultiplierManager:GetRangeMultiplier(player, IsBaseStats)
	local IsBaseStats = IsBaseStats or false
	local totalMult = MultiplierManager:GetPlayerMultipliers(player:GetPlayerType()).Range

	if type(totalMult) == "function" then totalMult = totalMult(_, player) end

	for itemID, itemMult in pairs(MultiplierManager.ItemMult) do
		local addRange = itemMult.Range
		if (player:HasCollectible(itemID) or player:GetEffects():HasCollectibleEffect(itemID)) and addRange then
			if type(addRange) == "function" then
				totalMult = totalMult * addRange(_, player, IsBaseStats)
			else
				totalMult = totalMult * addRange
			end
		end
	end

	for trinketID, trinketMult in pairs(MultiplierManager.TrinketMult) do
		local addRange = trinketMult.Range
		if (player:HasTrinket(trinketID) or player:GetEffects():HasTrinketEffect(trinketID)) and addRange then
			if type(addRange) == "function" then
				totalMult = totalMult * addRange(_, player, IsBaseStats)
			else
				totalMult = totalMult * addRange
			end
		end
	end

	for name, ConData in pairs(MultiplierManager.MultCondition.RANGE) do
		local condition = ConData.Condition
		local addRange = ConData.Result
		if type(condition) == "function" then
			condition = condition(_, player, IsBaseStats)
		end
		if condition then
			if type(addRange) == "function" then
				totalMult = totalMult * addRange(_, player, IsBaseStats)
			else
				totalMult = totalMult * addRange
			end
		end
	end


	return totalMult
end


---@param player		- EntityPlayer (usedata)
---@param IsBaseStats	- boolean - Default false
function MultiplierManager:GetShotSpeedMultiplier(player, IsBaseStats)
	local IsBaseStats = IsBaseStats or false
	local totalMult = MultiplierManager:GetPlayerMultipliers(player:GetPlayerType()).ShotSpeed

	if type(totalMult) == "function" then totalMult = totalMult(_, player) end

	for itemID, itemMult in pairs(MultiplierManager.ItemMult) do
		local addShotSpeed = itemMult.ShotSpeed
		if (player:HasCollectible(itemID) or player:GetEffects():HasCollectibleEffect(itemID)) and addShotSpeed then
			if type(addShotSpeed) == "function" then
				totalMult = totalMult * addShotSpeed(_, player, IsBaseStats)
			else
				totalMult = totalMult * addShotSpeed
			end
		end
	end

	for trinketID, trinketMult in pairs(MultiplierManager.TrinketMult) do
		local addShotSpeed = trinketMult.ShotSpeed
		if (player:HasTrinket(trinketID) or player:GetEffects():HasTrinketEffect(trinketID)) and addShotSpeed then
			if type(addShotSpeed) == "function" then
				totalMult = totalMult * addShotSpeed(_, player, IsBaseStats)
			else
				totalMult = totalMult * addShotSpeed
			end
		end
	end

	for name, ConData in pairs(MultiplierManager.MultCondition.SHOTSPEED) do
		local condition = ConData.Condition
		local addShotSpeed = ConData.Result
		if type(condition) == "function" then
			condition = condition(_, player, IsBaseStats)
		end
		if condition then
			if type(addShotSpeed) == "function" then
				totalMult = totalMult * addShotSpeed(_, player, IsBaseStats)
			else
				totalMult = totalMult * addShotSpeed
			end
		end
	end


	return totalMult
end


---@param player		- EntityPlayer (usedata)
---@param IsBaseStats	- boolean - Default false
function MultiplierManager:GetLuckMultiplier(player, IsBaseStats)
	local IsBaseStats = IsBaseStats or false
	local totalMult = MultiplierManager:GetPlayerMultipliers(player:GetPlayerType()).Luck

	if type(totalMult) == "function" then totalMult = totalMult(_, player) end

	for itemID, itemMult in pairs(MultiplierManager.ItemMult) do
		local addLuck = itemMult.Luck
		if (player:HasCollectible(itemID) or player:GetEffects():HasCollectibleEffect(itemID)) and addLuck then
			if type(addLuck) == "function" then
				totalMult = totalMult * addLuck(_, player, IsBaseStats)
			else
				totalMult = totalMult * addLuck
			end
		end
	end

	for trinketID, trinketMult in pairs(MultiplierManager.TrinketMult) do
		local addLuck = trinketMult.Luck
		if (player:HasTrinket(trinketID) or player:GetEffects():HasTrinketEffect(trinketID)) and addLuck then
			if type(addLuck) == "function" then
				totalMult = totalMult * addLuck(_, player, IsBaseStats)
			else
				totalMult = totalMult * addLuck
			end
		end
	end

	for name, ConData in pairs(MultiplierManager.MultCondition.LUCK) do
		local condition = ConData.Condition
		local addLuck = ConData.Result
		if type(condition) == "function" then
			condition = condition(_, player, IsBaseStats)
		end
		if condition then
			if type(addLuck) == "function" then
				totalMult = totalMult * addLuck(_, player, IsBaseStats)
			else
				totalMult = totalMult * addLuck
			end
		end
	end


	return totalMult
end


---@param AddStat		- float
---@param player		- EntityPlayer (usedata)
---@param MultType		- string
function MultiplierManager:ApplyMultipliers(AddStat, player, MultType)
	local AddStat = type(AddStat) == "number" and AddStat or 0
	local IsBaseStats = false

	if type(MultType) ~= "string" then
		ThrowError("Error MultiplierManager:ApplyMultipliers : Argument #3 isn't a string")
		return 0
	end
	local MultType, IsBaseStats = CheckString(MultType)

	if IsBaseStats > 0 then
		IsBaseStats = true
	end


	if MultType == "TEARS" then
		return AddStat * MultiplierManager:GetTearsMultiplier(player, IsBaseStats)
	elseif MultType == "DAMAGE" then
		return AddStat * MultiplierManager:GetDamageMultiplier(player, IsBaseStats)
	elseif MultType == "SPEED" then
		return AddStat * MultiplierManager:GetSpeedMultiplier(player, IsBaseStats)
	elseif MultType == "RANGE" then
		return AddStat * MultiplierManager:GetRangeMultiplier(player, IsBaseStats)
	elseif MultType == "SHOTSPEED" then
		return AddStat * MultiplierManager:GetShotSpeedMultiplier(player, IsBaseStats)
	elseif MultType == "LUCK" then
		return AddStat * MultiplierManager:GetLuckMultiplier(player, IsBaseStats)
	end

	ThrowError("Error MultiplierManager:ApplyMultipliers : Argument #3 is an unknown value")
	return 0
end
