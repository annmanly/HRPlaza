-- This script defines the PrankModule, which contains types, constants, events, and helper functions
-- related to the "prank" event system. It provides type definitions for various data structures, 
-- error constants, item and event state classes, and utility methods for serializing and describing
-- these states. The PrankModule script is primarily focused on supporting other modules by defining
-- common data structures, event interfaces, and utility functions.

--!Type(Module)

-- Define a table of events to handle client-server communication for various requests and responses
EVENTS = {
-- Request and response events for retrieving the player’s state
	RequestState = Event.new("req_sstate"),
	StateResponse = Event.new("state_res"),

-- Request and response events for performing a prank action
	RequestPrank = Event.new("req_prank"),
	PrankResponse = Event.new("prank_res"),

-- Request and response events for fetching leaderboard data
	GetLeaderBoardRequest = Event.new("get_leaderboard_req"),
	GetLeaderBoardResponse = Event.new("get_leaderboard_res"),

-- Event for distributing initial event data to clients
	InitialEventData = Event.new("event_data"),

	ClaimedTiersEvent = Event.new("claimed_tiers_event"),
	TryClaimTiersRequest = Event.new("try_claim_tiers_req"),

	BossDefeatedResponse = Event.new("boss_defeated_res"),

	BossDefeatedPreCalcEvent = Event.new("boss_defeated_pre_calc_event"),
} :: { [string]: Event }

-- Define error constants representing various failure states (e.g., internal error, not enough energy/items, etc.)
ERR_INTERNAL = "err_internal"
ERR_NOT_ENOUGH_ENERGY = "err_not_enough_energy"
ERR_NOT_ENOUGH_ITEMS = "err_not_enough_items"
ERR_PENDING_REQUEST = "err_pending_request"
ERR_TIMED_OUT = "err_timed_out"
ERR_BOOST_ALREADY_ACTIVE = "err_boost_already_active"
ERR_EVENT_NOT_INITIALIZED = "err_event_not_initialized"

ALREADYCOLLECTED = "already_collected"

-- Define constants for special item IDs used in pranks and energy refills
GUARANTEED_ITEM_ID = "stage_success_helper"
GUARANTEED_ITEM_AND_DOUBLE_TICKETS_ID = "stage_tickets_helper"

ENERGY_REFILL_SMALL = "energy_refill_small"
ENERGY_REFILL_MAX = "energy_refill_max"

STAGE_BONUS_TIME_1 = "stage_bonus_time_2"
STAGE_BONUS_TIME_2 = "stage_bonus_time_1"

-- Define type structures for various data representations used in the event system

-- TicketEventItemData represents the raw data for an event item
export type TicketEventItemData = {
	id: string,
	ownedAmount: number,
	text: string,
	subText: string,
	imageUrl: string,
}

-- TicketEventItem wraps a TicketEventItemData with additional methods for creating and serializing items
export type TicketEventItem = {
	New: (data: TicketEventItemData) -> TicketEventItem,
	Serialize: (self: TicketEventItem) -> TicketEventItemData,
} & TicketEventItemData

-- TicketEventUserStatusData represents the player's event-related status, including boosts, tickets, inventory, etc.
export type TicketEventUserStatusData = {
	boostLuckyTokens: number,
	boostItems: number,
	boostSuper: number,
	ticketsTotal: number,
	rank: number,
	energyNextIncrementIn: number,
	energyPerSecondIncrease: number,
	energyMax: number,
	eventInventory: { TicketEventItemData },
	luckyTokens: number,
	energyAmount: number,
	crewName: string | nil,
	crewTickets: number | nil,
	crewRank: number | nil,
	leagueTickets: number | nil,
	leagueRank: number,
	exp: number,
	participation_tiers: {},
}

-- TicketEventUserStatus encapsulates a player's status into an object with serialization support
export type TicketEventUserStatus = {
	New: (data: TicketEventUserStatusData) -> TicketEventUserStatus,
	Serialize: (self: TicketEventUserStatus) -> TicketEventUserStatusData,
} & TicketEventUserStatusData

-- UserPrankStateData represents the player's prank-specific state, including streaks and ticket rewards
export type UserPrankStateData = {
	ticketRewardBase: number,
	ticketRewardTotal: number,
	ticketBoost: number,
	streak: number,
	eventStatus: TicketEventUserStatusData,
}

-- UserPrankState wraps prank state data with methods to get items and serialize the state
export type UserPrankState = {
	New: (data: UserPrankStateData) -> UserPrankState,
	ticketRewardBase: number,
	ticketRewardTotal: number,
	ticketBoost: number,
	streak: number,
	eventStatus: TicketEventUserStatus,
	Serialize: (self: UserPrankState) -> UserPrankStateData,
	GetEventItem: (self: UserPrankState, itemId: string) -> TicketEventItem,
}

-- PrankResponseData is returned when a prank action completes, including whether it was successful and updated state
export type PrankResponseData = {
	ranksAdvanced: number,
	ticketsGained: number,
	wasSuccessful: boolean,
	state: UserPrankStateData,
	specialRewards: 
	{
		{
		item_id: string,
		amount: number,
		}
	}
}

-- PrankResponse is a wrapped version of PrankResponseData with an instantiated UserPrankState
export type PrankResponse = {
	ranksAdvanced: number,
	ticketsGained: number,
	wasSuccessful: boolean,
	state: UserPrankState,
	specialRewards: 
	{
		{
		item_id: string,
		amount: number,
		}
	}
}

-- ParticipationTierReward defines an individual reward within a participation tier
export type ParticipationTierReward = {
	_id: string,
	category: string,
	amount: number,
	item_id: string,
	account_bound: boolean,
	disp_name: string,
	rarity: string,
}

-- ParticipationTier defines a tier with min/max values and associated rewards
export type ParticipationTier = {
	_id: string,
	min: number,
	max: number | nil,
	rewards: { ParticipationTierReward },
	rewards_claimed: boolean,
}

-- Event represents the overall event configuration and tiers
export type Event = {
	id: string,
	isLive: boolean,
	participationTiers: { ParticipationTier },
	userTiers: { ParticipationTier },
	crewTiers: { ParticipationTier },
	leagueTiers: { ParticipationTier },
	exp_gates: {},
	item_collection_id: string,
}

-- LeaderBoardEntry and LeaderBoardEntries define leaderboard data structures
export type LeaderBoardEntry = {
	entityId: string,
	tickets: string,
	rank: number,
	entityName: string,
}
export type LeaderBoardEntries = {
	total: number,
	entries: { LeaderBoardEntry },
}


-- TabLines is a helper function used for formatting multiline strings in a more readable way
local function TabLines(str: string): string
	local lines = {}
	for line in str:gmatch("[^\n]+") do
		table.insert(lines, "\t" .. line)
	end

	return table.concat(lines, "\n")
end

-- CategoryToType maps a given category string to a standardized type name for items
function CategoryToType(category)
	category = string.lower(category)
	
	if category == "avatar_item" then
		return "Clothing"
	elseif category == "collectible" then
		return "Collectible"
	elseif category == "furniture" then
		return "Furniture"
	elseif category == "gacha_tokens" then
		return "Grab"
	elseif category == "gems" then
		return "Gold"
	elseif category == "lucky_tokens" then
		return "LuckyTokens"
	elseif category == "pops" then
		return "Bubbles"
	else
		return "Unknown"
	end
end

-- TicketEventItem class with constructor and serialization methods
TicketEventItem = {} :: TicketEventItem
TicketEventItem.__index = TicketEventItem
function TicketEventItem.New(data: TicketEventItemData): TicketEventItem
	local self = {
		id = data.id,
		ownedAmount = data.ownedAmount,
		text = data.text,
		subText = data.subText,
		imageUrl = data.imageUrl,
	} :: TicketEventItem
	setmetatable(self, TicketEventItem)
	return self
end

function TicketEventItem:__tostring(): string
	return string.format(
		"TicketEventItem(\n\tid: %s, \n\tamount: %d, \n\ttext: %s, \n\tsubText: %s, \n\timageUrl: %s\n)",
		self.id,
		self.ownedAmount,
		self.text,
		self.subText,
		self.imageUrl:sub(1, 12) .. "..."
	)
end

function TicketEventItem:Serialize(): TicketEventItemData
	return {
		id = self.id,
		ownedAmount = self.ownedAmount,
		text = self.text,
		subText = self.subText,
		imageUrl = self.imageUrl,
	}
end

-- TicketEventUserStatus class creates user status objects with inventory items
TicketEventUserStatus = {} :: TicketEventUserStatus
TicketEventUserStatus.__index = TicketEventUserStatus
function TicketEventUserStatus.New(data: TicketEventUserStatusData): TicketEventUserStatus
	local self = {
		boostLuckyTokens = data.boostLuckyTokens,
		boostItems = data.boostItems,
		boostSuper = data.boostSuper,
		ticketsTotal = data.ticketsTotal,
		rank = data.rank,
		energyNextIncrementIn = data.energyNextIncrementIn,
		energyPerSecondIncrease = data.energyPerSecondIncrease,
		energyMax = data.energyMax,
		eventInventory = {},
		luckyTokens = data.luckyTokens,
		energyAmount = data.energyAmount,
		crewName = data.crewName,
		crewTickets = data.crewTickets,
		crewRank = data.crewRank,
		leagueTickets = data.leagueTickets,
		leagueRank = data.leagueRank,
		exp = data.exp,
		participation_tiers = data.participation_tiers,
	} :: TicketEventUserStatus
	setmetatable(self, TicketEventUserStatus)

	-- Populate the eventInventory with TicketEventItem objects
	for _, itemData in ipairs(data.eventInventory) do
		table.insert(self.eventInventory, TicketEventItem.New(itemData))
	end

	return self
end

function TicketEventUserStatus:Serialize(): TicketEventUserStatusData
	local items: { TicketEventItemData } = {}
	for _, item in ipairs(self.eventInventory) do
		table.insert(items, item:Serialize())
	end

	return {
		boostLuckyTokens = self.boostLuckyTokens,
		boostItems = self.boostItems,
		boostSuper = self.boostSuper,
		ticketsTotal = self.ticketsTotal,
		rank = self.rank,
		energyNextIncrementIn = self.energyNextIncrementIn,
		energyPerSecondIncrease = self.energyPerSecondIncrease,
		energyMax = self.energyMax,
		eventInventory = items,
		luckyTokens = self.luckyTokens,
		energyAmount = self.energyAmount,
		crewName = self.crewName,
		crewTickets = self.crewTickets,
		crewRank = self.crewRank,
		leagueTickets = self.leagueTickets,
		leagueRank = self.leagueRank,
		exp = self.exp,
		participation_tiers = self.participation_tiers,
	}
end

function TicketEventUserStatus:__tostring(): string
	local items = {}
	for _, item in ipairs(self.eventInventory) do
		table.insert(items, TabLines(tostring(item)))
	end

	local itemStr = TabLines(table.concat(items, ", "))

	return string.format(
		"TicketEventUserStatus(\n\tboostLuckyTokens: %f, \n\tboostItems: %f, \n\tboostSuper: %f, \n\tticketsTotal: %d, \n\trank: %d, \n\tenergyNextIncrementIn: %d, \n\tenergyPerSecondIncrease: %d, \n\tenergyMax: %d, \n\tluckyTokens: %d, \n\tenergyAmount: %d, \n\teventInventory: [\n%s\n\t]\n)",
		self.boostLuckyTokens,
		self.boostItems,
		self.boostSuper,
		self.ticketsTotal,
		self.rank,
		self.energyNextIncrementIn,
		self.energyPerSecondIncrease,
		self.energyMax,
		self.luckyTokens,
		self.energyAmount,
		itemStr
	) .. "\ncrewName: " .. tostring(self.crewName) .. "\ncrewTickets: " .. tostring(self.crewTickets) .. "\ncrewRank: " .. tostring(self.crewRank)
end

-- UserPrankState represents the entire state of a player's prank activities
UserPrankState = {} :: UserPrankState
UserPrankState.__index = UserPrankState
function UserPrankState.New(data: UserPrankStateData): UserPrankState
	local self = {
		ticketRewardBase = data.ticketRewardBase,
		ticketRewardTotal = data.ticketRewardTotal,
		ticketBoost = data.ticketBoost,
		streak = data.streak,
		eventStatus = TicketEventUserStatus.New(data.eventStatus),
	} :: UserPrankState
	setmetatable(self, UserPrankState)
	return self
end

function UserPrankState:Serialize(): UserPrankStateData
	return {
		ticketRewardBase = self.ticketRewardBase,
		ticketRewardTotal = self.ticketRewardTotal,
		ticketBoost = self.ticketBoost,
		streak = self.streak,
		eventStatus = self.eventStatus:Serialize(),
	}
end

function UserPrankState:__tostring(): string
	return string.format(
		"UserPrankState(\n\tstreak: %d, \n\teventStatus: %s\n)",
		self.streak,
		TabLines(tostring(self.eventStatus))
	)
end

function UserPrankState:GetEventItem(itemId: string): TicketEventItem
	-- Retrieve a specific event item by ID from the user's event inventory
	for _, item in ipairs(self.eventStatus.eventInventory) do
		if item.id == itemId then
			return item
		end
	end

	error("Item not found")
end

-- PrankResponse represents a response to a prank action, including updated state and ticket gains
PrankResponse = {} :: PrankResponse
PrankResponse.__index = PrankResponse
function PrankResponse.New(data: PrankResponseData): PrankResponse
	local self = {
		ranksAdvanced = data.ranksAdvanced,
		ticketsGained = data.ticketsGained,
		wasSuccessful = data.wasSuccessful,
		specialRewards = data.specialRewards,
		state = UserPrankState.New(data.state),
	} :: PrankResponse
	setmetatable(self, PrankResponse)
	return self
end

function PrankResponse:__tostring(): string
	return string.format(
		"PrankResponse(\n\tranksAdvanced: %d, \n\tticketsGained: %d, \n\twasSuccessful: %s, \nstate: %s\n)",
		self.ranksAdvanced,
		self.ticketsGained,
		tostring(self.wasSuccessful),
		TabLines(tostring(self.state))
	)
end
