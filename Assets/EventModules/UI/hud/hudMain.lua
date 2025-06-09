--!Type(UI)
-- Indicates that this script is a UI script.

-- Serialized fields to be set in the editor or externally.
--!SerializeField
local progressBarGrowthParticleRenderTexture: Texture = nil -- Texture for the progress bar growth particle effect.
--!SerializeField
local progressBarGrowthParticleVirtualScene: GameObject = nil -- GameObject for the progress bar particle effect.

--!SerializeField
local miniRewardTestIcon: Texture = nil -- Test icon for mini reward.
--!SerializeField
local miniRewardTestIcon2: Texture = nil -- Second test icon for mini reward.
--!SerializeField
local custom_currency_Icon: Texture = nil -- Icon for ectoplaz currency.



-- UI elements bound to the script.
--!Bind
local progress_bar_container: VisualElement = nil -- Container for the progress bar.
--!Bind
local progress_bar_root: VisualElement = nil -- Root element of the progress bar.
--!Bind
local ticket_icon: VisualElement = nil -- Ticket icon element.
--!Bind
local ticket_ring: VisualElement = nil -- Ring around the ticket icon.
--!Bind
local progress_fill_particle: Image = nil -- Particle effect image for progress fill.
--!Bind
local progress_bar_fill: VisualElement = nil -- Fill element of the progress bar.
--!Bind
local progress_label: Label = nil -- Label showing current progress.
--!Bind
local progress_reward_glow: VisualElement = nil -- Glow effect for progress reward.
--!Bind
local progress_reward_icon: UIImage = nil -- Icon for the progress reward.
--!Bind
local shine_image: VisualElement = nil -- Image for shine effect.
--!Bind
local super_boost_label: Label = nil -- Label showing the super boost multiplier.
--!Bind
local super_boost_indicator: VisualElement = nil -- Indicator for super boost.

--!Bind
local timer_container: VisualElement = nil -- Container for the timer.
--!Bind
local timer_label : Label = nil -- Label for the timer.

-- Import required modules.
local EventUIModule = require("EventUIModule") -- Module for event UI.
local PrankModule = require("PrankModule") -- Module for prank logic.
local ClientPrankModule = require("ClientPrankModule") -- Client-side prank module.
local utils = require("Utils") -- Utility functions.

-- Tables to store reward data.
local tier_table_rewards = {} -- Table of tier rewards.
local main_tier_rewards = {} -- Main rewards for each tier.
local mini_tier_rewards = {} -- Mini rewards for each tier.
local _main_Reward_goals = {} -- Ticket goals for main rewards.
local currentMainReward = {} -- Current main reward.

local user_tier_rewards = {} -- Table of user tier rewards.
local crew_tier_rewards = {} -- Table of user tier rewards.
local league_tier_rewards = {} -- Table of user tier rewards.

-- Import Tweening module for animations.
local TweenModule = require("TweenModule")
local Tween = TweenModule.Tween -- Tween class for creating animations.
local Easing = TweenModule.Easing -- Easing functions for animations.

-- Variables for progress bar particle effect.
local barProgressing = false -- Flag indicating if the progress bar is animating.
local SetExpProgressTween = nil -- Tween for ticket progress animation.

local progressParticleTimer = nil -- Timer for progress particle effect.

local xSecondsPerPercent = 0.02 -- Duration per percent of progress.

-- Variables to track ticket progress.
local maxExp = false -- Flag indicating if maximum tickets have been reached.
local currentExp = 0 -- Current number of tickets.
local currentGoal = 1-- Current goal for tickets.
local currentBase = 0 -- Base ticket count for current goal.

local _progress_percent = 0 -- Progress percentage.

local TotalTickets = 0 -- Total tickets accumulated.
local TotalExp = 0 -- Total exp accumulated.
local crewName = "" -- Crew name.
local crewTickets = 0 -- Crew tickets.
local crewRank = 0 -- Crew rank.
local leagueTickets = 0 -- League tickets.
local leagueRank = 0 -- League rank.

local miniRewards = {} -- Table to store mini reward elements.

local data: PrankModule.Event = nil -- Event data.
local state: PrankModule.UserPrankState = nil -- User state.
local latestState: PrankModule.UserPrankState = nil -- Latest user state.

-- Tween for the shine effect on the super boost label.
local BoostShineTween = Tween:new(
	-30, -- Starting position.
	90, -- Ending position.
	3, -- Duration in seconds.
	true, -- Loop animation.
	false, -- Do not ping-pong.
	Easing.linear, -- Linear easing function.
	function(value) -- Update function for tween.
		shine_image.style.translate = StyleTranslate.new(Translate.new(Length.new(value), Length.new(0)))
	end,
	function() -- Completion callback (unused here).
	end
)
BoostShineTween:start() -- Start the shine tween.

-- Tween to reset the progress reward icon after it disappears.
local ProgressRewardResetTween = Tween:new(
	0, -- Starting scale.
	1, -- Ending scale.
	0.3, -- Duration in seconds.
	false, -- Do not loop.
	false, -- Do not ping-pong.
	Easing.easeInQuad, -- Easing function.
	function(scale, t) -- Update function for tween.
		progress_reward_icon.style.scale = StyleScale.new(Scale.new(Vector2.new(scale, scale)))
		progress_reward_icon.style.opacity = StyleFloat.new(t)
	end,
	function() -- Completion callback.
		progress_reward_icon.style.scale = StyleScale.new(Scale.new(Vector2.new(1, 1)))
		progress_reward_icon.style.opacity = StyleFloat.new(1)
	end
)

-- Tween to bounce the progress reward icon when a reward is obtained.
local ProgressRewardBounceTween = Tween:new(
	0, -- Starting value.
	1, -- Ending value.
	0.4, -- Duration in seconds.
	false, -- Do not loop.
	false, -- Do not ping-pong.
	Easing.easeInBackLinear, -- Easing function.
	function(value, t) -- Update function for tween.
		local scale = 1 + value
		progress_reward_icon.style.scale = StyleScale.new(Scale.new(Vector2.new(scale, scale)))
		progress_reward_icon.style.opacity = StyleFloat.new(1 - t)
	end,
	function() -- Completion callback.
		progress_reward_icon.style.opacity = StyleFloat.new(0)
		ProgressRewardResetTween:start() -- Start reset tween.
	end
)

-- Tween to spin the reward glow effect continuously.
local RewardGlowSpinTween = Tween:new(
	0, -- Starting value.
	1, -- Ending value.
	10, -- Duration in seconds.
	true, -- Loop animation.
	false, -- Do not ping-pong.
	Easing.linear, -- Linear easing function.
	function(value) -- Update function for tween.
		progress_reward_glow.style.rotate = StyleRotate.new(Rotate.new(Angle.new(value * 360)))
	end,
	function() -- Completion callback (unused here).
	end
)
-- Tween to pulse the reward glow effect.
local RewardGlowPulseTween = Tween:new(
	0.9, -- Starting scale.
	1.1, -- Ending scale.
	1, -- Duration in seconds.
	true, -- Loop animation.
	true, -- Ping-pong animation.
	Easing.easeOutQuad, -- Easing function.
	function(value) -- Update function for tween.
		progress_reward_glow.style.scale = StyleScale.new(Scale.new(Vector2.new(value, value)))
	end,
	function() -- Completion callback (unused here).
	end
)
RewardGlowSpinTween:start() -- Start spinning glow.
RewardGlowPulseTween:start() -- Start pulsing glow.

-- Set initial images and hide certain elements.
progress_fill_particle.image = progressBarGrowthParticleRenderTexture -- Set particle image.
progress_fill_particle:EnableInClassList("hidden", true)
ticket_ring:EnableInClassList("hidden", true) -- Hide ticket ring.

function unixToHMS(unixTime)
    local hrs = math.floor(unixTime / 3600)
    local mins = math.floor((unixTime % 3600) / 60)
    local secs = unixTime % 60

    if hrs > 0 then
        return string.format("%dh%dm", hrs, mins)
    else
        return string.format("%dm%ds", mins, secs)
    end
end


--[[
Create a mini reward item on the progress bar.
@param amount : number - The amount of items rewarded.
@param expRequired : number - The amount of tickets required to unlock the reward.
@param Icon : Texture - The icon to display for the reward.
]]
function CreatMiniReward(amount: number, expRequired: number, category: string, _id: string)
	local _perc = (expRequired - currentBase) / (currentGoal - currentBase) * 100 -- Calculate position percentage.
	local _rewardElement = VisualElement.new() -- Create a new visual element for the reward.
	_rewardElement:AddToClassList("mini-reward-container") -- Add CSS class for styling.
	_rewardElement.style.left = StyleLength.new(Length.Percent(_perc - 4)) -- Position the reward element.

	local _rewardIcon = UIImage.new() -- Create an image for the reward icon.
	_rewardIcon:AddToClassList("mini-reward-icon") -- Add CSS class for styling.

	--_rewardIcon:LoadItemPreview(category, _id)

	_rewardElement:Add(_rewardIcon) -- Add the icon to the reward element.

	local _rewardLabel = Label.new() -- Create a label for the reward amount.
	_rewardLabel:AddToClassList("mini-reward-label") -- Add CSS class for styling.
	_rewardLabel.text = "x" .. tostring(amount) -- Set the label text.
	_rewardElement:Add(_rewardLabel) -- Add the label to the reward element.

	progress_bar_root:Add(_rewardElement) -- Add the reward element to the progress bar.

	local _rewardData = {
		element = _rewardElement,
		expRequired = expRequired,
	}

	miniRewards[_rewardElement] = _rewardData -- Store the reward data.
	return _rewardElement
end

--[[
Generate the mini rewards for this segment of tickets.
]]
function GenerateMiniRewards()
	if maxExp then
		return
	end -- Do nothing if maximum tickets reached.
	--print(#mini_tier_rewards)
	-- Generate a mini reward for each mini reward between the current base and goal
	for i, reward in ipairs(mini_tier_rewards) do
		--print("Creating Mini Reward at " .. reward.cost .. " with ID " .. reward.item_id)
		--print("Current Base:", currentBase, "Current Goal:", currentGoal, "Reward Cost:", reward.cost)
		if reward.cost > currentBase and reward.cost <= currentGoal then
			local newMiniReward = CreatMiniReward(reward.amount, reward.cost, reward.category, reward.item_id) -- Create a mini reward.
			--print("Creating Mini Reward at " .. reward.cost .. " with ID " .. reward.item_id)
		end
	end
end

--[[
Play the progress bar particle effect.
]]
function PlayProgressParticle()
	if progressParticleTimer then
		progressParticleTimer:Stop() -- Cancel the timer if it exists.
		progressParticleTimer = nil
	end
	progress_fill_particle:EnableInClassList("hidden", false) -- Show the particle effect.
	-- Position the particle effect virtual scene.
	if progressBarGrowthParticleVirtualScene then
		if progressBarGrowthParticleVirtualScene:GetComponent(ParticleSystem) then
			progressBarGrowthParticleVirtualScene:GetComponent(ParticleSystem):Play() -- Play the particle system.
		end
	end

	-- Show particle effects and activate progress fill animation.
	ticket_ring:EnableInClassList("hidden", false)
	progress_bar_fill:EnableInClassList("progress-fill-active", true)

	barProgressing = true -- Set flag indicating the bar is animating.
end

--[[
Stop the progress bar particle effect.
]]
function StopProgressParticle()
	progressParticleTimer = Timer.After(1, function() progress_fill_particle:EnableInClassList("hidden", true) end) -- Stop the particle effect. end)
	if progressBarGrowthParticleVirtualScene then
		-- Stop the particle system if it exists.
		if progressBarGrowthParticleVirtualScene:GetComponent(ParticleSystem) then
			progressBarGrowthParticleVirtualScene:GetComponent(ParticleSystem):Stop()
		end

	end
	progress_bar_fill:EnableInClassList("progress-fill-active", false) -- Deactivate progress fill animation.
	
	barProgressing = false -- Reset animation flag.
end

-- Tween for bouncing the ticket icon.
local TicketIconBounceLoopTween = Tween:new(
	0.95, -- Starting scale.
	1.05, -- Ending scale.
	0.1, -- Duration in seconds.
	true, -- Loop animation.
	true, -- Ping-pong animation.
	Easing.easeInOutSine, -- Easing function.
	function(scale) -- Update function for tween.
		ticket_icon.style.scale = StyleScale.new(Scale.new(Vector2.new(scale, scale)))
	end,
	function() -- Completion callback (unused here).
	end
)
-- Tween for the ring effect around the ticket icon.
local TicketIconRingBounceLoopTween = Tween:new(
	0.5, -- Starting scale.
	1.3, -- Ending scale.
	0.2, -- Duration in seconds.
	true, -- Loop animation.
	false, -- Do not ping-pong.
	Easing.linear, -- Linear easing function.
	function(scale, t) -- Update function for tween.
		ticket_ring.style.scale = StyleScale.new(Scale.new(Vector2.new(scale, scale)))
		ticket_ring.style.opacity = StyleFloat.new(4 * t * (1 - t)) -- Fade effect.
	end,
	function() -- Completion callback.
		ticket_ring.style.opacity = StyleFloat.new(0) -- Ensure opacity is zero at the end.
	end
)

--[[
Set the amount of tickets to display on the progress bar and play the animation and particle effects.
@param amount : number - The total amount of tickets to display.
]]
function SetExpProgress(amount: number)
	if SetExpProgressTween then
		-- If an existing tween is running, stop it and stop particle effects.
		StopProgressParticle()
		SetExpProgressTween:stop()
	end

	local newVal = amount

	local currentPercent = (currentExp - currentBase) / (currentGoal - currentBase) * 100 -- Current progress percentage.
	local newPercent = (newVal - currentBase) / (currentGoal - currentBase) * 100 -- New progress percentage.
	local percentToTween = newPercent - currentPercent -- Percentage to animate.
	percentToTween = math.min(100, percentToTween) -- Ensure it does not exceed 100%.

	local totalTweenTime = percentToTween * xSecondsPerPercent -- Total duration for the tween.
	if currentExp == 0 then
		currentExp = 1
	end -- Ensure current tickets is not zero.

	SetExpProgressTween = Tween:new(
		currentExp, -- Starting ticket count.
		newVal, -- Ending ticket count.
		totalTweenTime, -- Duration in seconds.
		false, -- Do not loop.
		false, -- Do not ping-pong.
		Easing.linear, -- Linear easing function.
		function(value) -- Update function for tween.
			currentExp = math.floor(value)
		end,
		function() -- Completion callback.
			currentExp = math.floor(newVal)
			StopProgressParticle()
			TicketIconBounceLoopTween:stop()
			TicketIconRingBounceLoopTween:stop(true)
		end
	)

	PlayProgressParticle() -- Start particle effects.
	TicketIconBounceLoopTween:start() -- Start ticket icon bounce animation.
	TicketIconRingBounceLoopTween:start() -- Start ticket ring animation.
	SetExpProgressTween:start() -- Start ticket progress tween.
end

local gate_display_timer = nil -- Timer for displaying the gate timer.
local updateTime = 1 -- Update time for the gate timer.
--[[
Set the goal amount of tickets to display on the progress bar.
]]
function SetGoal()

	function IsClaimed(tierCost)
		local claimed_tiers_data = EventUIModule.tiers_claimed_data
		--print(#claimed_tiers_data)
		--print("Checking if " .. tierCost .. " is claimed")
		for i, v in ipairs(claimed_tiers_data) do
			--print(tostring(v.min) , tostring(v.claimed))
			if v.min == tierCost then
				--print("Claimed " .. v.min)
				return v.claimed
			end
		end
		print("tier does not exist")
		return false
	end

	local _next_goal = utils.find_next_highest(_main_Reward_goals, TotalExp) -- Find the next goal based on total tickets.
	--print("Next Goal: " .. _next_goal)
	if not IsClaimed(utils.find_next_highest(_main_Reward_goals, TotalExp-1)) then
		--print("cuurent not claimed" .. utils.find_next_highest(_main_Reward_goals, TotalExp-1))
		_next_goal = utils.find_next_highest(_main_Reward_goals, TotalExp-1)
	end

	_next_goal = _next_goal or currentGoal -- Ensure next goal is not nil.
	if _next_goal >= TotalExp then
		currentBase = utils.find_highest_beneath(_main_Reward_goals, _next_goal) -- Update base to highest goal beneath total tickets.
	else
		progress_label.text = "COMPLETE!" -- Update progress label.
		maxExp = true -- Set flag if maximum tickets reached.
	end

	if _next_goal ~= currentGoal then
		currentGoal = _next_goal -- Update current goal.
		GenerateMiniRewards() -- Generate mini rewards for this segment.
	end

	-- Set the next Main rewards for the next goal.
	for i, reward in ipairs(main_tier_rewards) do
		if reward.cost == currentGoal then
			currentMainReward = reward -- Set the current main reward.

			-- Load the item Image, if the item is custom currency use hardcoded image
			if reward.category == "custom_currency" then
				progress_reward_icon.image = custom_currency_Icon
			else
				--progress_reward_icon:LoadItemPreview(reward.category, reward.item_id) -- Load the reward icon.
			end
			--print("Category: " .. reward.category .. " ID: " .. reward._id)
			--print("Current Reward: " .. reward.item_id .. " at " .. reward.cost)

			-- Check the Reward XP Gate
			if reward.reward_xp_gate then
				--print("Reward has a gate")
				--print("Reward Gate: " .. reward.reward_xp_gate.unlocks_at)
				--print("Reward Cost: " .. reward.cost)
				--print("Reward Unlocks in:" .. unixToHMS(os.difftime(reward.reward_xp_gate.unlocks_at, os.time(os.date("!*t")))))
				timer_label.text = unixToHMS(os.difftime(reward.reward_xp_gate.unlocks_at, os.time(os.date("!*t"))))

				if gate_display_timer then
					gate_display_timer:Stop()
					gate_display_timer = nil
				end
				
				timer_container:EnableInClassList("hidden", false)

				gate_display_timer = Timer.Every(updateTime, function()
					local timeLeft = os.difftime(reward.reward_xp_gate.unlocks_at, os.time(os.date("!*t")))
					timer_label.text = unixToHMS(timeLeft)
					if timeLeft <= 0 then
						timer_container:EnableInClassList("hidden", true)
						gate_display_timer:Stop()
						gate_display_timer = nil
						ClientPrankModule.TryClaimTiersFromClient()
					end
				end)
			else
				timer_container:EnableInClassList("hidden", true)
			end

			break

		end
	end

end

--[[
Set the total amount of tickets the player has.
@param amount : number - The total amount of tickets.
@param skipTween : boolean - Whether to skip the tween animation.
]]
function SetTotalExp(amount: number, skipTween)
	if amount < TotalExp then
		print("Removing tickets")
		skipTween = true -- Skip tween if tickets are removed.
	end
	TotalExp = amount -- Update total tickets.
	if skipTween then
		currentExp = TotalExp
		return
	end
	SetExpProgress(TotalExp) -- Update progress with animation.
end

-- Update function called regularly.
function self:Update()
	if not data or not state then
		-- Awaiting initial data
		return
	end

	if maxExp then
		_progress_percent = 1 -- Set progress to 100% if maximum tickets reached.
		-- Do nothing if maximum tickets reached.
		progress_bar_fill.style.width = StyleLength.new(Length.Percent(100)) -- Update progress bar fill width.
		return
	end

	progress_label.text = utils.formatNumber(math.floor(currentExp)) .. "/" .. utils.formatNumber(currentGoal) -- Update progress label.
	_progress_percent = (currentExp - currentBase) / (currentGoal - currentBase) -- Calculate progress percentage.
	_progress_percent = math.min(1, _progress_percent) -- Ensure it does not exceed 100%.

	progress_bar_fill.style.width = StyleLength.new(Length.Percent(_progress_percent * 100)) -- Update progress bar fill width.

	-- Check for unlocked mini rewards.
	for element, data in pairs(miniRewards) do
		if currentExp >= data.expRequired then
			element:EnableInClassList("mini-reward-locked", false) -- Unlock the mini reward.

			-- Tween to animate the mini reward when unlocked.
			local miniRewardBounceTween = Tween:new(
				-0, -- Starting position.
				-40, -- Ending position.
				0.25, -- Duration in seconds.
				false, -- Do not loop.
				false, -- Do not ping-pong.
				Easing.easeInBackLinear, -- Easing function.
				function(value, t) -- Update function for tween.
					data.element.style.translate =
						StyleTranslate.new(Translate.new(Length.Percent(-50), Length.Percent(value)))
					local scale = 1 + (value / -60)
					data.element.style.scale = StyleScale.new(Scale.new(Vector2.new(scale, scale)))
					data.element.style.opacity = StyleFloat.new(1 - t)
				end,
				function() -- Completion callback.
					data.element:RemoveFromHierarchy() -- Remove element from UI.
				end
			)
			miniRewardBounceTween:start() -- Start animation.
			miniRewards[element] = nil -- Remove from miniRewards table.
		else
			element:EnableInClassList("mini-reward-locked", true) -- Keep the mini reward locked.
		end
	end

	-- Check if current goal is reached or exceeded.
	if currentExp > currentGoal then
		SetGoal() -- Set the next goal.
		ProgressRewardBounceTween:start() -- Start bounce animation for reward icon.
		SetExpProgress(TotalExp) -- Update progress.
	end

	-- Update glow effect opacity based on progress.
	local _glowOpacity = _progress_percent
	progress_reward_glow.style.opacity = StyleFloat.new(_glowOpacity)
end

-- Register a callback for when the ticket icon is pressed.
progress_bar_container:RegisterPressCallback(function()
	print("Ticket Icon Pressed")
	EventUIModule.OpenProgressRewards() -- Open the progress rewards UI.
end)

-- Function to return all the info needed to set the Progress Bar and Mini Rewards
--[[
    Returns TotalExp, currentGoal, currentBase, maxExp, miniRewards
]]
function GetProgressData()
	local _hasData = data and state -- Check if data and state are available.

	if not _hasData then
		return nil
	else
		return {
			TotalTickets = state.eventStatus.ticketsTotal,
			TotalExp = TotalExp,
			currentGoal = currentGoal,
			currentBase = currentBase,
			width = _progress_percent,
			mini_tier_rewards = mini_tier_rewards,
			main_tier_rewards = main_tier_rewards,
			main_reward = currentMainReward,
			main_reward_index = utils.find_index(main_tier_rewards, currentMainReward),
			maxExp = maxExp,
			rank = state.eventStatus.rank,
			final_reward = main_tier_rewards[#main_tier_rewards],
			user_tier_rewards = user_tier_rewards,
			crew_tier_rewards = crew_tier_rewards,
			league_tier_rewards = league_tier_rewards,
			crewName = crewName,
			crewTickets = crewTickets,
			crewRank = crewRank,
			leagueTickets = leagueTickets,
			leagueRank = leagueRank,
			exp = state.eventStatus.exp,
			exp_gates = data.exp_gates,
		}
	end
end
------------------- Public Functions -------------------

--[[
Update event values based on server response.
@param response : PrankModule.PrankResponse - The server response containing event data.
@param tokensGained : number - The number of tokens gained (unused here).
]]
function UpdateEventValuesResponse(response: PrankModule.PrankResponse, tokensGained: number)
	local _totalExp = response.state.eventStatus.exp -- Total tickets from response.
	local gainedTickets = response.ticketsGained -- Tickets gained.
	local rank = response.state.eventStatus.rank -- Player's rank.

	crewName = response.state.eventStatus.crewName -- Update crew name.
	crewTickets = response.state.eventStatus.crewTickets -- Update crew tickets.
	crewRank = response.state.eventStatus.crewRank -- Update crew rank.
	leagueTickets = response.state.eventStatus.leagueTickets -- Update league tickets.
	leagueRank = response.state.eventStatus.leagueRank -- Update league rank.
	--print(tostring(response.state.eventStatus))

	SetTotalExp(_totalExp) -- Update total tickets.
	super_boost_label.text = "x" .. tostring(string.format("%.1f", response.state.ticketBoost)) -- Update boost label.
	local boostActive = response.state.eventStatus.boostSuper ~= 0 -- Check if super boost is active.

	latestState = response.state -- Store the latest state.
	state = response.state -- Update the user state.
end

function TryInitialize() end

local rewardTimer = nil -- Timer for reward animation.

--[[
Update event values based on user state.
@param state : PrankModule.UserPrankState - The user's prank event state.
]]
function UpdateEventValuesState(eventState: PrankModule.UserPrankState)
	state = eventState -- Store the user state.

	crewName = state.eventStatus.crewName -- Update crew name.
	crewTickets = state.eventStatus.crewTickets -- Update crew tickets.
	crewRank = state.eventStatus.crewRank -- Update crew rank.
	leagueTickets = state.eventStatus.leagueTickets -- Update league tickets.
	leagueRank = state.eventStatus.leagueRank -- Update league rank.

	SetTotalExp(state.eventStatus.exp, true) -- Update total tickets.
	SetGoal() -- Set the goal based on total tickets.

	super_boost_label.text = "x" .. tostring(string.format("%.1f", state.ticketBoost)) -- Update boost label.
	local boostActive = state.eventStatus.boostSuper ~= 0 -- Check if super boost is active.

	latestState = state -- Store the latest state.
end

--[[
Update progression data with rewards and tiers.
@param progressionData - Data containing progression tiers and rewards.
]]
function SetEventData(eventData: PrankModule.Event)
	data = eventData -- Store the progression data.

	main_tier_rewards = {} -- Reset main rewards.
	mini_tier_rewards = {} -- Reset mini rewards.
	user_tier_rewards = {} -- Reset user rewards.
	crew_tier_rewards = {} -- Reset crew rewards.
	league_tier_rewards = {} -- Reset league rewards.

	-- Parse the progression data to extract rewards.
	for i, tier_table in eventData.participationTiers do
		for j, reward_table in tier_table.rewards do
			if reward_table.category == "avatar_item" or reward_table.category == "pops" or reward_table.category == "custom_currency" or reward_table.category == "container" then
				-- Main reward (e.g., avatar items).

				-- Check if the reward alings with an exp gate
				local exp_gate_data = nil
				for k, gate in eventData.exp_gates do
					--print("Checking gate for " .. tier_table.min .. " with " .. gate.exp_cap)
					if tier_table.min == gate.exp_cap then
						print("Found a gate for " .. reward_table._id .. " with " .. gate.exp_cap)
						exp_gate_data = gate
						break
					end
				end

				local _item = {
					tier = i,
					item_id = reward_table.item_id,
					cost = tier_table.min,
					amount = reward_table.amount,
					category = reward_table.category,
					_id = reward_table._id,
					displayName = reward_table.disp_name,
					rarity = reward_table.rarity,
					reward_xp_gate = exp_gate_data,
				}
				table.insert(main_tier_rewards, _item)
			else
				-- Mini reward.
				local _item = {
					tier = i,
					item_id = reward_table.item_id,
					cost = tier_table.min,
					amount = reward_table.amount,
					category = reward_table.category,
					_id = reward_table._id,
				}
				table.insert(mini_tier_rewards, _item)
			end
		end
	end

	-- Build a list of main reward goals.
	_main_Reward_goals = {}
	for k, v in pairs(main_tier_rewards) do
		table.insert(_main_Reward_goals, v.cost)
	end

	-- Build a list of user tier rewards.
	for i, placeSection in ipairs(eventData.userTiers) do
		table.insert(user_tier_rewards, placeSection)
	end

	-- Build a list of crew tier rewards.
	for i, placeSection in ipairs(eventData.crewTiers) do
		table.insert(crew_tier_rewards, placeSection)
	end

	-- Build a list of league tier rewards.
	for i, placeSection in ipairs(eventData.leagueTiers) do
		table.insert(league_tier_rewards, placeSection)
	end

	-- Get  the XP Gates
	-- data.exp_gates
	for i, gate in ipairs(eventData.exp_gates) do
		for k, v in gate do
			print(k, v)
		end
	end

end
-- Uncomment to show the boost UI.
-- ClientPrankModule.ShowBoostUI()

super_boost_indicator:RegisterPressCallback(function()
	EventUIModule.OpenItemBoostShop()
end)