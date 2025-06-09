--!Type(UI)

--!SerializeField
local custom_currency_Icon: Texture = nil -- Icon for ectoplaz currency.

--!SerializeField
local default_container_Icon: Texture = nil -- Icon for default container.
--!SerializeField
local progressBarGrowthParticleRenderTexture: Texture = nil -- Texture for the progress bar growth particle effect.
--!SerializeField
local progressBarGrowthParticleVirtualScene: GameObject = nil -- GameObject for the progress bar particle effect.
--!SerializeField
local openCardSound : AudioShader = nil -- Sound for opening the card.
--!SerializeField
local closeCardSound : AudioShader = nil -- Sound for opening the card.

--!Bind
local event_info: UILuaView = nil
--!Bind
local click_off: UILuaView = nil
--!Bind
local event_title: VisualElement = nil
--!Bind
local event_info_panel: VisualElement = nil


--!Bind
local leaderboard_container: VisualElement = nil
--!Bind
local leaderboard_tab_1: VisualElement = nil
----!Bind
--local leaderboard_tab_2: VisualElement = nil
--!Bind
local leaderboard_tab_3: VisualElement = nil
--!Bind
local leaderboard_tab_1_label: Label = nil
---!Bind
--local leaderboard_tab_2_label: Label = nil
--!Bind
local leaderboard_tab_3_label: Label = nil

--!Bind
local leaderboard_collection: UICollection = nil
--!Bind
local leaderboard_cells: UICollectionCells = nil

local leaderBoardTabs = {leaderboard_tab_1, leaderboard_tab_3}

local localEntry = nil

local progressData = {
	TotalTickets = 0,
	TotalExp = 0,
	currentGoal = 1,
	currentBase = 0,
	width = 0,
	mini_tier_rewards = {},
	main_tier_rewards = {},
	main_reward = {category = nil, item_id = nil},
	main_reward_index = 0,
	maxExp = false,
	rank = 0,
	final_reward = {category = nil, item_id = nil, cost = 0},
	user_tier_rewards = {},
	crew_tier_rewards = {},
	league_tier_rewards = {},
	crewName = "",
	crewTickets = 0,
	crewRank = 0,
	leagueRank = 0
}

local leaderBoardState = 1

local EventUIModule = require("EventUIModule")
local ClientPrankModule = require("ClientPrankModule")
local PrankModule = require("PrankModule")
-- Import Tweening module for animations.
local TweenModule = require("TweenModule")
local Tween = TweenModule.Tween -- Tween class for creating animations.
local Easing = TweenModule.Easing -- Easing functions for animations.

local progressParticleTimer = nil -- Timer for progress bar particle effect.

local utils = require("Utils")

function CreateLeaderboardProvider(category: string|nil)
	return UICollectionDelegateAsyncProvider.new(
        function(cellIndex, entry) : UIView
            local uiView = UIView.new()
            uiView:Add(CreateItem(entry))  
            return uiView
        end,
        function(asyncFetch : UICollectionDelegateAsyncRequest)
			if asyncFetch.resultOffset >= 100 then
				asyncFetch:CompleteRequest({})
			else
				ClientPrankModule.QueryLeaderBoard(asyncFetch.resultOffset, 10, category, function(res, total, err)
					if err ~= nil then
						asyncFetch:CompleteRequest({})
						return
					end

					asyncFetch:CompleteRequest(res.entries)
				end)
			end
        end
    )
end


local _chestPopup = nil
local _chestPopupTimer = nil
local ChestPopupTween = nil

-- Chest PopOut Tween
ChestShrinkTween = Tween:new(
	1, -- Starting scale.
	0, -- Ending scale.
	0.2, -- Duration in seconds.
	false, -- Do not loop animation.
	false, -- Do not ping-pong animation.
	Easing.easeOutQuad, -- Easing function.
	function(value) -- Update function for tween.
		_chestPopup.style.scale = StyleScale.new(Scale.new(Vector2.new(value, value))) -- Update scale of root UI element.
		--Opacity
		_chestPopup.style.opacity = StyleFloat.new(value)
	end,
	function() -- Completion callback (unused here).
		_chestPopup.style.scale = StyleScale.new(Scale.new(Vector2.new(.01, .01))) -- Update scale of root UI element.
		_chestPopup.style.opacity = StyleFloat.new(0)
		_chestPopup:RemoveFromHierarchy()
	end
)
function CloseChest()
	if _chestPopup then
		if _chestPopupTimer then _chestPopupTimer:Stop(); _chestPopupTimer = nil end
		if ChestPopupTween then ChestPopupTween:stop() end
		if ChestShrinkTween then ChestShrinkTween:stop() end
		ChestShrinkTween:start() -- Start UI pop-out animation.
	end
end

function CreateRewardsDisplay(place,_rewardTier,_rewardsContainer)
	for k, placeSection in ipairs(_rewardTier) do
		if place ~= nil then
			if place >= placeSection.min and (placeSection.max == nil or place <= placeSection.max) then
				-- Add individual rewards to the reward container if there are 3 or less rewards
				if #placeSection.rewards <= 4 then
					--print("Place: " .. tostring(place) .. " Min: " .. tostring(placeSection.min) .. " Max: " .. tostring(placeSection.max))
					for i, reward in ipairs(placeSection.rewards) do
						--print("Reward: " .. tostring(reward.item_id) .. " Amount: " .. tostring(reward.amount))
						local _rewardIcon = UIImage.new()
						_rewardIcon:AddToClassList("leaderboard-entry-reward-icon")

						-- Load the item Image, if the item is custom currency use hardcoded image
						if reward.category == "custom_currency" then
							_rewardIcon.image = custom_currency_Icon
						elseif reward.category == "container" then
							_rewardIcon:LoadFromCdnUrl("https://cdn.highrisegame.com/container/".. reward.item_id .."/thumbnail")
						else
							print("A")
							_rewardIcon:LoadItemPreview(reward.category, reward.item_id) -- Load the reward icon.
						end

						if reward.amount > 1 then
							local _rewardAmount = UILabel.new()
							_rewardAmount:AddToClassList("leaderboard-entry-reward-amount")
							_rewardAmount:SetPrelocalizedText(utils.formatNumberSimple(reward.amount))
							_rewardIcon:Add(_rewardAmount)
						end
						_rewardsContainer:Add(_rewardIcon)

						local item_type = PrankModule.CategoryToType(reward.category)
						_rewardIcon:RegisterPressCallback(function()

							if reward.category == "container" then item_type = "Container" end

							UI:ExecuteDeepLink("http://high.rs/item?id=" .. reward.item_id .. "&type=" .. item_type)
							print("http://high.rs/item?id=" .. reward.item_id .. "&type=" .. item_type)
							if _chestPopup then CloseChest() end

						end)

					end
				else
					for i = 1, 3 do
						local reward = placeSection.rewards[i]
						--print("Reward: " .. tostring(reward.item_id) .. " Amount: " .. tostring(reward.amount))
						local _rewardIcon = UIImage.new()
						_rewardIcon:AddToClassList("leaderboard-entry-reward-icon")

						-- Load the item Image, if the item is custom currency use hardcoded image
						if reward.category == "custom_currency" then
							_rewardIcon.image = custom_currency_Icon
						elseif reward.category == "container" then
							_rewardIcon:LoadFromCdnUrl("https://cdn.highrisegame.com/container/".. reward.item_id .."/thumbnail")
						else
							print("B")
							_rewardIcon:LoadItemPreview(reward.category, reward.item_id) -- Load the reward icon.
						end

						if reward.amount > 1 then
							local _rewardAmount = UILabel.new()
							_rewardAmount:AddToClassList("leaderboard-entry-reward-amount")
							_rewardAmount:SetPrelocalizedText(utils.formatNumberSimple(reward.amount))
							_rewardIcon:Add(_rewardAmount)
						end
						_rewardsContainer:Add(_rewardIcon)

						local item_type = PrankModule.CategoryToType(reward.category)
						_rewardIcon:RegisterPressCallback(function()

							if reward.category == "container" then item_type = "Container" end

							UI:ExecuteDeepLink("http://high.rs/item?id=" .. reward.item_id .. "&type=" .. item_type)
							print("http://high.rs/item?id=" .. reward.item_id .. "&type=" .. item_type)
							if _chestPopup then CloseChest() end

						end)

					end
					-- Add a Single Chest Popup Reward to display multiple rewards
					local _chestLabel = Label.new()
					_chestLabel:AddToClassList("plus-label")
					local remainingRewards = #placeSection.rewards - 3
					_chestLabel.text = "+ " .. tostring(remainingRewards)

					_rewardsContainer:Add(_chestLabel)
					_chestLabel:RegisterPressCallback(function()
						--Open the chest popup and display the rewards
						if _chestPopup then _chestPopup:RemoveFromHierarchy() end
						-- Create new Visual Element for the Chest Popup
						_chestPopup = VisualElement.new()
						_chestPopup:AddToClassList("chest-popup")
						event_info:Add(_chestPopup)
						
						-- Ensure correct positioning
						local _chestIconPosition = _chestLabel.worldBound
						local _eventPanelPosition = event_info_panel.worldBound

						-- Calculate relative position
						local popupX = _chestIconPosition.x + 33
						local popupY = _chestIconPosition.y - 50

						-- Apply styles
						_chestPopup.style.left = StyleLength.new(popupX)
						_chestPopup.style.top = StyleLength.new(popupY)

						if ChestPopupTween then ChestPopupTween:stop() end
						-- Chest Popup Tween
						ChestPopupTween = Tween:new(
							.5, -- Starting scale.
							1, -- Ending scale.
							0.2, -- Duration in seconds.
							false, -- Do not loop animation.
							false, -- Do not ping-pong animation.
							Easing.easeOutQuad, -- Easing function.
							function(value) -- Update function for tween.
								_chestPopup.style.scale = StyleScale.new(Scale.new(Vector2.new(value, value))) -- Update scale of root UI element.
								--Opacity
								_chestPopup.style.opacity = StyleFloat.new(value)
							end,
							function() -- Completion callback (unused here).
								_chestPopup.style.scale = StyleScale.new(Scale.new(Vector2.new(1, 1))) -- Update scale of root UI element.
								_chestPopup.style.opacity = StyleFloat.new(1)
							end
						)

						Timer.After(0.01, function()
							popupY = _chestIconPosition.y - 50 - _chestPopup.worldBound.height
							_chestPopup.style.top = StyleLength.new(popupY)
							ChestPopupTween:start() -- Start UI pop-in animation.
						end)

						-- Populate the Chest's rewards
						for i = 4, #placeSection.rewards do
							local reward = placeSection.rewards[i]
							--print("Reward: " .. tostring(reward.item_id) .. " Amount: " .. tostring(reward.amount))
							local _chestReward = UIImage.new()
							_chestReward:AddToClassList("leaderboard-entry-chest-reward-icon")
							-- Load the item Image, if the item is custom currency use hardcoded image
							if reward.category == "custom_currency" then
								_chestReward.image = custom_currency_Icon
							elseif reward.category == "container" then
								_chestReward:LoadFromCdnUrl("https://cdn.highrisegame.com/container/".. reward.item_id .."/thumbnail")
							else
								print("C")
								_chestReward:LoadItemPreview(reward.category, reward.item_id) -- Load the reward icon.
							end
							if reward.amount > 1 then
								local _rewardAmount = UILabel.new()
								_rewardAmount:AddToClassList("leaderboard-entry-chest-reward-amount")
								_rewardAmount:SetPrelocalizedText(utils.formatNumberSimple(reward.amount))
								_chestReward:Add(_rewardAmount)
							end
							_chestPopup:Add(_chestReward)
		
							local item_type = PrankModule.CategoryToType(reward.category)
							_chestReward:RegisterPressCallback(function()
								UI:ExecuteDeepLink("http://high.rs/item?id=" .. reward.item_id .. "&type=" .. item_type)
								print("http://high.rs/item?id=" .. reward.item_id .. "&type=" .. item_type)
								if _chestPopup then CloseChest() end
							end)
						end

						if _chestPopupTimer then _chestPopupTimer:Stop(); _chestPopupTimer = nil end
						_chestPopupTimer = Timer.After(2, function()
							CloseChest()
						end)

					end)
				end
			end
		end
	end
end

-- Function to create an item in the leaderbaord
function CreateItem(entry: PrankModule.LeaderBoardEntry)
	local place = entry.rank + 1

	local el = VisualElement.new()
	el:AddToClassList("leaderboard-entry")

    --[[
	local _entryIcon = UIUserThumbnail.new()
	_entryIcon:AddToClassList("leaderboard-entry-icon")
	_entryIcon:Load(entry.userId)
    print("Loading user thumbnail for " .. tostring(entry.userId))
    --]]

	local _entryPlaceText = UILabel.new()
	_entryPlaceText:AddToClassList("leaderboard-entry-place")
	_entryPlaceText:SetPrelocalizedText(tostring(place))

	local _entryName = UILabel.new()
	_entryName:AddToClassList("leaderboard-entry-name")
	_entryName:SetPrelocalizedText(entry.entityName)

	-------- Place Rewards Here --------
	local _rewardsContainer = VisualElement.new()
	_rewardsContainer:AddToClassList("leaderboard-entry-rewards-container")

	local _rewardTier
	if leaderBoardState == 1 then
		_rewardTier = progressData.user_tier_rewards
	elseif leaderBoardState == 2 then
		_rewardTier = progressData.crew_tier_rewards
	elseif leaderBoardState == 3 then
		_rewardTier = progressData.league_tier_rewards
	else
		error("Invalid leaderboard state")
	end

	CreateRewardsDisplay(place,_rewardTier,_rewardsContainer)

    local _entryTicketsContainer = VisualElement.new()
    _entryTicketsContainer:AddToClassList("leaderboard-entry-tickets-container")

    local _entryTicketsIcon = VisualElement.new()
    _entryTicketsIcon:AddToClassList("leaderboard-entry-tickets-icon")
    _entryTicketsContainer:Add(_entryTicketsIcon)

    local _entryTickets = UILabel.new()
    _entryTickets:AddToClassList("leaderboard-entry-tickets")
    _entryTickets:SetPrelocalizedText(utils.formatNumber(entry.tickets))
    _entryTicketsContainer:Add(_entryTickets)

    el:Add(_entryPlaceText)
	--el:Add(_entryIcon)
	el:Add(_entryName)
	el:Add(_rewardsContainer)
    el:Add(_entryTicketsContainer)

	el:RegisterPressCallback(function()
		-- Ignore if inCrew mode
		if leaderBoardState == 2 then return end
		print("Opening Mini Profile for " .. tostring(entry.entityId))
		UI:OpenMiniProfile(entry.entityId)
	end)

	return el
end

-- Function to create the local player's entry in the leaderboard
function CreateLocalEntry(place)
	local place = place
	local name = client.localPlayer.name
	local tickets = progressData.TotalTickets

    if localEntry then
		localEntry:RemoveFromHierarchy()
	end

	if leaderBoardState == 2 then
		if progressData.crewName == nil then
			leaderboard_container:EnableInClassList("leaderboard-container-padding-override", true)
			return
			--[[
			place = 0
			name = "No Crew"
			tickets = 0
			--]]
		else
			place = progressData.crewRank
			name = progressData.crewName
			tickets = progressData.crewTickets
		end
	elseif leaderBoardState == 3 then
		place = progressData.leagueRank
		tickets = progressData.TotalTickets
	end
	leaderboard_container:EnableInClassList("leaderboard-container-padding-override", false)

	local el = VisualElement.new()
	el:AddToClassList("local-player-entry")

    --[[
	local _entryIcon = UIUserThumbnail.new()
	_entryIcon:AddToClassList("leaderboard-entry-icon")
	_entryIcon:Load(client.localPlayer.user.id)
    print("Loading LOCAL user thumbnail for " .. tostring(client.localPlayer.user.id))
    --]]

	local _entryPlaceText = UILabel.new()
	_entryPlaceText:AddToClassList("leaderboard-entry-place")
	_entryPlaceText:SetPrelocalizedText(tostring(place))

	local _entryName = UILabel.new()
	_entryName:AddToClassList("leaderboard-entry-name")
	_entryName:SetPrelocalizedText(name)

	-------- Place Rewards Here --------
	local _rewardsContainer = VisualElement.new()
	_rewardsContainer:AddToClassList("leaderboard-entry-rewards-container-local")

	local _rewardTier
	if leaderBoardState == 1 then
		_rewardTier = progressData.user_tier_rewards
	elseif leaderBoardState == 2 then
		_rewardTier = progressData.crew_tier_rewards
	elseif leaderBoardState == 3 then
		_rewardTier = progressData.league_tier_rewards
	else
		error("Invalid leaderboard state")
	end


	CreateRewardsDisplay(place,_rewardTier,_rewardsContainer)

    local _entryTicketsContainer = VisualElement.new()
    _entryTicketsContainer:AddToClassList("leaderboard-entry-tickets-container-local")

    local _entryTicketsIcon = VisualElement.new()
    _entryTicketsIcon:AddToClassList("leaderboard-entry-tickets-icon")
    _entryTicketsContainer:Add(_entryTicketsIcon)

    local _entryTickets = UILabel.new()
    _entryTickets:AddToClassList("leaderboard-entry-tickets")
    _entryTickets:SetPrelocalizedText(utils.formatNumber(tickets))
    _entryTicketsContainer:Add(_entryTickets)

    el:Add(_entryPlaceText)
	--el:Add(_entryIcon)
	el:Add(_entryName)
	el:Add(_rewardsContainer)
    el:Add(_entryTicketsContainer)

    leaderboard_container:Add(el)
	localEntry = el
end

function SetProgressData(_progressData)
	progressData = _progressData

	-- Tween time based on width to fill
	local _tweenTime = progressData.width
	InitializeUI()
	Audio:PlayShader(openCardSound)
end

-- Tween the Root UI element scaling in.
local InfoCardPopInTween = Tween:new(
	0.2, -- Starting scale.
	1, -- Ending scale.
	0.35, -- Duration in seconds.
	false, -- Do not loop animation.
	false, -- Do not ping-pong animation.
	Easing.easeOutBack, -- Easing function.
	function(value) -- Update function for tween.
		event_info_panel.style.scale = StyleScale.new(Scale.new(Vector2.new(value, value))) -- Update scale of root UI element.
		--Slide up
		local yPos = (1 - value) * 500
		event_info_panel.style.translate = StyleTranslate.new(Translate.new(Length.new(0), Length.new(yPos)))
	end,
	function() -- Completion callback (unused here).
		event_info_panel.style.scale = StyleScale.new(Scale.new(Vector2.new(1, 1))) -- Update scale of root UI element.
	end
)

-- Tween the Title UI element scaling in.
local TitlePopInTween = Tween:new(
	0.2, -- Starting scale.
	1, -- Ending scale.
	0.5, -- Duration in seconds.
	false, -- Do not loop animation.
	false, -- Do not ping-pong animation.
	Easing.easeOutBack, -- Easing function.
	function(value) -- Update function for tween.
		event_title.style.scale = StyleScale.new(Scale.new(Vector2.new(value, value))) -- Update scale of root UI element.
	end,
	function() -- Completion callback (unused here).
		event_title.style.scale = StyleScale.new(Scale.new(Vector2.new(1, 1))) -- Update scale of root UI element.
	end
)

-- Tween Leaderboard UI element scaling in.
local LeaderboardPopInTween = Tween:new(
	0.2, -- Starting scale.
	1, -- Ending scale.
	0.35, -- Duration in seconds.
	false, -- Do not loop animation.
	false, -- Do not ping-pong animation.
	Easing.easeOutBack, -- Easing function.
	function(value) -- Update function for tween.
		leaderboard_container.style.scale = StyleScale.new(Scale.new(Vector2.new(value, value))) -- Update scale of root UI element.
	end,
	function() -- Completion callback (unused here).
		leaderboard_container.style.scale = StyleScale.new(Scale.new(Vector2.new(1, 1))) -- Update scale of root UI element.
	end
)

function ResetLeaderboard()
	leaderboard_collection:Rebuild()
	leaderboard_collection:ScrollToBeginning()

	if leaderBoardState == 1 then
		leaderboard_cells.provider = CreateLeaderboardProvider(nil)
	elseif leaderBoardState == 2 then
		leaderboard_cells.provider = CreateLeaderboardProvider("crew")
	elseif leaderBoardState == 3 then
		leaderboard_cells.provider = CreateLeaderboardProvider("league")
	end
end

function InitializeUI()
	print("Initializing UI")
	event_title.style.scale = StyleScale.new(Scale.new(Vector2.new(0.2, 0.2)))
	leaderboard_container.style.scale = StyleScale.new(Scale.new(Vector2.new(0.2, 0.2)))

	Timer.After(0.2, function()
		TitlePopInTween:start() -- Start UI pop-in animation.
	end)
	Timer.After(0.2, function()
		LeaderboardPopInTween:start() -- Start UI pop-in animation.
	end)

	InfoCardPopInTween:start() -- Start UI pop-in animation.

	-- Populate the Leaderboard
	CreateLocalEntry(progressData.rank)
			
	ResetLeaderboard()
end

click_off:RegisterPressCallback(function()
	Audio:PlayShader(closeCardSound)
	EventUIModule.ClosePopup("eventInfo")
	if _chestPopup then CloseChest() end
end)

event_info_panel:RegisterPressCallback(function()
	if _chestPopup then CloseChest() end
end, false, false, false)

leaderboard_tab_1:RegisterPressCallback(function()
	leaderBoardState = 1

	for _, tab in ipairs(leaderBoardTabs) do
		tab:EnableInClassList("leaderboard-tab-active", false)
		tab:EnableInClassList("leaderboard-tab-inactive", true)
	end
	leaderboard_tab_1:EnableInClassList("leaderboard-tab-inactive", false)
	leaderboard_tab_1:EnableInClassList("leaderboard-tab-active", true)

	-- Populate the Leaderboard
	CreateLocalEntry(progressData.rank)
	ResetLeaderboard()
	if _chestPopup then CloseChest() end
end)

leaderboard_tab_3:RegisterPressCallback(function()
	leaderBoardState = 3

	for _, tab in ipairs(leaderBoardTabs) do
		tab:EnableInClassList("leaderboard-tab-active", false)
		tab:EnableInClassList("leaderboard-tab-inactive", true)
	end
	leaderboard_tab_3:EnableInClassList("leaderboard-tab-inactive", false)
	leaderboard_tab_3:EnableInClassList("leaderboard-tab-active", true)

	-- Populate the Leaderboard
	CreateLocalEntry(progressData.rank)
	ResetLeaderboard()
	if _chestPopup then CloseChest() end
end)