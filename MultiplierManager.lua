MultiplierManager = MultiplierManager or {}

if MultiplierManager and MultiplierManager.Loaded then return end

MultiplierManager.PlayerMult = {
	--[PlayerType.PLAYER_ISAAC] = 1,
	--[PlayerType.PLAYER_MAGDALENE] = 1,
	[PlayerType.PLAYER_CAIN] 			= {Damage = 1.2},
	[PlayerType.PLAYER_JUDAS] 			= {Damage = 1.35},
	[PlayerType.PLAYER_BLUEBABY] 		= {Damage = 1.05},
	[PlayerType.PLAYER_EVE] 			= {Damage = function (_, player)
									      if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON) then return 1 end
									      return 0.75
									    end},
	--[PlayerType.PLAYER_SAMSON],
	[PlayerType.PLAYER_AZAZEL] 			= {Damage = 1.5, Tears = 0.267},
	--[PlayerType.PLAYER_LAZARUS],
	--[PlayerType.PLAYER_EDEN],
	--[PlayerType.PLAYER_THELOST],
	[PlayerType.PLAYER_LAZARUS2] 		= {Damage = 1.4},
	[PlayerType.PLAYER_BLACKJUDAS] 		= {Damage = 2},
	--[PlayerType.PLAYER_LILITH],
	[PlayerType.PLAYER_KEEPER]			= {Damage = 1.2},
	--[PlayerType.PLAYER_APOLLYON],
	[PlayerType.PLAYER_THEFORGOTTEN] 	= {Damage = 1.5, Tears = 0.5},
	--[PlayerType.PLAYER_THESOUL],
	--[PlayerType.PLAYER_BETHANY],
	--[PlayerType.PLAYER_JACOB],
	--[PlayerType.PLAYER_ESAU],

	--[PlayerType.PLAYER_ISAAC_B],
	[PlayerType.PLAYER_MAGDALENE_B] 	= {Damage = 0.75},
	[PlayerType.PLAYER_CAIN_B]			= {Damage = 1.2},
	--[PlayerType.PLAYER_JUDAS_B],
	--[PlayerType.PLAYER_BLUEBABY_B],
	[PlayerType.PLAYER_EVE_B]			= {Damage = 1.2, Tears = 0.66},
	--[PlayerType.PLAYER_SAMSON_B],
	[PlayerType.PLAYER_AZAZEL_B] 		= {Damage = 1.5, Tears = 0.33},
	--[PlayerType.PLAYER_LAZARUS_B],
	--[PlayerType.PLAYER_EDEN_B],
	[PlayerType.PLAYER_THELOST_B] 		= {Damage = 1.3},
	--[PlayerType.PLAYER_LILITH_B],
	--[PlayerType.PLAYER_KEEPER_B],
	--[PlayerType.PLAYER_APOLLYON_B],
	[PlayerType.PLAYER_THEFORGOTTEN_B]	= {Damage = 1.5, Tears = 0.5},
	--[PlayerType.PLAYER_BETHANY_B],
	--[PlayerType.PLAYER_JACOB_B],
	[PlayerType.PLAYER_LAZARUS2_B] 		= {Damage = 1.5},
	--[PlayerType.PLAYER_JACOB2_B],
	--[PlayerType.PLAYER_THESOUL_B],
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


local function CrackedCrownMult(_, player, baseStats)
	if baseStats then return 1 end
	return MultiplierManager:GetCrackedCrownMultiplier(player)
end

MultiplierManager.TrinketMult = {
	[TrinketType.TRINKET_CRACKED_CROWN] = {
		Damage = MultiplierManager.GetCrackedCrownMultiplier,
		Tears = MultiplierManager.GetCrackedCrownMultiplier,
		Speed = MultiplierManager.GetCrackedCrownMultiplier,
		Range = MultiplierManager.GetCrackedCrownMultiplier,
		ShotSpeed = MultiplierManager.GetCrackedCrownMultiplier
	}
}


--[[
mult = {
	Damage = function / float,
	Tears = function / float,
	Speed = function / float,
	ShotSpeed = function / float,
	Range = function / float,
	Luck = function / float,
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
function MultiplierManager:GetCrackedCrownMultiplier(player)
	return 1 + (player:GetTrinketMultiplier(TrinketType.TRINKET_CRACKED_CROWN) * 0.2)
end




---@param player		- EntityPlayer (usedata)
---@param IsBaseStats	- boolean - Default false
function MultiplierManager:GetDamageMultiplier(player, IsBaseStats)
	local IsBaseStats = IsBaseStats or false
	local totalMult = MultiplierManager:GetPlayerMultipliers(player:GetPlayerType()).Damage

	if type(totalMult) == "function" then totalMult = totalMult(_, player) end

	for itemID, itemMult in pairs(MultiplierManager.ItemMult) do
		local addDamage = itemMult.Damage or 1
		if (player:HasCollectible(itemID) or player:GetEffects():HasCollectibleEffect(itemID)) and addDamage then
			if type(addDamage) == "function" then
				totalMult = totalMult * addDamage(_, player, IsBaseStats)
			else
				totalMult = totalMult * addDamage
			end
		end
	end

	for trinketID, trinketMult in pairs(MultiplierManager.TrinketMult) do
		local addDamage = trinketMult.Damage or 1
		if (player:HasTrinket(trinketID) or player:GetEffects():HasTrinketEffect(trinketID)) and addDamage then
			if type(addDamage) == "function" then
				totalMult = totalMult * addDamage(_, player, IsBaseStats)
			else
				totalMult = totalMult * addDamage
			end
		end
	end

	if REPENTOGON and REPENTOGON["Real"] then
		totalMult = totalMult * player:GetD8DamageModifier()
	end

	--- for star of bethlehem and hallowed ground
	for _, ent in pairs(Isaac.FindByType(1000, EffectVariant.HALLOWED_GROUND, -1, false, false)) do
		if ent.Position:DistanceSquared(player.Position) <= 6800 then
			local StartOfBethlehem = false
			-- star of bethlehem has a different damage multiplier and doesn't stack
			for _, ent in pairs(Isaac.FindByType(3, FamiliarVariant.STAR_OF_BETHLEHEM, -1, false, false)) do
				if ent.Position:DistanceSquared(player.Position) <= 6800 then
					StartOfBethlehem = true
					break
				end
			end
			if StartOfBethlehem then
				totalMult = totalMult * 1.8
			else
				totalMult = totalMult * 1.2
			end
			break
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
		local addTears = itemMult.Tears or 1
		if (player:HasCollectible(itemID) or player:GetEffects():HasCollectibleEffect(itemID)) and addTears then
			if type(addTears) == "function" then
				totalMult = totalMult * addTears(_, player, IsBaseStats)
			else
				totalMult = totalMult * addTears
			end
		end
	end

	for trinketID, trinketMult in pairs(MultiplierManager.TrinketMult) do
		local addTears = trinketMult.Tears or 1
		if (player:HasTrinket(trinketID) or player:GetEffects():HasTrinketEffect(trinketID)) and addTears then
			if type(addTears) == "function" then
				totalMult = totalMult * addTears(_, player, IsBaseStats)
			else
				totalMult = totalMult * addTears
			end
		end
	end

	if REPENTOGON and REPENTOGON["Real"] then
		totalMult = totalMult * player:GetD8FireDelayModifier()
	end

	--- for star of bethlehem and hallowed ground
	for _, ent in pairs(Isaac.FindByType(1000, EffectVariant.HALLOWED_GROUND, -1, false, false)) do
		if ent.Position:DistanceSquared(player.Position) <= 6800 then
			totalMult = totalMult * 2.5
			break
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
		local addSpeed = itemMult.Speed or 1
		if (player:HasCollectible(itemID) or player:GetEffects():HasCollectibleEffect(itemID)) and addSpeed then
			if type(addSpeed) == "function" then
				totalMult = totalMult * addSpeed(_, player, IsBaseStats)
			else
				totalMult = totalMult * addSpeed
			end
		end
	end

	for trinketID, trinketMult in pairs(MultiplierManager.TrinketMult) do
		local addSpeed = trinketMult.Speed or 1
		if (player:HasTrinket(trinketID) or player:GetEffects():HasTrinketEffect(trinketID)) and addSpeed then
			if type(addSpeed) == "function" then
				totalMult = totalMult * addSpeed(_, player, IsBaseStats)
			else
				totalMult = totalMult * addSpeed
			end
		end
	end

	if REPENTOGON and REPENTOGON["Real"] then
		totalMult = totalMult * player:GetD8SpeedModifier()
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
		local addRange = itemMult.Range or 1
		if (player:HasCollectible(itemID) or player:GetEffects():HasCollectibleEffect(itemID)) and addRange then
			if type(addRange) == "function" then
				totalMult = totalMult * addRange(_, player, IsBaseStats)
			else
				totalMult = totalMult * addRange
			end
		end
	end

	for trinketID, trinketMult in pairs(MultiplierManager.TrinketMult) do
		local addRange = trinketMult.Range or 1
		if (player:HasTrinket(trinketID) or player:GetEffects():HasTrinketEffect(trinketID)) and addRange then
			if type(addRange) == "function" then
				totalMult = totalMult * addRange(_, player, IsBaseStats)
			else
				totalMult = totalMult * addRange
			end
		end
	end

	if REPENTOGON and REPENTOGON["Real"] then
		totalMult = totalMult * player:GetD8RangeModifier()
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
		local addShotSpeed = itemMult.ShotSpeed or 1
		if (player:HasCollectible(itemID) or player:GetEffects():HasCollectibleEffect(itemID)) and addShotSpeed then
			if type(addShotSpeed) == "function" then
				totalMult = totalMult * addShotSpeed(_, player, IsBaseStats)
			else
				totalMult = totalMult * addShotSpeed
			end
		end
	end

	for trinketID, trinketMult in pairs(MultiplierManager.TrinketMult) do
		local addShotSpeed = trinketMult.ShotSpeed or 1
		if (player:HasTrinket(trinketID) or player:GetEffects():HasTrinketEffect(trinketID)) and addShotSpeed then
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
		local addLuck = itemMult.Luck or 1
		if (player:HasCollectible(itemID) or player:GetEffects():HasCollectibleEffect(itemID)) and addLuck then
			if type(addLuck) == "function" then
				totalMult = totalMult * addLuck(_, player, IsBaseStats)
			else
				totalMult = totalMult * addLuck
			end
		end
	end

	for trinketID, trinketMult in pairs(MultiplierManager.TrinketMult) do
		local addLuck = trinketMult.Luck or 1
		if (player:HasTrinket(trinketID) or player:GetEffects():HasTrinketEffect(trinketID)) and addLuck then
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
		print("Error MultiplierManager:ApplyMultipliers : Argument #3 isn't a string")
		return
	end
	local MultType, IsBaseStats = string.gsub(string.lower(MultType), "base", "")

	if IsBaseStats > 0 then
		IsBaseStats = true
	end


	if MultType == "tears" or MultType == "tear" then
		return AddStat * MultiplierManager:GetTearsMultiplier(player, IsBaseStats)
	elseif MultType == "damage" then
		return AddStat * MultiplierManager:GetDamageMultiplier(player, IsBaseStats)
	elseif MultType == "speed" or MultType == "movespeed" then
		return AddStat * MultiplierManager:GetSpeedMultiplier(player, IsBaseStats)
	elseif MultType == "range" or MultType == "tearrange" then
		return AddStat * MultiplierManager:GetRangeMultiplier(player, IsBaseStats)
	elseif MultType == "shotspeed" or MultType == "tearspeed" then
		return AddStat * MultiplierManager:GetShotSpeedMultiplier(player, IsBaseStats)
	elseif MultType == "luck" then
		return AddStat * MultiplierManager:GetLuckMultiplier(player, IsBaseStats)
	end

	print("Error MultiplierManager:ApplyMultipliers : Argument #3 is an unknown value")
	return 0
end


-- this for when it load in other mods doesn't load again
MultiplierManager.Loaded = true