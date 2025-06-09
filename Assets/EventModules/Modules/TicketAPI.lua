-- This module, TicketAPI.lua, provides functions to interact with an external "tickets" event service.
-- It is intended to run on the server, sending HTTP requests to a remote endpoint (specified by baseURL).
-- The API retrieves event data, player status, leaderboards, and modifies player data (such as tickets, energy, and items).
-- In addition to defining data structures and export types, it uses asynchronous HTTP requests and JSON serialization.
-- RandomDelay is used here as a placeholder for simulating network latency or testing asynchronous calls.

--!Type(Module)

--!SerializeField
local WorldID: string = "673221da832dd03de843b8fc"

-- Define various data type exports for structured inputs and outputs used by the TicketAPI.
export type EventItemData = {
	id: string,
	ownedAmount: number,
	text: string,
	subText: string,
	imageUrl: string,
}

export type ParticipationTierRewardData = {
	_id: string,
	category: string,
	amount: number,
	item_id: string,
	account_bound: boolean,
	disp_name: string,
	rarity: string,
}

export type TierData = {
	_id: string,
	min: number,
	max: number | nil,
	rewards: { ParticipationTierRewardData },
	rewards_claimed: boolean,
}

export type EventData = {
	_id: string,
	is_live: boolean,
	participation_tiers: { TierData },
	user_tiers: { TierData },
	crew_tiers: { TierData },
	exp_gates: {},
}

export type EventUserStatusData = {
	boostLuckyTokens: number,
	boostItems: number,
	boostSuper: number,
	ticketsTotal: number,
	rank: number,
	energyNextIncrementIn: number,
	energyPerSecondIncrease: number,
	energyMax: number,
	eventInventory: { EventItemData },
	luckyTokens: number,
	energyAmount: number,
	exp: number,
	participation_tiers: { TierData },
}

export type StateModifiedResponse = {
	ranksAdvanced: number,
	status: EventUserStatusData,
}

export type LeaderBoardEntryData = {
	entityId: string,
	tickets: string,
	rank: string,
	entityName: string,
}

export type LeaderBoardEntiesData = {
	total: number,
	entries: { LeaderBoardEntryData },
}

export type specialReward = {
	item_id: string,
	amount: number,
}
export type specialRewards = {specialReward}

-- The TicketAPI type represents the interface to the ticket service:
-- - New: constructor to create a TicketAPI instance with a given baseURL.
-- - GetStatusForPlayer: Retrieves current event status for a specific player.
-- - ModifyPlayer: Adjusts a player's tickets, energy, and items on the remote service.
-- - GetData: Fetches global event data configuration.
-- - GetLeaderBoard: Retrieves leaderboard data for a given event.
type TicketAPI = {
	baseURL: string,
	New: (baseURL: string) -> TicketAPI,
	GetStatusForPlayer: (player: Player, event_id: string, cb: (response: EventUserStatusData | nil, err: any) -> ()) -> (),
	ModifyPlayer: (
		player: Player,
		energyLost: number,
		luckyTokensWon: number,
		ticketsGained: number,
		itemToUse: string | nil,
		rewards: specialRewards | nil,
		event_id: string,
		cb: (response: StateModifiedResponse | nil, err: any) -> ()
	) -> (),
}

-- If not running on server, return early. This ensures the module does not run client-side.
if not server then
	return
end

TicketAPI = {}
TicketAPI.__index = TicketAPI

-- New creates a new TicketAPI instance linked to a given baseURL.
function TicketAPI.New(baseURL: string): TicketAPI
	local self = {} :: TicketAPI
	setmetatable(self, TicketAPI)
	self.baseURL = baseURL
	return self
end

-- DecodeStatus converts the JSON response from the remote API into a structured EventUserStatusData table.
-- It pulls out various boosts, energy info, ticket totals, and crew/league information.
function TicketAPI:DecodeStatus(json: any): EventUserStatusData
	local res: EventUserStatusData = {
		boostLuckyTokens = json["boosts"]["lucky_tokens"],
		boostItems = json["boosts"]["items"],
		boostSuper = json["boosts"]["super_boost"],
		ticketsTotal = json["tickets"],
		rank = json["rank"],
		energyNextIncrementIn = json["event_wallet"]["energy"]["nextIncrementIn"],
		energyPerSecondIncrease = json["event_wallet"]["energy"]["secondsPerIncrease"],
		energyMax = json["event_wallet"]["energy"]["max"],
		luckyTokens = json["event_wallet"]["luckyTokens"],
		energyAmount = json["event_wallet"]["energy"]["amount"],
		participation_tiers = json["tiers"],

		-- Crew and league data may or may not exist. We conditionally extract their values if available.
		crewName = (json["crew_status"] and type(json["crew_status"]) == "table") and json["crew_status"]["name"] or nil,
		crewTickets = (json["crew_status"] and type(json["crew_status"]) == "table") and json["crew_status"]["tickets"] or 0,
		crewRank = (json["crew_status"] and type(json["crew_status"]) == "table") and json["crew_status"]["rank"] or 0,
		leagueTickets = (json["league_status"] and type(json["league_status"]) == "table") and json["league_status"]["tickets"] or 0,
		leagueRank = (json["league_status"] and type(json["league_status"]) == "table") and json["league_status"]["rank"] or 0,
		exp = (json["exp"] and type(json["exp"]) == "number") and json["exp"] or 0,
		exp_gates = (json["exp_gates"] and type(json["exp_gates"]) == "table") and json["exp_gates"] or {},

		eventInventory = {},
	}

	-- Convert each raw inventory item in the JSON into an EventItemData structure.
	for _, itemData in ipairs(json["event_inventory"]) do
		local item: EventItemData = {
			id = itemData["item_id"],
			ownedAmount = itemData["amount"],
			text = itemData["text"],
			subText = itemData["subtext"],
			imageUrl = itemData["image_url"],
		}

		table.insert(res.eventInventory, item)
	end

	return res
end

-- GetData fetches global event data such as participation tiers and user/crew tiers.
-- This info is used by the server to understand the event structure (like what rewards exist at certain tiers).
function TicketAPI:GetData(cb: (response: EventData | nil, err: any) -> ()): ()
	local req = HTTPRequest.new(self.baseURL .. "/realm/direct/tickets_event", HTTPMethod.GET)
	req:SetHeader("Content-Type", "application/json")
	req:SetHeader("x-world-id", WorldID) -- This is a sample world ID for testing.

	-- RandomDelay simulates delayed requests, or can be used for asynchronous flow testing.
	RandomDelay(function()
		HTTPClient.Request(req, function(res, err)
			if err == HTTPError.None then
				-- Parse the JSON body and return it through callback.
				--print(res:GetBody())
				--for k, v in pairs(res:GetJSONBody()) do
				--	print(k, v)
				--end
				
				cb(res:GetJSONBody(), nil)
			else
				-- If there's an error, pass it back.
				cb(nil, tostring(err))
			end
		end)
	end)
end

function TicketAPI:GetEventDataFromID(event_id : string, cb: (response: EventData | nil, err: any) -> ()): ()
	local req = HTTPRequest.new(self.baseURL .. "/realm/direct/tickets_event", HTTPMethod.GET)
	req:SetHeader("Content-Type", "application/json")
	req:SetHeader("x-world-id", WorldID) -- This is a sample world ID for testing.
	req:SetQueryParameter("event_id", event_id) -- Event ID to fetch status for.

	-- RandomDelay simulates delayed requests, or can be used for asynchronous flow testing.
	RandomDelay(function()
		HTTPClient.Request(req, function(res, err)
			if err == HTTPError.None then
				-- Parse the JSON body and return it through callback.
				--print(res:GetBody())
				--for k, v in pairs(res:GetJSONBody()) do
				--	print(k, v)
				--end
				
				cb(res:GetJSONBody(), nil)
			else
				-- If there's an error, pass it back.
				cb(nil, tostring(err))
			end
		end)
	end)
end

function TicketAPI:GetFutureEvent(cb: (response: EventData | nil, err: any) -> ()): ()
	local req = HTTPRequest.new(self.baseURL .. "/realm/direct/tickets_future_event", HTTPMethod.GET)
	req:SetHeader("Content-Type", "application/json")
	req:SetHeader("x-world-id", WorldID) -- This is a sample world ID for testing.

	-- RandomDelay simulates delayed requests, or can be used for asynchronous flow testing.
	RandomDelay(function()
		HTTPClient.Request(req, function(res, err)
			if err == HTTPError.None then
				-- Parse the JSON body and return it through callback.
				--print(res:GetBody())
				--print("Found Future Event:" , res:GetJSONBody()._id)
				cb(res:GetJSONBody(), nil)
			else
				-- If there's an error, pass it back.
				cb(nil, tostring(err))
			end
		end)
	end)
end

-- GetStatusForPlayer fetches the player's current event-related status.
-- This includes how many tickets they have, their boosts, energy, and ranks.
function TicketAPI:GetStatusForPlayer(player: Player, event_id : string, cb: (response: EventUserStatusData | nil, err: any) -> ()): ()
	local req = HTTPRequest.new(self.baseURL .. "/realm/direct/tickets_user_status", HTTPMethod.GET)
	req:SetHeader("Content-Type", "application/json") -- Set the content type to JSON.
	req:SetHeader("x-world-id", WorldID) -- Test world ID.
	req:SetQueryParameter("user_id", player.user.id) -- User ID to fetch status for.
	req:SetQueryParameter("event_id", event_id) -- Event ID to fetch status for.

	RandomDelay(function()
		HTTPClient.Request(req, function(res, err)
			if err == HTTPError.None then
				-- Decode the JSON response into a structured EventUserStatusData.
				local json = res:GetJSONBody()
				cb(self:DecodeStatus(json), nil)
				--for k, v in self:DecodeStatus(json) do 
				--	print(k, v)
				--end
			else
				cb(nil, tostring(err))
			end
		end)
	end)
end

-- GetLeaderBoard retrieves a subset of the leaderboard entries, based on offset and limit.
-- If a category (like "league") is specified, additional user info may be required.
function TicketAPI:GetLeaderBoard(
	player: Player,
	event_id: string,
	offset: number,
	limit: number,
	category: string | nil,
	cb: (response: LeaderBoardEntiesData | nil, err: any) -> ()
): ()
	local req = HTTPRequest.new(self.baseURL .. "/realm/direct/tickets_leaderboard", HTTPMethod.GET)
	req:SetHeader("Content-Type", "application/json")
	req:SetQueryParameter("event_id", event_id)
	req:SetHeader("x-world-id", WorldID)
	req:SetQueryParameter("offset", tostring(offset))
	req:SetQueryParameter("limit", tostring(limit))

	-- If fetching a league leaderboard, the user's ID is needed to determine their rank.
	if category == "league" then
		req:SetQueryParameter("user_id", player.user.id)
	end

	-- If a category is provided, append it to the request.
	if category then req:SetQueryParameter("category", category) end

	RandomDelay(function()
		HTTPClient.Request(req, function(res, err)
			if err == HTTPError.None then
				cb(res:GetJSONBody(), nil)
			else
				cb(nil, tostring(err))
			end
		end)
	end)
end

-- RandomDelay is a helper function that can simulate asynchronous delays.
-- Currently, it just calls the callback immediately, but it could be modified to introduce real delays.
function RandomDelay(cb: () -> ())
	-- local delay = math.random(100, 1000)
	-- Timer.After(delay / 1000, cb)

	cb()
end

-- ModifyPlayer updates the player's event-related data on the server.
-- This can include subtracting energy, adding tickets, awarding lucky tokens, or using an item.
-- The request body includes all changes, and the response updates the player’s state.
function TicketAPI:ModifyPlayer(
	player: Player,
	energyLost: number,
	luckyTokensWon: number,
	ticketsGained: number,
	expGained: number,
	itemToUse: string | nil,
	rewards: specialRewards | nil,
	event_id: string,
	tiersToClaim: {number} | nil,
	cb: (response: StateModifiedResponse | nil, err: any) -> ()
): ()
	local req = HTTPRequest.new(self.baseURL .. "/realm/direct/tickets_change_inventory", HTTPMethod.POST)
	req:SetHeader("Content-Type", "application/json")
	req:SetHeader("x-world-id", WorldID)

	-- Cost array indicates which items are consumed by this action (if any).
	local cost = {}
	if itemToUse ~= nil then
		table.insert(cost, {
			item_id = itemToUse,
			amount = 1,
		})
	end

	-- JSON request body includes user_id and changes to their inventory/values.
	req:SetJSONBody({
		user_id = player.user.id,
		tickets_won = ticketsGained,
		exp_won = expGained,
		energy_lost = energyLost,
		lucky_tokens = luckyTokensWon,
		cost = cost,
		tiers_to_claim = tiersToClaim or {},
		rewards = rewards or {},
		event_id = event_id,
	})

	RandomDelay(function()
		HTTPClient.Request(req, function(res, err)
			if err == HTTPError.None then
				-- Parse the response, decode the updated status, and return ranksAdvanced.
				local json = res:GetJSONBody()
				--print(res:GetBody())
				cb({
					status = self:DecodeStatus(json["status"]),
					ranksAdvanced = json["ranks_advanced"],
				}, nil)
			else
				cb(nil, tostring(err))
			end
		end)
	end)
end

export type ModifyPlayersBulkRequest = {
	user_id: string,
	energyLost: number,
	luckyTokensWon: number,
	ticketsGained: number,
	expGained: number,
	rewards: specialRewards | nil,
	tiersToClaim: {number} | nil,
}

function TicketAPI:ModifyPlayersBulk(
	event_id: string,
	all_changes: {ModifyPlayersBulkRequest},
	cb: (response: any, err: any) -> () --response: StateModifiedResponse | nil, err: any) -> ()
): ()
	local req = HTTPRequest.new(self.baseURL .. "/realm/direct/tickets_bulk_change_inventory", HTTPMethod.POST)
	req:SetHeader("Content-Type", "application/json")
	req:SetHeader("x-world-id", WorldID)

	-- JSON request body includes user_id and changes to their inventory/values.
	req:SetJSONBody({
		event_id = event_id,
		all_changes = all_changes,
	})

	RandomDelay(function()
		HTTPClient.Request(req, function(res, err)
			if err == HTTPError.None then
				-- Parse the response, decode the updated status, and return ranksAdvanced.
				local json = res:GetJSONBody()
				--print(res:GetBody())
				cb(nil)
			else
				cb(tostring(err))
			end
		end)
	end)
end

-- New is a convenience function to create a TicketAPI instance.
function New(baseURL: string): TicketAPI
	return TicketAPI.New(baseURL)
end
