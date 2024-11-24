local VERSION = 1


if MultiplierHandler and MultiplierHandler.Version ~= nil and MultiplierHandler.Version >= VERSION then return end

MultiplierHandler = MultiplierHandler or {}
MultiplierHandler.Version = VERSION
MultiplierHandler.CacheData = MultiplierHandler.CacheData or {}

if MultiplierHandler.Game == nil then MultiplierHandler.Game = Game() end
local game = MultiplierHandler.Game


local defaultStats = {
	DAMAGE = 3.5,
	TEARS = 2.73,
	SPEED = 1,
	RANGE = 6.5,
	SHOTSPEED = 1,
	LUCK = 0
}


MultiplierHandler.MultiplierGroupType = {
	GROUP_CRICKETSHEAD_DMG = 1, GROUP_MAGICMUSH_DMG = 1,
	GROUP_IPECAC_RANGE = 2, GROUP_CRICKETSBODY_RANGE = 2,
	GROUP_FORGOTTEN_TEARS = 3, GROUP_BERSERK_TEARS = 3
}

local MultGroupType = MultiplierHandler.MultiplierGroupType



local function HasItem(player, itemID)
	return player:HasCollectible(itemID)
end

local function HasItemEffect(player, itemID)
	return player:GetEffects():HasCollectibleEffect(itemID)
end

local function HasItemXNumber(player, itemID, min, max)
	local min = min or 0
	local max = max or 9999999999999
	if min > max then
		local tran = max
		max = min
		min = tran
	end
	local totalNum = player:GetCollectibleNum(itemID)

	return totalNum >= min and totalNum <= max
end

local function HasItemEffectXNumber(player, itemID, min, max)
	local min = min or 0
	local max = max or 9999999999999
	if min > max then
		local tran = max
		max = min
		min = tran
	end
	local totalNum = player:GetEffects():GetCollectibleNum(itemID)

	return totalNum >= min and totalNum <= max
end


local function HasTrinket(player, itemID)
	return player:HasTrinket(itemID)
end

local function HasTrinketEffect(player, itemID)
	return player:GetEffects():HasTrinketEffect(itemID)
end


local function HasNull(player, itemID)
	return player:GetEffects():HasNullEffect(itemID)
end


local function HasTrinketXNumber(player, itemID, min, max)
	local min = min or 0
	local max = max or 9999999999999
	if min > max then
		local tran = max
		max = min
		min = tran
	end
	local totalNum = player:GetTrinketNum(itemID)

	return totalNum >= min and totalNum <= max
end

local function HasTrinketEffectXNumber(player, itemID, min, max)
	local min = min or 0
	local max = max or 9999999999999
	if min > max then
		local tran = max
		max = min
		min = tran
	end
	local totalNum = player:GetEffects():GetTrinketNum(itemID)

	return totalNum >= min and totalNum <= max
end


local function IsPlayerType(player, pTypes)
	local checkTypes = checkTypes
	if type(checkTypes) ~= "table" then checkTypes = {checkTypes} end
	local pType = player:GetPlayerType()

	for _, cType in pairs(checkTypes) do
		if pType == cType then return true end
	end
	return false
end




local playerDmgMult = {
	[PlayerType.PLAYER_CAIN] = 1.2,
	[PlayerType.PLAYER_JUDAS] = 1.35,
	[PlayerType.PLAYER_BLUEBABY] = 1.05,
	[PlayerType.PLAYER_EVE] = function (player)
		if HasItemEffect(player, CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON) then return 1 end
		return 0.75
	end,
	[PlayerType.PLAYER_AZAZEL] = 1.5,
	[PlayerType.PLAYER_LAZARUS2] = 1.4,
	[PlayerType.PLAYER_BLACKJUDAS] = 2,
	[PlayerType.PLAYER_KEEPER] =  1.2,
	[PlayerType.PLAYER_THEFORGOTTEN] = 1.5,

	-- Tainted Characters
	[PlayerType.PLAYER_MAGDALENE_B] = 0.75,
	[PlayerType.PLAYER_CAIN_B] = 1.2,
	[PlayerType.PLAYER_EVE_B] = 1.2,
	[PlayerType.PLAYER_AZAZEL_B] = 1.5,
	[PlayerType.PLAYER_THELOST_B] = 1.3,
	[PlayerType.PLAYER_THEFORGOTTEN_B] = 1.5,
	[PlayerType.PLAYER_LAZARUS2_B] = 1.5,
}

local playerTearsMult = {
	[PlayerType.PLAYER_AZAZEL] = function(player)
		if HasItem(player, CollectibleType.COLLECTIBLE_BRIMSTONE) or
			HasItem(player, CollectibleType.COLLECTIBLE_SPIRIT_SWORD) or
			HasItem(player, CollectibleType.COLLECTIBLE_HAEMOLACRIA) or
			HasItem(player, CollectibleType.COLLECTIBLE_EPIC_FETUS) or
			HasItem(player, CollectibleType.COLLECTIBLE_MOMS_KNIFE) or
			HasItem(player, CollectibleType.COLLECTIBLE_DR_FETUS) or
			HasItem(player, CollectibleType.COLLECTIBLE_TECH_X) then return 1 end

		return 0.267
	end,
	[PlayerType.PLAYER_THEFORGOTTEN] = 0.5,

	-- Tainted Characters
	[PlayerType.PLAYER_EVE_B] = 0.66,
	[PlayerType.PLAYER_AZAZEL_B] = function(player)
		if HasItem(player, CollectibleType.COLLECTIBLE_BRIMSTONE) or
			HasItem(player, CollectibleType.COLLECTIBLE_SPIRIT_SWORD) or
			HasItem(player, CollectibleType.COLLECTIBLE_HAEMOLACRIA) or
			HasItem(player, CollectibleType.COLLECTIBLE_EPIC_FETUS) or
			HasItem(player, CollectibleType.COLLECTIBLE_MOMS_KNIFE) or
			HasItem(player, CollectibleType.COLLECTIBLE_DR_FETUS) then return 1 end

		return 1/3
	end,
	[PlayerType.PLAYER_THEFORGOTTEN_B] = 0.5,
}





local multGroup = {
	[MultGroupType.GROUP_CRICKETSHEAD_DMG] = function(player)
		return (HasItem(player, CollectibleType.COLLECTIBLE_BLOOD_OF_THE_MARTYR) and HasItemEffect(player, CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL)) or
			HasItem(player, CollectibleType.COLLECTIBLE_CRICKETS_HEAD) or HasItem(player, CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM)
	end,
	[MultGroupType.GROUP_IPECAC_RANGE] = function(player)
		return HasItem(player, CollectibleType.COLLECTIBLE_HAEMOLACRIA) or
			HasItem(player, CollectibleType.COLLECTIBLE_IPECAC) or
			HasItem(player, CollectibleType.COLLECTIBLE_CRICKETS_BODY)
	end,
	[MultGroupType.GROUP_FORGOTTEN_TEARS] = function(player)
		local pType = player:GetPlayerType()
		return HasItemEffect(player, CollectibleType.COLLECTIBLE_BERSERK) or IsPlayerType(player, {PlayerType.PLAYER_THEFORGOTTEN, PlayerType.PLAYER_THEFORGOTTEN_B})
	end
}



function MultiplierHandler:HasMultiplierGroup(player, multGroupType)
	local fun = multGroup[multGroupType]
	return fun and fun(player) or false
end


function MultiplierHandler:InHallowMultRange(player)
	local data = player:GetData()._MultiplierHandler_HallowMult_Cache or {}
	if game:GetFrameCount() % 2 == 0 then return (data.InHallowRange or false), (data.InStarBethRange or false) end -- is updated every even frame just to not tank to much the frames
	local hallow = false
	local starBeth = false


	for _, ent in pairs(Isaac.FindByType(3, 236)) do
		if ent.Position:Distance(player.Position) <= 68 then
			starBeth = true
			hallow = true
			break
		end
	end

	if not starBeth then
		for _, ent in pairs(Isaac.FindByType(3, 201, 6)) do
			if ent.Position:Distance(player.Position) <= 32.55 then
				hallow = true
				break
			end
		end

		if not hallow then
			local holyPoops = Isaac.FindByType(245, 16)
			local holyPoopPresent = #holyPoops > 0

			if holyPoopPresent then
				for _, ent in pairs(holyPoops) do
					if not ent:IsDead() and ent.Position:Distance(player.Position) <= 80 then
						hallow = true
						break
					end
				end

				for _, ent in pairs(Isaac.FindByType(1000, EffectVariant.CREEP_LIQUID_POOP)) do
					if ent:ToEffect().State & (1<<6) > 0 and ent.Position:Distance(player.Position) <= 20 then
						hallow = true
						break
					end
				end
			else

				local room = game:GetRoom()
				for gridIdx = 0, room:GetGridSize()-1 do
					local grid = room:GetGridEntity(gridIdx)
					if grid and grid:GetType() == 14 and grid:GetVariant() == 6 and grid.State < 1000 then
						if grid.Position:Distance(player.Position) <= 80 then
							hallow = true
							break
						end
					end
				end

			end
		end
	end

	player:GetData()._MultiplierHandler_HallowMult_Cache = {
		Frame = game:GetFrameCount(),
		InHallowRange = hallow,
		InStarBethRange = starBeth,
	}
end



function MultiplierHandler:GetPlayerTearCap(player)
	return MultiplierHandler:GetPlayerTearsMult(player) * defaultStats.TEARS
end



function MultiplierHandler:GetPlayerDamageMult(player)
	local pData = player:GetData()._MultiplierHandler_Cache or {}
	local data = pData.DAMAGE
	if data and data.Frame == game:GetFrameCount() then
		local mult = data.Mult

		if HasTrinket(player, TrinketType.TRINKET_CRACKED_CROWN) and player.Damage > defaultStats.DAMAGE then
			mult = mult * (1 + (player:GetTrinketMultiplier(TrinketType.TRINKET_CRACKED_CROWN) * 0.2))
		end

		if player:GetPlayerType() == PlayerType.PLAYER_BETHANY_B and player.Damage > defaultStats.DAMAGE then
			mult = mult *0.75
		end

		return mult
	end

	local pType = player:GetPlayerType()
	local mult = playerDmgMult[pType] or 1
	local InHallowRange, InStarBethRange = MultiplierHandler:InHallowMultRange(player)

	if type(mult) == "function" then mult = mult(player) end

	if MultiplierHandler:HasMultiplierGroup(player, MultGroupType.GROUP_CRICKETSHEAD_DMG) then
		mult = mult *1.5
	end

	if HasItem(player, CollectibleType.COLLECTIBLE_HAEMOLACRIA) then
		mult = mult * 1.5
	elseif HasItem(player, CollectibleType.COLLECTIBLE_BRIMSTONE) and not HasItem(player, CollectibleType.COLLECTIBLE_MOMS_KNIFE) then
		if HasItemXNumber(player, CollectibleType.COLLECTIBLE_BRIMSTONE, 2) then
			mult = mult * 1.2
		elseif HasItem(player, CollectibleType.COLLECTIBLE_TECHNOLOGY) then
			mult = mult * 1.5
		end
	end

	if HasItem(player, CollectibleType.COLLECTIBLE_ALMOND_MILK) then
		mult = mult * 0.33
	elseif HasItem(player, CollectibleType.COLLECTIBLE_SOY_MILK) then
		mult = mult * 0.2
	end


	if HasItem(player, CollectibleType.COLLECTIBLE_20_20) then
		mult = mult *0.8

	elseif HasItem(player, CollectibleType.COLLECTIBLE_POLYPHEMUS) and not ( 
			HasItem(player, CollectibleType.COLLECTIBLE_C_SECTION) or 
			HasItem(player, CollectibleType.COLLECTIBLE_MUTANT_SPIDER) or
			HasItem(player, CollectibleType.COLLECTIBLE_INNER_EYE) ) then
		mult = mult * 2
	end


	if HasItemEffect(player, CollectibleType.COLLECTIBLE_CROWN_OF_LIGHT) then mult = mult *2 end
	if HasItem(player, CollectibleType.COLLECTIBLE_ODD_MUSHROOM_THIN) then mult = mult *0.9 end
	if HasItem(player, CollectibleType.COLLECTIBLE_SACRED_HEART) then mult = mult *2.3 end
	if HasItem(player, CollectibleType.COLLECTIBLE_EVES_MASCARA) then mult = mult *2 end
	if HasItemEffect(player, CollectibleType.COLLECTIBLE_MEGA_MUSH) then mult = mult *4 end

	if HasItem(player, CollectibleType.COLLECTIBLE_IMMACULATE_HEART) or InHallowRange or InStarBethRange then
		mult = mult *1.2
	end
	if InStarBethRange then
		mult = mult *1.5
	end

	for _, e in pairs(Isaac.FindInRadius(player.Position, 85.75, EntityPartition.FAMILIAR)) do
		if e.Variant == FamiliarVariant.SUCCUBUS then mult = mult *1.5 end
	end


	if REPENTOGON then
		mult = mult * player:GetD8DamageModifier()
		if HasItem(player, CollectibleType.COLLECTIBLE_DEAD_EYE) and not HasItem(player, CollectibleType.COLLECTIBLE_TECH_X) then
			mult = mult * (1 + (player:GetDeadEyeCharge() * 0.25))
		end
	end


	if HasTrinket(player, TrinketType.TRINKET_CRACKED_CROWN) and player.Damage > defaultStats.DAMAGE then
		mult = mult * (1 + (player:GetTrinketMultiplier(TrinketType.TRINKET_CRACKED_CROWN) * 0.2))
	end


	if IsPlayerType(player, {PlayerType.PLAYER_JUDAS, PlayerType.PLAYER_BLACKJUDAS}) then
		if HasItem(CollectibleType.COLLECTIBLE_BIRTHRIGHT) and HasItem(CollectibleType.COLLECTIBLE_DAMOCLES_PASSIVE) then
			mult = mult * 1.4
		end

	elseif pType == PlayerType.PLAYER_BETHANY_B and player.Damage > defaultStats.DAMAGE then mult = mult *0.75

	elseif IsPlayerType(player, {PlayerType.PLAYER_AZAZEL, PlayerType.PLAYER_AZAZEL_B}) then
		if not HasItem(player, CollectibleType.COLLECTIBLE_BRIMSTONE) then
			if HasItem(player, CollectibleType.COLLECTIBLE_TECH_X) then mult = mult *0.35 end
			if HasItem(player, CollectibleType.COLLECTIBLE_LUDOVICO_TECHNIQUE) then mult = mult *0.5 end
			if HasItem(player, CollectibleType.COLLECTIBLE_TECHNOLOGY) then mult = mult * 1.5 end
		end

	end


	player:GetData()._MultiplierHandler_Cache.DAMAGE = {
		Frame = game:GetFrameCount(),
		Mult = mult
	}
	return mult
end


local epiphoraFrameMult = 1/270
function MultiplierHandler:GetPlayerTearsMult(player)
	local pData = player:GetData()._MultiplierHandler_Cache or {}
	local data = pData.TEARS
	if data and data.Frame == game:GetFrameCount() then
		local mult = data.Mult

		if HasTrinket(player, TrinketType.TRINKET_CRACKED_CROWN) and player.MaxFireDelay > mult * defaultStats.TEARS then
			mult = mult * (1 + (player:GetTrinketMultiplier(TrinketType.TRINKET_CRACKED_CROWN) * 0.2))
		end
		if player:GetPlayerType() == PlayerType.PLAYER_BETHANY_B and player.MaxFireDelay > mult * defaultStats.TEARS then
			mult = mult *0.75
		end

		return mult
	end

	local pType = player:GetPlayerType()
	local mult = playerTearsMult[pType] or 1
	
	if type(mult) == "function" then mult = mult(player) end

	if MultiplierHandler:HasMultiplierGroup(player, MultGroupType.GROUP_FORGOTTEN_TEARS) then
		mult = mult *0.5
	end

	local hasCSection = HasItem(player, CollectibleType.COLLECTIBLE_C_SECTION)
	local hasSpiritSword = HasItem(player, CollectibleType.COLLECTIBLE_SPIRIT_SWORD)
	local hasBrimstone = HasItem(player, CollectibleType.COLLECTIBLE_BRIMSTONE)
	local hasTechX = HasItem(player, CollectibleType.COLLECTIBLE_TECH_X)
	local hasTechnology = HasItem(player, CollectibleType.COLLECTIBLE_TECHNOLOGY)
	
	local hasLudo = HasItem(player, CollectibleType.COLLECTIBLE_LUDOVICO_TECHNIQUE)


	local hasHaemolacria = HasItem(player, CollectibleType.COLLECTIBLE_HAEMOLACRIA)


	if not (HasItem(player, CollectibleType.COLLECTIBLE_EPIC_FETUS) or
		HasItem(player, CollectibleType.COLLECTIBLE_MOMS_KNIFE)) or hasCSection or hasSpiritSword then

		local isAzazel = IsPlayerType(player, {PlayerType.PLAYER_AZAZEL, PlayerType.PLAYER_AZAZEL_B})
		local hasIpecac = HasItem(player, CollectibleType.COLLECTIBLE_IPECAC)

		if hasIpecac and not isAzazel then mult = mult *(1/3) end

		if not hasSpiritSword and not hasCSection then
			if hasHaemolacria and not hasLudo then mult = mult *0.5 end

			if hasBrimstone then
				if not hasTechX then mult = mult *(1/3) end

			elseif HasItem(player, CollectibleType.COLLECTIBLE_MONSTROS_LUNG) then
				if not (hasBrimstone or isAzazel or hasTechnology or hasLudo) then
					if hasTechX then
						mult = mult *(1/3.1)
					else
						mult = mult *(1/4.3)
					end
				end
			elseif HasItem(player, CollectibleType.COLLECTIBLE_DR_FETUS) then
				if not hasHaemolacria then mult = mult *0.4 end
			end

			if hasIpecac and hasHaemolacria and not hasLudo then mult = mult *1.79 end--the closes i got
		end
	end


	if HasItem(player, CollectibleType.COLLECTIBLE_ALMOND_MILK) then
		mult = mult *4
	elseif HasItem(player, CollectibleType.COLLECTIBLE_SOY_MILK) then
		mult = mult *5.5
	end
	
	if not HasItem(player, CollectibleType.COLLECTIBLE_20_20) then
		if HasItem(player, CollectibleType.COLLECTIBLE_MUTANT_SPIDER) or
			(HasItem(player, CollectibleType.COLLECTIBLE_POLYPHEMUS) and not hasCSection) then

			mult = mult *0.42
		elseif HasItem(player, CollectibleType.COLLECTIBLE_INNER_EYE) or HasNull(player, NullItemID.ID_REVERSE_HANGED_MAN) then
			mult = mult *0.51
		end
	end

	
	if HasItem(player, CollectibleType.COLLECTIBLE_TECHNOLOGY_2) then mult = mult *0.66 end
	if HasItem(player, CollectibleType.COLLECTIBLE_EVES_MASCARA) then mult = mult *0.66 end

	if HasNull(player, NullItemID.ID_REVERSE_CHARIOT) or HasNull(player, NullItemID.ID_REVERSE_CHARIOT_ALT) then mult = mult *4 end


	if REPENTOGON then
		mult = mult * player:GetD8FireDelayModifier()
		
		local charge = player:GetEpiphoraCharge()
		if REPENTACEPLUS then
			mult = mult * ( 1+ math.min(epiphoraFrameMult, 270) )
		else
		    if charge >= 270 then
		        mult = mult *2
		    elseif charge >= 180 then
		        mult = mult *1.66
		    elseif charge >= 90 then
		        mult = mult *1.33
		    end
		end
	elseif player:HasCollectible(CollectibleType.COLLECTIBLE_EPIPHORA) then
		if REPENTACEPLUS then
			mult = mult * ( 1+ math.min(epiphoraFrameMult, 270) )
		else
			local charge = (pData.Epiphora or {}).Timer or 0
		    if charge >= 270 then
		        mult = mult *2
		    elseif charge >= 180 then
		        mult = mult *1.66
		    elseif charge >= 90 then
		        mult = mult *1.33
		    end
		end
	end


	if HasTrinket(player, TrinketType.TRINKET_CRACKED_CROWN) and player.MaxFireDelay > mult * defaultStats.TEARS then
		mult = mult * (1 + (player:GetTrinketMultiplier(TrinketType.TRINKET_CRACKED_CROWN) * 0.2))
	end


	if pType == PlayerType.PLAYER_BETHANY_B and player.MaxFireDelay > mult * defaultStats.TEARS then mult = mult *0.75 end


	player:GetData()._MultiplierHandler_Cache.TEARS = {
		Frame = game:GetFrameCount(),
		Mult = mult
	}
	return mult
end



function MultiplierHandler:GetPlayerRangeMult(player)
	local pData = player:GetData()._MultiplierHandler_Cache or {}
	local data = pData.RANGE
	if data and data.Frame == game:GetFrameCount() then
		local mult = data.Mult

		if HasTrinket(player, TrinketType.TRINKET_CRACKED_CROWN) and player.TearRange > defaultStats.RANGE then
			mult = mult * (1 + (player:GetTrinketMultiplier(TrinketType.TRINKET_CRACKED_CROWN) * 0.2))
		end

		if player:GetPlayerType() == PlayerType.PLAYER_BETHANY_B and player.TearRange > defaultStats.RANGE then mult = mult *0.75
		end

		return mult
	end

	local pType = player:GetPlayerType()

	local mult = 1
	mult = mult * MultiplierHandler:HasMultiplierGroup(player, MultGroupType.GROUP_IPECAC_RANGE)

	if HasItem(player, CollectibleType.COLLECTIBLE_NUMBER_ONE) then mult = mult * 0.8 end
	if HasItem(player, CollectibleType.COLLECTIBLE_MY_REFLECTION) then mult = mult * 2 end

	if REPENTOGON then
		mult = mult * player:GetD8RangeModifier()
	end


	if HasTrinket(player, TrinketType.TRINKET_CRACKED_CROWN) and player.TearRange > defaultStats.RANGE then
		mult = mult * (1 + (player:GetTrinketMultiplier(TrinketType.TRINKET_CRACKED_CROWN) * 0.2))
	end

	if pType == PlayerType.PLAYER_BETHANY_B and player.TearRange > defaultStats.RANGE then mult = mult *0.75
	end


	player:GetData()._MultiplierHandler_Cache.RANGE = {
		Frame = game:GetFrameCount(),
		Mult = mult
	}
	return mult
end



function MultiplierHandler:GetPlayerShotSpeedMult(player)
	local pData = player:GetData()._MultiplierHandler_Cache or {}
	local data = pData.SHOTSPEED
	if data and data.Frame == game:GetFrameCount() then
		local mult = data.Mult

		if HasTrinket(player, TrinketType.TRINKET_CRACKED_CROWN) and player.ShotSpeed > defaultStats.SHOTSPEED then
			mult = mult * (1 + (player:GetTrinketMultiplier(TrinketType.TRINKET_CRACKED_CROWN) * 0.2))
		end

		if player:GetPlayerType() == PlayerType.PLAYER_BETHANY_B and player.ShotSpeed > defaultStats.SHOTSPEED then mult = mult *0.75
		end

		return mult
	end

	local pType = player:GetPlayerType()
	local mult = 1

	if HasItem(player, CollectibleType.COLLECTIBLE_IPECAC) then mult = mult * 0.2 end
	if HasItem(player, CollectibleType.COLLECTIBLE_MY_REFLECTION) then mult = mult * 1.6 end


	if HasTrinket(player, TrinketType.TRINKET_CRACKED_CROWN) and player.ShotSpeed > defaultStats.SHOTSPEED then
		mult = mult * (1 + (player:GetTrinketMultiplier(TrinketType.TRINKET_CRACKED_CROWN) * 0.2))
	end

	if pType == PlayerType.PLAYER_BETHANY_B and player.ShotSpeed > defaultStats.SHOTSPEED then mult = mult *0.75
	end

	player:GetData()._MultiplierHandler_Cache.SHOTSPEED = {
		Frame = game:GetFrameCount(),
		Mult = mult
	}
	return mult
end




function MultiplierHandler:GetPlayerSpeedMult(player)
	local pData = player:GetData()._MultiplierHandler_Cache or {}
	local data = pData.SPEED
	if data and data.Frame == game:GetFrameCount() then
		local mult = data.Mult

		if HasTrinket(player, TrinketType.TRINKET_CRACKED_CROWN) and player.MoveSpeed > defaultStats.SPEED then
			mult = mult * (1 + (player:GetTrinketMultiplier(TrinketType.TRINKET_CRACKED_CROWN) * 0.2))
		end

		if player:GetPlayerType() == PlayerType.PLAYER_BETHANY_B and player.MoveSpeed > defaultStats.SPEED then mult = mult *0.75
		end

		return mult
	end

	local pType = player:GetPlayerType()
	local mult = 1

	if REPENTOGON then
		mult = mult * player:GetD8SpeedModifier()
	end


	if HasTrinket(player, TrinketType.TRINKET_CRACKED_CROWN) and player.MoveSpeed > defaultStats.SPEED then
		mult = mult * (1 + (player:GetTrinketMultiplier(TrinketType.TRINKET_CRACKED_CROWN) * 0.2))
	end

	if pType == PlayerType.PLAYER_BETHANY_B and player.MoveSpeed > defaultStats.SPEED then mult = mult *0.75
	end

	player:GetData()._MultiplierHandler_Cache.SPEED = {
		Frame = game:GetFrameCount(),
		Mult = mult
	}
	return mult
end



function MultiplierHandler:AddEpiphoraNonRepentogon(mod)
	if REPENTOGON or MultiplierHandler.EpiphoraSet then return end
	
	mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, function(_, player)
		if not player:HasCollectible(CollectibleType.COLLECTIBLE_EPIPHORA) then return end
		local data = player:GetData()._MultiplierHandler_Cache.Epiphora or {}
		local fireDir = player:GetFireDirection()
		data.LastFireDir = data.LastFireDir or Direction.NO_DIRECTION

		if fireDir ~= Direction.NO_DIRECTION and (data.LastFireDir == Direction.NO_DIRECTION or fireDir == data.LastFireDir) then
			if data.Timer < 400 then data.Timer = (data.Timer or 0) +1 end
		else
			data.Timer = 0
		end
		data.LastFireDir = fireDir
		player:GetData()._MultiplierHandler_Cache.Epiphora = data
	end)


	MultiplierHandler.EpiphoraSet = true
end