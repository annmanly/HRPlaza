-- This script is a client-side Lua module for Highrise Studio Worlds.
-- It utilizes multiple required modules (EventUIModule, PrankModule, TicketAPI) to handle
-- player "prank" actions, querying of event states, leaderboards, and client UI updates.
-- The functions in this module coordinate between client inputs and server responses to
-- display UI elements, perform actions, and update player-related event data on the client.

--!Type(Module)

-- Early return if not running on the client, ensuring this module is only executed client-side.
if not client then
	return
end

-- Require the modules needed for UI display, prank logic, and ticket operations.
local UIModule = require("EventUIModule")
local PrankModule = require("PrankModule")
local TicketAPI = require("TicketAPI")

export type specialReward = {
	item_id: string,
	amount: number,
}
export type specialRewards = {specialReward}
export type playerBulkResponseData = {
	user_id: string,
	energyLost: number,
	luckyTokensWon: number,
	ticketsGained: number,
	expGained: number,
	rewards: specialRewards | nil,
	tiersToClaim: {number} | nil,
}

-- Variables for handling asynchronous event response connections and timers.
-- These track pending server requests so they can be canceled if needed.
local pending: EventConnection | nil = nil
local pendingTimer: Timer | nil = nil

-- Prank Only Pending Connection and Timer
local prankPending: EventConnection | nil = nil
local prankPendingTimer: Timer | nil = nil

-- Iniatation Pending and Timer
local initiationPending: EventConnection | nil = nil
local initiationPendingTimer: Timer | nil = nil

-- The actionStack variable determines how much "energy" or how many actions are consumed per prank.
local actionStack: number = 1

-- Define a Consumable type that represents items usable in the event (like energy refills).
export type Consumable = {
	id: string | nil,
	ownedAmount: number,
	text: string,
	image: Texture2D,
}

-- CancelQuery is a helper function that disconnects pending event connections and stops timers.
-- It's used whenever a server request completes, times out, or needs to be aborted.
local function CancelQuery()
	--print("Cancel Query")
	if pending then
		if pending ~= nil then
			pending:Disconnect()
		end
		pending = nil
	end
	if pendingTimer then
		pendingTimer:Stop()
		pendingTimer = nil
	end
end

-- Special Pending and cancel Query for the prank itself not fetching data
local function CancelPrankQuery()
--	print("Cancel Prank Query")
	if prankPending then
		if prankPending ~= nil then
			prankPending:Disconnect()
		end
		prankPending = nil
	end
	if prankPendingTimer then
		prankPendingTimer:Stop()
		prankPendingTimer = nil
	end
end

--Special Pending and cancel Query for initating the prank
local function CancelInitiationQuery()
	--print("Cancel Initiation Query")
	if initiationPending then
		if initiationPending ~= nil then
			initiationPending:Disconnect()
		end
		initiationPending = nil
	end
	if initiationPendingTimer then
		initiationPendingTimer:Stop()
		initiationPendingTimer = nil
	end
end

-- QueryState requests the player's current prank event state from the server.
-- The callback 'cb' receives either the player's event state or an error.
function QueryState(cb: (state: PrankModule.UserPrankState | nil, err: string | nil) -> ())
	--print("QUERRY!")
	CancelQuery()

	pending = PrankModule.EVENTS.StateResponse:Connect(
		function(data: PrankModule.UserPrankStateData | nil, err: string | nil)
			CancelQuery()
			if err ~= nil then
				print("error print " .. tostring(err))
				cb(nil, err)
			else
				-- Convert the received data into a UserPrankState object if no errors occurred.
				cb(PrankModule.UserPrankState.New(data), nil)
				--for k, v in data.eventStatus do print (tostring(k), tostring(v)) end
			end
		end
	)

	pendingTimer = Timer.After(5, function()
		CancelQuery()
		cb(nil, PrankModule.ERR_TIMED_OUT)
	end)

	-- Fire a request to the server to get the current user prank state.
	PrankModule.EVENTS.RequestState:FireServer(nil)
end

-- Special State Query only for initating the prank
function QueryStateForInitiation(cb: (state: PrankModule.UserPrankState | nil, err: string | nil) -> ())
	--print("QUERRY for Initiation!")
	CancelInitiationQuery()

	initiationPending = PrankModule.EVENTS.StateResponse:Connect(
		function(data: PrankModule.UserPrankStateData | nil, err: string | nil)
			CancelInitiationQuery()
			if err ~= nil then
				print("error print " .. tostring(err))
				cb(nil, err)
			else
				-- Convert the received data into a UserPrankState object if no errors occurred.
				cb(PrankModule.UserPrankState.New(data), nil)
			end
		end
	)

	initiationPendingTimer = Timer.After(5, function()
		CancelInitiationQuery()
		cb(nil, PrankModule.ERR_TIMED_OUT)
	end)

	-- Fire a request to the server to get the current user prank state.
	PrankModule.EVENTS.RequestState:FireServer(nil)
end

-- RequestPrank attempts to perform a prank action on the server side.
-- The callback 'cb' receives the prank response or an error after the server replies.
function RequestPrank(actionStack: number)
	-- Send a request to the server to initiate a prank action.
	PrankModule.EVENTS.RequestPrank:FireServer(actionStack)
end

-- QueryLeaderBoard retrieves a portion of the event leaderboard from the server.
-- This is useful for pagination, as 'offset' and 'limit' control which portion of the leaderboard is fetched.
function QueryLeaderBoard(
	offset: number,
	limit: number,
	category: string | nil,
	cb: (entries: PrankModule.LeaderBoardEntries, total: number, err: string | nil) -> ()
)
	CancelQuery()

	pending = PrankModule.EVENTS.GetLeaderBoardResponse:Connect(
		function(entries: PrankModule.LeaderBoardEntries, total: number, err: string | nil)
			CancelQuery()
			if err ~= nil then
				cb({}, 0, err)
			else
				cb(entries, total, nil)
			end
		end
	)

	pendingTimer = Timer.After(5, function()
		CancelQuery()
		cb(nil, 0, PrankModule.ERR_TIMED_OUT)
	end)

	-- Fire a leaderboard request to the server.
	PrankModule.EVENTS.GetLeaderBoardRequest:FireServer(offset, limit, category)
end

-- EventAction initiates a prank action against the event state.
-- It first checks if the player has enough energy. If not, it opens the energy shop UI.
-- If the player does have enough energy, it performs a prank request and shows the result.
function EventAction()
	--	print("Event Action")
	local _clientEnergy = UIModule.energyUI.energy
	if _clientEnergy < actionStack then
		print("Energy is less than action cost")
		UIModule.OpenEnergyShop()
		return
	end
	RequestPrank(actionStack)
end

-- The QueryEnergy function is disabled. It was originally intended to re-check energy before performing actions.
--[[

function QueryEnergy(callback:() -> ())
	QueryState(function(res, err)
		local state = nil
		if err then
			print("Error querying state: " .. err)
			return
		end
		if res ~= nil then
			state = res
		end

		local energy = state.eventStatus.energyAmount
		if energy < actionStack then
			print("Energy is less than action cost")
			UIModule.ShowPopup("refill", state) -- Show Refill UI
			UIModule.ActivateActionButton(true)
			return
		end

		callback()
	end)
end

--]]

-- SetActionStack allows externally setting how many actions (energy cost) will be used per prank.
function SetActionStack(stack: number)
	actionStack = stack
end

-- GetActionStack returns the current action stack value.
function GetActionStack(): number
	return actionStack
end

-- ScoreBoardProvider is a structure used to paginate through the leaderboard.
-- It handles loading data in chunks, refreshing, and checking if more data is available.
type ScoreBoardCb = (entries: { PrankModule.LeaderBoardEntry }, err: string | nil) -> nil
export type ScoreBoardProvider = {
	_data: PrankModule.LeaderBoardEntries | nil,
	_loading: boolean,
	_currentOffset: number,
	_rowsPerPage: number,
	GetEntries: (self: ScoreBoardProvider) -> { PrankModule.LeaderBoardEntry },
	HasMore: (self: ScoreBoardProvider) -> boolean,
	IsLoading: (self: ScoreBoardProvider) -> boolean,
	LoadMore: (self: ScoreBoardProvider, onData: ScoreBoardCb) -> nil,
	Refresh: (self: ScoreBoardProvider, onData: ScoreBoardCb) -> nil,
}

ScoreBoardProvider = {} :: ScoreBoardProvider
ScoreBoardProvider.__index = ScoreBoardProvider

-- Constructor for ScoreBoardProvider creates a new instance, starting at offset 0 and with 25 rows per page.
function ScoreBoardProvider.New(category: string|nil): ScoreBoardProvider
	local self = {} :: ScoreBoardProvider
	setmetatable(self, ScoreBoardProvider)
	self._loading = false
	self._currentOffset = 0
	self._rowsPerPage = 25
	self.category = category
	return self
end

-- GetEntries returns the current set of leaderboard entries loaded so far.
function ScoreBoardProvider:GetEntries(): { PrankModule.LeaderBoardEntry }
	if self._data == nil then
		return {}
	end

	return self._data.entries
end

-- HasMore checks if there are more leaderboard entries that can be fetched from the server.
function ScoreBoardProvider:HasMore(): boolean
	return self._data == nil or self._currentOffset < self._data.total
end

-- IsLoading returns whether the provider is currently waiting on a server response.
function ScoreBoardProvider:IsLoading(): boolean
	return self._loading
end

-- Refresh clears current data and starts loading leaderboard entries from the beginning.
function ScoreBoardProvider:Refresh(onData: (entries: { PrankModule.LeaderBoardEntry }, err: string | nil) -> nil)
	self._data = nil
	self._currentOffset = 0
	self:LoadMore(onData)
end

-- LoadMore attempts to fetch the next set of leaderboard entries, if not already loading.
function ScoreBoardProvider:LoadMore(onData: (entries: { PrankModule.LeaderBoardEntry }, err: string | nil) -> nil)
	if self._loading or not self:HasMore() then
		print("Already loading or no more data")
		return
	end
	self._loading = true

	QueryLeaderBoard(self._currentOffset, self._rowsPerPage, self.category, function(res, total, err)
		self._loading = false
		if err ~= nil then
			onData({}, err)
			return
		end

		-- If no data is loaded yet, assign the fetched entries directly.
		-- Otherwise, append the new entries to the existing list.
		if self._data == nil then
			self._data = res
		else
			for _, entry in ipairs(res.entries) do
				table.insert(self._data.entries, entry)
			end
		end

		self._currentOffset = self._currentOffset + self._rowsPerPage
		onData(res.entries, nil)
	end)
end

-- _lastState stores the last known state retrieved from the server.
-- _canQueryStateForRank prevents repeated quick queries for rank/state data.
local _lastState = nil
local _canQueryStateForRank = true

-- SyncUItoState queries the current event state and updates the UI with it.
-- If a callback is provided, it calls that callback after syncing.
function SyncUItoState(cb)
	QueryState(function(res, err)
		if err then
			print("Error querying state: " .. err)
			return
		end
		if res ~= nil then
			-- Find tiers the player is eligible to claim.
			local tiers_claimed_data = {}
			local playerExp = res.eventStatus.exp
			if res.eventStatus.participation_tiers then
				for _, tier in ipairs(res.eventStatus.participation_tiers) do
					table.insert(tiers_claimed_data, 
					{
						min = tier.min,
						claimed = tier.rewards_claimed,
					}
					)
				end
				UIModule.tiers_claimed_data = tiers_claimed_data
			end

			UIModule.SyncState(res)
			_lastState = res

		end
		if cb then cb() end

	end)
end

-- OpenLeaderboard queries the state and displays the event leaderboard UI popup.
-- If state querying is rate-limited, it falls back to the last known state.
function OpenLeaderboard()
	if not _canQueryStateForRank and _lastState ~= nil then
		print("Showing last known state")
		UIModule.ShowPopup("eventInfo", _lastState)
		return
	end

	QueryState(function(res, err)
		local state = nil
		if err then
			print("Error querying state: " .. err)
			return
		end
		if res ~= nil then
			state = res

			-- Find tiers the player is eligible to claim.
			local tiers_claimed_data = {}
			local playerExp = res.eventStatus.exp
			if res.eventStatus.participation_tiers then
				for _, tier in ipairs(res.eventStatus.participation_tiers) do
				table.insert(tiers_claimed_data, 
					{
						min = tier.min,
						claimed = tier.rewards_claimed,
					}
				)
				end
				UIModule.tiers_claimed_data = tiers_claimed_data
			end
		end

		-- Show the event info popup with the retrieved or last known state.
		UIModule.ShowPopup("eventInfo", state)
		_lastState = state
		_canQueryStateForRank = false
		Timer.After(5, function() _canQueryStateForRank = true end)

		UIModule.SyncState(state)
	end)
end

function OpenProgressRewards()
	QueryState(function(res, err)
		local state = nil
		if err then
			print("Error querying state: " .. err)
			return
		end
		if res ~= nil then
			state = res
			-- Show the event info popup with the retrieved or last known state.
			_lastState = state
			_canQueryStateForRank = false
			Timer.After(5, function() _canQueryStateForRank = true end)

			UIModule.SyncState(state)
		end
		UIModule.ShowPopup("progress")
	end)
end

function TryClaimTiersFromClient()
	PrankModule.EVENTS.TryClaimTiersRequest:FireServer()
end

-- ClientAwake is a client lifecycle function that runs when the script first loads on the client.
-- Here we set up event connections that react to server-provided updates such as InitialEventData.
function self:ClientAwake()

	PrankModule.EVENTS.InitialEventData:Connect(function(eventData: PrankModule.Event)
		---- On receiving initial event data, store it and sync the UI to the latest state.
		--UIModule.SetEventData(eventData)
		--print("Got event data")
		----for k, v in eventData do print (tostring(k), tostring(v)) end
		--SyncUItoState()
		--UIModule.SetEnergyShopLink(eventData.item_collection_id)
	end)

	PrankModule.EVENTS.ClaimedTiersEvent:Connect(function()
		-- When the player claims a tier reward, update the UI to reflect the change.
		SyncUItoState()
	end)

	PrankModule.EVENTS.PrankResponse:Connect(
		function(data: PrankModule.PrankResponse | nil, err: string | nil)
			CancelPrankQuery()
			if err ~= nil then
				if err ~= nil then
					print("Error requesting prank: " .. err)
					return
				end
				-- print("Recieved prank response")
				-- Show the prank result UI if the request succeeded.
				UIModule.ShowResult(nil)
			else
				if err ~= nil then
					print("Error requesting prank: " .. err)
					return
				end
				-- print("Recieved prank response")
				-- Show the prank result UI if the request succeeded.
				UIModule.ShowResult(PrankModule.PrankResponse.New(data))
			end

			-- After receiving prank data, we could fetch updated state info if needed.
			local state = nil
			if data ~= nil then
				state = data.state
				UIModule.SyncState(state)
			end

		end
	)

	PrankModule.EVENTS.BossDefeatedResponse:Connect(function(change: playerBulkResponseData | nil, err: string | nil)
		if change ~= nil then
			print("Boss defeated response")
			UIModule.UpdateTicketsXP(change.ticketsGained, change.expGained)
		end
	end)

	PrankModule.EVENTS.BossDefeatedPreCalcEvent:Connect(function(score)
		if score ~= nil then
			print("Boss defeated pre-calc response")
			UIModule.PlayUITicketReward(score)
		end
	end)
end
