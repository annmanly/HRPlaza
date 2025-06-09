-- This script is a server-side Lua module for Highrise Studio Worlds.
-- It leverages an EventProvider and the PrankModule to run a "prank" event:
-- fetching event data, tracking player streaks, awarding tickets, managing items, 
-- and interacting with a remote endpoint (TicketAPI) for state and leaderboard data.
-- The code uses a persistent storage system and handles various server requests from clients.

--!Type(Module)

-- These serialized fields can be exposed and changed in the Unity inspector.
-- testMode indicates if the server is running in a mock/test environment.
-- apiEndpoint is the backend URL for the event API.
-- The commented out block below lists different environment endpoints.

--!SerializeField
local testMode: boolean = false

--!SerializeField
local apiEndpoint: string = "http://hangout-private-lb-liveops-614010634fd20aaa.elb.us-east-1.amazonaws.com"

--[[
	dev          http://hangout-private-lb-dev-36e08553239a8871.elb.us-east-1.amazonaws.com        
	dev1         http://hangout-private-lb-dev1-1bb54090ed7eada7.elb.us-east-1.amazonaws.com            
	dev2         http://hangout-private-lb-dev2-4abf9e7323b16256.elb.us-east-1.amazonaws.com           
	dev3         http://hangout-private-lb-dev3-f4ea2dbbc802aa31.elb.us-east-1.amazonaws.com           
	liveops      http://hangout-private-lb-liveops-614010634fd20aaa.elb.us-east-1.amazonaws.com        
	production   http://hangout-private-lb-production-8aa74c0c4ba3cd65.elb.us-east-1.amazonaws.com     
	rc           http://hangout-private-lb-rc-07b69f9a56492336.elb.us-east-1.amazonaws.com  
--]]

-- Load the required modules:
-- PrankModule: Defines event-related structures, constants, and events.
-- TicketAPI: Provides a way to interact with the external event/ticket service.
-- PersistentKey defines the key under which we store player data.
local PrankModule = require("PrankModule")
local TicketAPI = require("TicketAPI")
local PersistentKey = "event_state"

local currentXPbyPlayerID = {}

-- Exit early if not running on the server, ensuring this script is server-only.
if not server then
	return
end

-- StoredState is the per-player stored data format (currently just the streak count).
export type StoredState = {
	streak: number,
}

-- StateModifiedResponse represents a server response when player state changes.
-- ranksAdvanced: How many ranks player moved up.
-- status: Updated user event status data after modification.
export type StateModifiedResponse = {
	ranksAdvanced: number,
	status: PrankModule.TicketEventUserStatusData,
}

-- EventProvider defines an interface for querying and modifying player event state.
-- It provides methods to:
--  - Get a player's status
--  - Modify the player's ticket/energy state
--  - Get leaderboard entries
export type EventProvider = {
	GetStatusForPlayer: (
		player: Player,
		event_id: string,
		cb: (response: PrankModule.TicketEventUserStatusData | nil, err: any) -> ()
	) -> (),
	ModifyPlayer: (
		player: Player,
		energyLost: number,
		luckyTokensWon: number,
		ticketsGained: number,
		expGained: number,
		itemToUse: string | nil,
		rewards: TicketAPI.specialRewards | nil,
		tiersToClaim: {number} | nil,
		cb: (response: StateModifiedResponse | nil, err: any) -> ()
	) -> (),
	GetLeaderBoard: (
		player: Player,
		event_id: string,
		offset: number,
		limit: number,
		category: string | nil,
		cb: (response: PrankModule.LeaderBoardEntries | nil, err: any) -> ()
	) -> (),
}

-- The Prank type orchestrates the prank event logic:
--  - Initializing event data
--  - Querying and modifying player states
--  - Awarding tickets based on actions and streaks
--  - Handling energy, item usage, and leaderboards
export type Prank = {
	New: (provider: EventProvider) -> Prank,
	provider: EventProvider,
	streakBoost: number,
	streakBoostMin: number,
	eventData: PrankModule.Event,
	pendingRequests: { [number]: any },
	playerStates: {
		[string]: {
			streak: number,
		},
	},
	Initialize: (cb: (data: PrankModule.Event | nil, err: string | nil) -> ()) -> (),
	CalculateTicketReward: (
		self: Prank,
		state: PrankModule.UserPrankState,
		actionStack: number,
		itemId: string | nil,
		collectible_level: number | nil,
		taps: number,
		player: Player
	) -> number,
	CalculateTicketBoost: (self: Prank, _eventStatus: PrankModule.TicketEventUserStatusData) -> number,
	TryPrank: (
		self: Prank,
		player: Player,
		collectible_level: number | nil,
		actionStack: number,
		taps: number,
		cb: (data: PrankModule.PrankResponseData | nil, err: string | nil) -> ()
	) -> (),
	OnSuccessfulPrank: (
		self: Prank,
		player: Player,
		state: PrankModule.UserPrankState,
		actionStack: number,
		usedItemId: string | nil,
		collectible_level: number | nil,
		taps: number,
		cb: (data: PrankModule.PrankResponseData | nil, err: string | nil) -> ()
	) -> (),
	QueryStateForPlayer: (
		self: Prank,
		player: Player,
		cb: (state: PrankModule.UserPrankStateData | nil, err: string | nil) -> ()
	) -> (),
	StoreStateForPlayer: (
		self: Prank,
		player: Player,
		state: StoredState,
		cb: (err: string | nil) -> ()
	) -> (),
	QueryLeaderBoard: (
		self: Prank,
		offset: number,
		limit: number,
		category: string | nil,
		cb: (response: PrankModule.LeaderBoardEntries | nil, err: string | nil) -> ()
	) -> (),
}

-- convertParticipationTiersToTable converts raw participation tier data into a structured Lua table format.
-- This provides a consistent table of tiers and associated rewards.
function convertParticipationTiersToTable(participation_tiers): { PrankModule.ParticipationTier }
	local result: { PrankModule.ParticipationTier } = {}

	for _, tier in pairs(participation_tiers) do
		local tier_table: PrankModule.ParticipationTier = {
			_id = tier._id,
			min = tier.min,
			max = tier.max,
			rewards = {},
			rewards_claimed = tier.rewards_claimed,
		}

		if tier.rewards then
			for _, reward in pairs(tier.rewards) do
				local reward_table: PrankModule.ParticipationTierReward = {
					_id = reward._id,
					category = reward.category,
					amount = reward.amount,
					item_id = reward.item_id,
					account_bound = reward.account_bound,
					disp_name = reward.disp_name,
					rarity = reward.rarity,
				}
				table.insert(tier_table.rewards, reward_table)
			end
		end

		table.insert(result, tier_table)
	end

	return result
end

Prank = {} :: Prank
Prank.__index = Prank

-- Prank.New creates a new Prank instance with a given EventProvider.
function Prank.New(provider: EventProvider): Prank
	local self = {
		provider = provider,
		streakBoost = 0,
		streakBoostMin = 0,
		playerStates = {},
		pendingRequests = {},
	} :: Prank
	setmetatable(self, Prank)
	return self
end

-- CalculateTicketReward determines how many tickets a player earns from a successful prank.
-- It uses performance scores, random gems, and item boosts to finalize the ticket count.
function Prank:CalculateTicketReward(state: PrankModule.UserPrankState, actionStack: number, itemId: string | nil, collectible_level : number | nil, taps: number, player: Player): number
	
	local levelBases = {10, 20, 50, 200}
	local baseTickets = levelBases[collectible_level] or 10

	if taps > 0 then
		baseTickets = (50 + (math.floor(taps / 2)))*5
	end

	return math.ceil(baseTickets)
end

function PreCalcTicketsForDispaly(place)
	local baseTickets = 10

	-- wegiht the base tickets based on the place for 20 places, first place most valuable, 20th place least valuable
	local placevalues = {10, 8, 6, 5, 4, 3, 2, 1.5, 1.2, 1.1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
	baseTickets = baseTickets * placevalues[place] or 1

	return math.ceil(baseTickets)
end

-- CalculateTicketBoost returns a multiplier for ticket earnings based on event status and item boosts.
function Prank:CalculateTicketBoost(_eventStatus: PrankModule.TicketEventUserStatusData): number
	local itemBoost = _eventStatus.boostItems
	return 1 + itemBoost
end

-- TryClaimTiers attempts to perform a modifyPlayer to claim qualified tiers.
function Prank:TryClaimTiers(player: Player)
	self:QueryStateForPlayer(player, function(data: PrankModule.UserPrankStateData, err: string | nil)
		if err ~= nil then
			print("Error querying state for player: " .. err .. " for player: " .. player.name)
			return
		end

		if data.eventStatus.participation_tiers == nil then
			print("data.eventStatus.participation_tiers is nil")
			return
		end

		-- Find tiers the player is eligible to claim.
		local funded_tiers = {}
		local playerExp = data.eventStatus.exp
		for _, tier in ipairs(data.eventStatus.participation_tiers) do
			if playerExp >= tier.min then
				--print("Player " .. player.name .. " is eligible to claim tier: " .. tier.min)
				--print("Player has already claimed this " .. tostring(tier.rewards_claimed))
				if tier.rewards_claimed == false then
					table.insert(funded_tiers, tier.min)
					--print("Player " .. player.name .. " will attempt to claim " .. tier.min)
				end
			end
		end

		if #funded_tiers == 0 then
			print("Player " .. player.name .. " has no tiers to claim")
			return
		end

		local state: PrankModule.UserPrankState = PrankModule.UserPrankState.New(data)
		self.provider:ModifyPlayer(
		player,
		0,
		0,
		0,
		0,
		nil,
		{},
		self.eventData.id,
		funded_tiers, --- tiersToClaim
		function(response: StateModifiedResponse, err: string | nil)
			if err ~= nil then
				print("Error modifying player: " .. err .. " for player: " .. player.name)
				return
			end
			if #funded_tiers > 0 then PrankModule.EVENTS.ClaimedTiersEvent:FireClient(player) end
		end
		)
		
	end)
end 

-- OnSuccessfulPrank is called after a successful prank action. It awards tickets, consumes items/energy, and updates player state.
function Prank:OnSuccessfulPrank(
	player: Player,
	state: PrankModule.UserPrankState,
	actionStack: number,
	itemId: string | nil,
	collectible_level: number | nil,
	taps: number,
	cb: (data: PrankModule.PrankResponseData | nil, err: string | nil) -> ()
): ()
	local luckyTokensWon = 0
	local ticketsAwarded = self:CalculateTicketReward(state, actionStack, itemId, collectible_level, taps, player)
	local energyLost = actionStack
	
	local tiersToClaim = {}

	local specialRewards : TicketAPI.specialRewards = {}

	local expGained = ticketsAwarded

	print("XP awarded: " .. expGained)


	self.provider:ModifyPlayer(
		player,
		energyLost,
		luckyTokensWon,
		ticketsAwarded,
		expGained,
		itemId,
		specialRewards,
		self.eventData.id,
		tiersToClaim,
		function(response: StateModifiedResponse, err: string | nil)
			if err ~= nil then
				return cb(nil, err)
			end
			self:StoreStateForPlayer(player, state, function(err: string | nil)
				if err ~= nil then
					return cb(nil, err)
				end

				return cb({
					wasSuccessful = true,
					ranksAdvanced = response.ranksAdvanced,
					ticketsGained = ticketsAwarded,
					specialRewards = specialRewards,
					state = PrankModule.UserPrankState
						.New({
							streak = state.streak,
							eventStatus = response.status,
							ticketRewardBase = ticketsAwarded,
							ticketRewardTotal = ticketsAwarded,
							ticketBoost = self:CalculateTicketBoost(response.status),
						})
						:Serialize(),
				}, nil)
			end)

			currentXPbyPlayerID[player.user.id] = response.status.exp
			self:TryClaimTiers(player)
		end
	)
end

-- TryPrank attempts to perform a prank action. It verifies energy, items, and then executes the success logic.
function Prank:TryPrank(
	player: Player,
	collectible_level: number,
	actionStack: number,
	taps: number,
	cb: (data: PrankModule.PrankResponseData | nil, err: string) -> ()
): ()
	--print("Trying prank")
	self:QueryStateForPlayer(player, function(data: PrankModule.UserPrankStateData, err: string | nil)
		if err ~= nil then
			return cb(nil, err)
		end

		local state: PrankModule.UserPrankState = PrankModule.UserPrankState.New(data)

		if state.eventStatus.energyAmount < actionStack then
			return cb(nil, PrankModule.ERR_NOT_ENOUGH_ENERGY)
		end

		-- For this implementation, all pranks are considered successful attempts.
		return self:OnSuccessfulPrank(player, state, actionStack, itemId, collectible_level, taps, cb)
	end)
end

-- QueryStateForPlayer retrieves a player's current event state from storage or memory 
-- and then fetches the latest ticket event user status from the provider.
function Prank:QueryStateForPlayer(
	player: Player,
	cb: (state: PrankModule.UserPrankStateData | nil, err: string | nil) -> ()
)
	local stateQuery = function(state: StoredState)
		--print("Querying state for player: " .. player.name,  self.eventData.id)
		self.provider:GetStatusForPlayer(player, self.eventData.id, function(response: PrankModule.TicketEventUserStatusData | nil, err)
			if err ~= nil then
				return cb(nil, err)
			end
			currentXPbyPlayerID[player.user.id] = response.exp
			cb(
				PrankModule.UserPrankState.New({
					streak = state.streak,
					eventStatus = response,
					ticketBoost = self:CalculateTicketBoost(response),
				}),
				nil
			)
		end)
	end

	local cachedState = self.playerStates[player.user.id]
	if cachedState == nil then
		Storage.GetPlayerValue(player, PersistentKey, function(data: StoredState | nil)
			if data == nil then
				data = { streak = 0 }
			end
			self.playerStates[player.user.id] = data
			stateQuery(data)
		end)
		return
	end

	stateQuery(cachedState)
end

-- StoreStateForPlayer writes the player's updated streak state to persistent storage.
function Prank:StoreStateForPlayer(player: Player, state: StoredState, cb: (err: string | nil) -> ()): ()
	Storage.SetPlayerValue(player, PersistentKey, {
		streak = state.streak,
	}, function(errorCode)
		if errorCode ~= 0 then
			print("Something went wrong while storing player state: " .. tostring(errorCode))
			return cb(PrankModule.ERR_INTERNAL)
		end

		cb(nil)
	end)
end

-- QueryLeaderBoard asks the provider for leaderboard data for the current event.
function Prank:QueryLeaderBoard(
	player: Player,
	offset: number,
	limit: number,
	category: string | nil,
	cb: (response: PrankModule.LeaderBoardEntries | nil, err: string | nil) -> ()
): ()
	if not self.eventData then
		return cb(nil, PrankModule.ERR_EVENT_NOT_INITIALIZED)
	end

	self.provider:GetLeaderBoard(player, self.eventData.id, offset, limit, category, cb)
end

-- Initialize fetches initial event data from the provider and stores it in the prank instance.
function Prank:Initialize(cb: (data: PrankModule.Event | nil, err: string | nil) -> ()): ()
	self.provider:GetData(function(r: TicketAPI.EventData | nil, err: string | nil)
		if err ~= nil then
			print("Error fetching event data: " .. err)
			cb(nil, err)
			return
		end
		data = r :: TicketAPI.EventData
		print("Fetched Event Data for ID: " .. data._id)

		self.eventData = {
			id = data._id,
			isLive = data.is_live,
			participationTiers = convertParticipationTiersToTable(data.participation_tiers),
			userTiers = convertParticipationTiersToTable(data.user_tiers),
			crewTiers = convertParticipationTiersToTable(data.crew_tiers),
			leagueTiers = convertParticipationTiersToTable(data.league_tiers or {}),
			exp_gates = data.exp_gates,
			item_collection_id = data.item_collection_id,
			starts_at = data.starts_at,
			ends_at = data.ends_at,
		} :: PrankModule.Event

		cb(self.eventData, nil)
	end)
end

function Prank:CheckEventAgainstFuture(cb: (data: PrankModule.Event | nil, err: string | nil) -> ()): ()
	self.provider:GetFutureEvent(function(response)

		--print(response._id, tostring(response.starts_at))
		--print(self.eventData.id, tostring(response._id))

		-- Check if the future event exists and is not nil
		if response == nil or response._id == nil then
			return cb(nil, "No future event found")
		end

		print("Found future event: " .. response._id)

		-- Check if the event starts within 30 minutes
		local currentUnixTime = os.time()
		local timeUntilEvent = os.difftime(response.starts_at, currentUnixTime)
		local startsinThirtyMinutesOrLess = timeUntilEvent <= 1800
		if not startsinThirtyMinutesOrLess then
			return cb(nil, "New Event is more than 30 minutes away")
		end

		-- Check if the data is already fetched
		if response._id == self.eventData.id then
			return cb(nil, "New Event is already Fetched")
		end

		
		self.provider:GetEventDataFromID(response._id, function(r: TicketAPI.EventData | nil, err: string | nil)
			if err ~= nil then
				print("Error fetching event data: " .. err)
				return
			end
			data = r :: TicketAPI.EventData
			print("Fetched Event Data for ID: " .. data._id)

			self.eventData = {
				id = data._id,
				isLive = data.is_live,
				participationTiers = convertParticipationTiersToTable(data.participation_tiers),
				userTiers = convertParticipationTiersToTable(data.user_tiers),
				crewTiers = convertParticipationTiersToTable(data.crew_tiers),
				leagueTiers = convertParticipationTiersToTable(data.league_tiers or {}),
				exp_gates = data.exp_gates,
				item_collection_id = data.item_collection_id,
				starts_at = data.starts_at,
				ends_at = data.ends_at,
			} :: PrankModule.Event
			
			cb(self.eventData, nil)
		end)
	end)
end

-- MockEventProvider is used if testMode is true, providing a local, simulated EventProvider environment.
export type MockEventProvider = {
	states: { [string]: PrankModule.TicketEventUserStatusData },
	New: () -> MockEventProvider,
} & EventProvider

MockEventProvider = {} :: MockEventProvider
MockEventProvider.__index = MockEventProvider

-- MockEventProvider.New creates a mock provider with no saved states, returns default data when queried.
function MockEventProvider.New(): MockEventProvider
	local self = {
		states = {},
	} :: MockEventProvider
	setmetatable(self, MockEventProvider)
	return self
end

-- NewState returns a default, large-energy state for testing.
function MockEventProvider:NewState()
	return {
		boostLuckyTokens = 0,
		boostItems = 0,
		boostSuper = 0,
		ticketsTotal = 0,
		rank = 0,
		luckyTokens = 0,
		energyAmount = 100,
		energyNextIncrementIn = 240,
		energyMax = 50,
		energyPerSecondIncrease = 240,
		eventInventory = {
			{
				id = PrankModule.GUARANTEED_ITEM_ID,
				ownedAmount = 0,
				text = "Plain Purse",
				subText = "Guaranteed success!",
				imageUrl = "https://cdn.highrisegame.com/images/collectibles/box.webp",
			},
			{
				id = PrankModule.GUARANTEED_ITEM_AND_DOUBLE_TICKETS_ID,
				ownedAmount = 5,
				text = "Extravagant Purse",
				subText = "Guaranteed success, plus 2x tickets!",
				imageUrl = "https://cdn.highrisegame.com/images/collectibles/box_super.webp",
			},
			{
				id = PrankModule.ENERGY_REFILL_SMALL,
				ownedAmount = 5,
				text = "7 Energy",
				subText = "Refill 7 energy",
				imageUrl = "nil",
			},
			{
				id = PrankModule.ENERGY_REFILL_MAX,
				ownedAmount = 5,
				text = "Max Energy",
				subText = "Refill all energy",
				imageUrl = "nil",
			},
			{
				id = PrankModule.STAGE_BONUS_TIME_1,
				ownedAmount = 5,
				text = "30% Bonus",
				subText = "description",
				imageUrl = "nil",
			},
			{
				id = PrankModule.STAGE_BONUS_TIME_2,
				ownedAmount = 5,
				text = "60% Bonus",
				subText = "description",
				imageUrl = "nil",
			},
		},
		exp = 0,
	} :: PrankModule.TicketEventUserStatusData
end

-- GetStatusForPlayer retrieves or creates a mock player state.
function MockEventProvider:GetStatusForPlayer(
	player: Player,
	event_id: string,
	cb: (response: PrankModule.TicketEventUserStatusData, err: any) -> ()
): ()
	local userId = player.user.id
	local data = self.states[userId]
	if data == nil then
		data = self:NewState()
		self.states[userId] = data
	end
	cb(data, nil)
end

-- Mock implementation of GetData just returns a fake event data structure.
function MockEventProvider:GetData(cb: (response: TicketAPI.EventData | nil, err: any) -> ()): ()
	local _mockEventData: TicketAPI.EventData = {
		_id = "randomID",
		is_live = true,
		participation_tiers = {},
		user_tiers = {},
		crew_tiers = {},
		exp_gates = {},
	}
	cb(_mockEventData, nil)
end

-- ModifyPlayer updates a mock player's ticket and energy based on the performed action.
function MockEventProvider:ModifyPlayer(
	player: Player,
	energyLost: number,
	luckyTokensWon: number,
	ticketsGained: number,
	expGained: number,
	itemToUse: string | nil,
	rewards: TicketAPI.specialRewards | nil,
	event_id: string,
	tiersToClaim: {number} | nil,
	cb: (response: StateModifiedResponse | nil, err: any) -> ()
): ()
	local userId = player.user.id
	local data = self.states[userId]
	data.ticketsTotal = math.max(0, data.ticketsTotal + ticketsGained)
	data.energyAmount = math.max(0, data.energyAmount - energyLost)
	data.rank = data.rank + 1
	data.luckyTokens = data.luckyTokens + luckyTokensWon
	data.exp = data.exp + 100

	if itemToUse == PrankModule.STAGE_BONUS_TIME_1 or itemToUse == PrankModule.STAGE_BONUS_TIME_2 then
		if itemToUse == PrankModule.STAGE_BONUS_TIME_1 then
			data.boostSuper = 0.6
		elseif itemToUse == PrankModule.STAGE_BONUS_TIME_2 then
			data.boostSuper = 0.3
		end
	end

	if itemToUse == PrankModule.ENERGY_REFILL_SMALL then
		data.energyAmount = data.energyAmount + 7
	end

	if itemToUse == PrankModule.ENERGY_REFILL_MAX then
		data.energyAmount = 55
	end

	if itemToUse ~= nil then
		for _, item in ipairs(data.eventInventory) do
			if item.id == itemToUse then
				item.ownedAmount = math.max(0, item.ownedAmount - 1)
				break
			end
		end
	end

	cb({
		status = data,
		ranksAdvanced = 1,
	}, nil)
end

local _prank: Prank
if testMode then
	_prank = Prank.New(MockEventProvider.New())
else
	_prank = Prank.New(TicketAPI.New(apiEndpoint))
end

local pendingBarContributionsPerPlayer = {}


local instance = nil

-- Instance returns the global _prank instance.
function Instance(): Prank
	return _prank
end

function RequestPrankHandler(player: Player, actionStack: number)

	--local userId = player.user.id
	--if instance.pendingRequests[userId] then
	--	PrankModule.EVENTS.PrankResponse:FireClient(player, nil, PrankModule.ERR_PENDING_REQUEST)
	--	return
	--end

	pendingBarContributionsPerPlayer[player.user.id] = 5

	--instance.pendingRequests[userId] = true
	instance:TryPrank(player, 1, actionStack, 0, function(data: PrankModule.PrankResponseData | nil, err: string | nil)
		--instance.pendingRequests[userId] = nil
		PrankModule.EVENTS.PrankResponse:FireClient(player, data, err)
	end)
end

function GiveItemsToPlayer(player: Player, items)

	final_rewards = {{item_id = "diamond_token", amount = 1}} or items

	instance.provider:ModifyPlayer(
	player,
	0,
	0,
	0,
	0,
	nil,
	final_rewards,
	instance.eventData.id,
	nil,
	function(response: StateModifiedResponse, err: string | nil)
		print("GiveItemsToPlayer called for player: " .. player.name)
		if err ~= nil then
			return print("Error giving item to player: " .. err .. " for player: " .. player.name, err)
		end
	end)
end

-- ServerAwake runs once when the script is loaded server-side.
-- It sets up event connections for incoming requests (e.g. RequestState, RequestPrank, etc.),
-- listens for player disconnections, and initializes event data.
function self:ServerAwake()
	instance = Instance()

	server.PlayerDisconnected:Connect(function(player)
		-- Clear player state on disconnect to free memory.
		instance[player.user.id] = nil
		pendingBarContributionsPerPlayer[player.user.id] = nil
		instance.playerStates[player.user.id] = nil
		currentXPbyPlayerID[player.user.id] = nil
	end)

	-- Handle client requests for their state.
	PrankModule.EVENTS.RequestState:Connect(function(player: Player)
		instance:QueryStateForPlayer(player, function(data: PrankModule.UserPrankStateData | nil, err: string | nil)
			PrankModule.EVENTS.StateResponse:FireClient(player, data, err)
		end)
	end)

	-- Handle a prank request from a client.
	PrankModule.EVENTS.RequestPrank:Connect(RequestPrankHandler)

	-- Handle leaderboard data requests.
	PrankModule.EVENTS.GetLeaderBoardRequest:Connect(function(player: Player, offset: number, limit: number, category)
		instance:QueryLeaderBoard(
			player,
			offset,
			limit,
			category,
			function(response: PrankModule.LeaderBoardEntries | nil, err: string | nil)
				PrankModule.EVENTS.GetLeaderBoardResponse:FireClient(player, response, err)
			end
		)
	end)

	-- Handle the Client Trying to cliam tiers
	PrankModule.EVENTS.TryClaimTiersRequest:Connect(function(player: Player)
		instance:TryClaimTiers(player)
	end)

	-- Initialize event data and notify all clients once ready.
	instance:Initialize(function(data: PrankModule.Event | nil, err: string | nil)
		if err ~= nil then
			print("Error fetching event data: " .. err)
			return
		end
		PrankModule.EVENTS.InitialEventData:FireAllClients(data)
	end)

	-- Cycle check for future Events 
	--Timer.Every(60, function()
	--	instance:CheckEventAgainstFuture(function(data: PrankModule.Event | nil, err: string | nil)
			if err ~= nil then
				print("Error fetching event data: " .. err)
				return
			end

			PrankModule.EVENTS.InitialEventData:FireAllClients(data)
	--	end)
	--end)

	-- When a player joins, if we have event data loaded, send it to them.
	scene.PlayerJoined:Connect(function(_, player)
		if instance.eventData ~= nil then
			PrankModule.EVENTS.InitialEventData:FireClient(player, instance.eventData)
			--print(player.name, #data.exp_gates)
		else
			Timer.After(1, function()
				if instance.eventData ~= nil then
					--instance:TryClaimTiers(player)
				end
			end)
		end
	end)
end
