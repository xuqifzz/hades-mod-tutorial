Import "DebugScripts.lua"

local Rng = { id = -1 }

function Rng:New(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Rng:Seed(s, id)
	local debugRngSeed = GetConfigOptionValue({ Name = "DebugRNGSeed" })
	if debugRngSeed ~= 0 then
		s = debugRngSeed
	end
	self.seed = s
	self.id = id or self.id
	self.id = randomseed(s, self.id)
end

function Rng:Random( a, b )
	if a and b then
		return randomint(a, b, self.id)
	elseif a then
		return randomint(1, a, self.id)
	else
		return random( self.id )
	end
end

function Rng:RandomGaussian()
	return randomgaussian( self.id )
end

-- NOTE: C# actually uses the Rng at index 0, starting at 1 happens to be convenient for lua
local Randoms = {
	[1] = Rng:New()
}
Randoms[1]:Seed( math.floor(GetTime({}) * 1000000), 1)

function GetGlobalRng()
	return Randoms[1]
end

function GetRngById( rngId )
	if rngId == nil then
		return GetGlobalRng()
	end
	DebugAssert({ Condition = rngId > 0 and rng <= #Randoms, Text = "rngId parameter to RandomInit was out-of-bounds. Value: "..rngId })
	return Randoms[rngId]
end

function RandomInit( rngId )
	-- Execution context:  OnPreThingCreation
	local seed = math.floor(GetTime({}) * 1000000)

	if rngId == nil then
		rngId = 1
	else
		DebugAssert({ Condition = rngId > 0, Text = "rngId parameter to RandomInit was out-of-bounds. Value: "..rngId })
	end

	if Randoms[rngId] == nil then
		Randoms[rngId] = Rng:New()
	end

	if NextSeeds ~= nil and NextSeeds[rngId] ~= nil then
		seed = NextSeeds[rngId]
	else
		-- Patch this into new saves.
		DebugPrint({ Text = "RandomInit() could not find a seed in the save file."})
		if NextSeeds == nil then
			NextSeeds = {}
		end
		NextSeeds[rngId] = seed
	end

	Randoms[rngId]:Seed(seed, rngId)
	DebugPrint({ Text = "RandomInit("..rngId..") with seed: "..Randoms[rngId].seed }) -- Display real seed used if DebugRNGSeed enabled

	return Randoms[rngId]
end

function RandomSynchronize( offset, rngId )
	-- Use this for determinism, without always having to restart the rng sequence to 0
	if rngId == nil then
		rngId = 1
	end
	if offset == nil then
		offset = 0
	end
	local rng = RandomInit( rngId )
	while offset > 0 do
		offset = offset - 1
		CoinFlip(rng)
	end
end

function RandomSetNextInitSeed( args )
	-- On the next map load, RandomInit will use the given seed.
	-- Pairs well with SaveCheckpoint({...})
	local rngId = 1
	local seed = RandomInt(-2147483647, 2147483646)

	if args ~= nil then
		if args.Id ~= nil then
			rngId = args.Id
		end
		if args.Seed ~= nil then
			seed = args.Seed
		end
	end

	NextSeeds[rngId] = seed
end

function RandomSeed( seed )
	GetGlobalRng():Seed( seed )
end

function RandomInt( low, high, rng )

	local rng = rng or GetGlobalRng()
	local randomInt = rng:Random( low, high )
	return randomInt

end

function RandomFloat( low, high, rng )

	local rng = rng or GetGlobalRng()
	local randomFloat = low + ( rng:Random() * (high - low) )
	return randomFloat

end

function RandomNumber( number, rng )
	local rng = rng or GetGlobalRng()
	return rng:Random( number )
end

function RandomChance( chance, rng )
	local rng = rng or GetGlobalRng()
	return rng:Random() <= chance
end

function DebugRandomChance( chance, rng )
	local rng = rng or GetGlobalRng()
	local val = rng:Random()
	DebugPrint({ Text = "RandomChance returned "..val })
	return val <= chance
end

function CoinFlip( rng )

	local rng = rng or GetGlobalRng()
	return rng:Random() > 0.5

end

function RandomNormal( mean, stddev, rng )

	local rng = rng or GetGlobalRng()
	return mean + rng:RandomGaussian() * stddev;

end