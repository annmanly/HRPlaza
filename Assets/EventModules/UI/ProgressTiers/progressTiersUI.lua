--!Type(UI)

--!SerializeField
local custom_currency_Icon: Texture = nil -- Icon for ectoplaz currency.

--!Bind
local progress_root : VisualElement = nil
--!Bind
local click_off : VisualElement = nil

--!Bind
local grand_prize_image : UIImage = nil
--!Bind
local grand_prize_container : VisualElement = nil
--!Bind
local grand_title : Label = nil

--!Bind
local cost_label : Label = nil


--!Bind
local rewards_collection: UICollection = nil
--!Bind
local rewards_cells: UICollectionCells = nil

local utils = require("Utils")
local eventUIModule = require("EventUIModule")
local PrankModule = require("PrankModule")
local progressData = {
	TotalExp = 0,
	currentGoal = 1,
	currentBase = 0,
	width = 0,
	mini_tier_rewards = {},
	main_tier_rewards = {},
	main_reward = {},
	main_reward_index = 0,
	maxExp = false,
	rank = 0,
	final_reward = {},
	user_tier_rewards = {},
	crew_tier_rewards = {},
	league_tier_rewards = {},
	crewName = "",
	crewTickets = 0,
	crewRank = 0,
}

local RewardState = {
    Upcoming = {},
    Collected = {},
    Current = {}
}

local finalRewardID = ""
local finalRewardType = ""

local timesLeft = {}


function ScrollTo(index, recursionGuard)
    if not recursionGuard then recursionGuard = 0 end
    
    if recursionGuard >= 10 then
        return
    end

    Timer.After(0.01, function()  
        local rewards = progressData.main_tier_rewards
        
        local offset = rewards_collection:GetResolvedStyleSize().y * 0.88 - 60
        rewards_collection:ScrollTo(rewards_cells, #rewards - 1 - index, offset)

        local cell = rewards_cells:GetVisibleCell(#rewards - 1 - index)

        if not cell or not cell.isDisplayed then
            ScrollTo(index, recursionGuard + 1)
        end
    end)
end

function self:Start()
    print("START")
    eventUIModule.DisableUIs({ "eventHudObj", "currencyAwardObj", "energyWidget", "hudButtonsOBJ" })
end

function CreateReward(reward, rewardState)
    --print("CreateReward", reward.category, reward.item_id, reward.cost)
    local _rewardEntry = VisualElement.new()
    _rewardEntry:AddToClassList("reward-entry")

    local _rewardIconBG = VisualElement.new()
    _rewardIconBG:AddToClassList("reward-bg")

    local _rewardIcon = UIImage.new()
    _rewardIcon:AddToClassList("reward-item")

    -- Create Cost UI
    local _costContainer = VisualElement.new()
    _costContainer:AddToClassList("cost-container")
    local _costIcon = VisualElement.new()
    _costIcon:AddToClassList("cost-icon")
    
    local _costAmount = Label.new()
    _costAmount.text = utils.formatNumber(reward.cost)
    _costAmount:AddToClassList("cost-amount")
    _costContainer:Add(_costIcon)
    _costContainer:Add(_costAmount)

    if reward.category == "custom_currency" then
        -- Set the Currency Icon.
        _rewardIcon.image = custom_currency_Icon
    elseif reward.category == "container" then
        _rewardIcon:LoadFromCdnUrl("https://cdn.highrisegame.com/container/".. reward.item_id .."/thumbnail")
    else
        print("D")
        _rewardIcon:LoadItemPreview(reward.category, reward.item_id) -- Load the reward icon.
    end

    local _displayTitle = Label.new()
    _displayTitle.pickingMode = PickingMode.Ignore
    local displayName = reward.displayName and reward.displayName or ""
    _displayTitle.text = tostring(displayName)
    _displayTitle:AddToClassList("reward-name")
    _displayTitle:AddToClassList(reward.rarity)

    local _rewardAmount = Label.new()
    local displayAmount = reward.amount > 1 and "x"..tostring(reward.amount) or ""
    _rewardAmount.text = displayAmount
    _rewardAmount:AddToClassList("reward-amount")

    _rewardIcon:Add(_rewardAmount)

    _rewardEntry:Add(_rewardIconBG)
    _rewardEntry:Add(_rewardIcon)
    _rewardEntry:Add(_displayTitle)


    if rewardState == RewardState.Current then
        _rewardEntry:AddToClassList("entry__current")
    elseif rewardState == RewardState.Collected then
        _rewardEntry:AddToClassList("entry__collected")

        _rewardIconBG:AddToClassList("hidden")
        _rewardIcon:AddToClassList("collected-item")
        _rewardAmount:AddToClassList("collected-item")

        _costContainer.style.opacity = 0.6
    else
        _rewardEntry:AddToClassList("entry__upcoming")
    end

    local item_type = PrankModule.CategoryToType(reward.category)
	_rewardIcon:RegisterPressCallback(function()
		if reward.category == "container" then item_type = "Container" end
		UI:ExecuteDeepLink("http://high.rs/item?id=" .. reward.item_id .. "&type=" .. item_type)
		print("http://high.rs/item?id=" .. reward.item_id .. "&type=" .. item_type)
	end)

    return _rewardEntry, _costContainer
end

local testProgressionData = require("testProgressionData")
local testTiers = testProgressionData.testTiers

function SetProgressData(data)
    --print("SetProgressData")
    progressData = data 
    --print(progressData.TotalExp)

    local rewards = progressData.main_tier_rewards

    --for i, reward in ipairs(rewards) do
    --    print("reward", reward.category, reward.item_id, reward.cost)
    --end

    local _reward, _index = GetCurrentReward()
    local rewardProgress = progressData.width * 100

    timesLeft = {}

    rewards_cells.provider = UICollectionDelegateProvider.new(
        function(cellFromIndex : number) : UIView
            local uiView = UIView.new()
            uiView:AddToClassList("main_rewards-entry")
            local rewardIndex = #rewards - 1 - cellFromIndex

            local progressBar = VisualElement.new()
            progressBar:AddToClassList("main_rewards-progress_bar-bg")

            if rewardIndex == 1 and rewardIndex == _index  then -- If the reward is the first reward and the current reward.
                local progressBarFill = VisualElement.new()
                progressBarFill:AddToClassList("main_rewards-progress_bar-top")
                
                progressBarFill.style.height = StyleLength.new(Length.Percent(rewardProgress/2))
                
                progressBar:Add(progressBarFill)

            elseif rewardProgress < 50 and rewardIndex == (_index - 1) then -- If the progress is less than 50% and the reward is the one before the current reward.
                local progressBarFill = VisualElement.new()
                progressBarFill:AddToClassList("main_rewards-progress_bar-top")

                progressBarFill.style.height = StyleLength.new(Length.Percent(rewardProgress + 50))

                progressBar:Add(progressBarFill)

            elseif rewardProgress >= 50 and rewardIndex == _index then -- If the progress is greater than 50% and the reward is the current reward.
                local progressBarFill = VisualElement.new()
                progressBarFill:AddToClassList("main_rewards-progress_bar-top")
                progressBarFill.style.height = StyleLength.new(Length.Percent(rewardProgress - 50))
                --print("setting progress bar fill", rewardProgress - 50)

                progressBar:Add(progressBarFill)
            elseif rewardProgress >= 50 and rewardIndex == #rewards-1 and rewardIndex == (_index - 1) then -- If the progress is greater than 50% and the reward is the one before the current reward and the last reward.
                local progressBarFill = VisualElement.new()
                progressBarFill:AddToClassList("main_rewards-progress_bar-top")
                progressBarFill.style.height = StyleLength.new(Length.Percent(50 + (rewardProgress/2)))

                progressBar:Add(progressBarFill)

            elseif rewardIndex < _index then -- If the reward has been collected.
                local progressBarFill = VisualElement.new()
                progressBarFill:AddToClassList("main_rewards-progress_bar-filled")
                progressBar:Add(progressBarFill)
            end

            
            uiView:Add(progressBar)

            local lock = VisualElement.new()
            if rewardIndex < _index then
                lock:AddToClassList("lock_icon-unlocked")
            else
                lock:AddToClassList("lock_icon-locked")
            end

            --Time Gate Info
            local rewardTimeGate = VisualElement.new()
            rewardTimeGate:AddToClassList("time_gate_container")
            local timeGateText = Label.new()
            timeGateText:AddToClassList("time_gate_text")

            rewardTimeGate:Add(timeGateText)
            if rewards[rewardIndex].reward_xp_gate then
                local timeLeft = os.difftime(rewards[rewardIndex].reward_xp_gate.unlocks_at, os.time(os.date("!*t")))
                timeGateText.text = utils.unixToHMS(timeLeft)
                if timeLeft > 0 then
                    lock:Add(rewardTimeGate)
                end
                table.insert(timesLeft, {timeLeft, timeGateText, rewardTimeGate})
            end

            uiView:Add(lock)

            --print("rewardIndex", rewardIndex, _index, #rewards - 1 - cellFromIndex)
            local rewardState = RewardState.Upcoming
            if rewardIndex == _index then
                rewardState = RewardState.Current
            elseif rewardIndex < _index then
                rewardState = RewardState.Collected
            end

            local new_Reward, costUI = CreateReward(rewards[rewardIndex], rewardState)
            --if rewardIndex == 1 then
            --    new_Reward.style.marginTop = StyleLength.new(Length.new(25))
            --end
            uiView:Add(new_Reward)
            uiView:Add(costUI)

            return uiView
        end
    )

    rewards_collection:PerformUpdates(function() 
        rewards_cells:RemoveAllCells()
        rewards_cells:AddCells(#rewards - 1)
    end)
    
    rewards_collection:Rebuild()
    ScrollTo(_index)

    local _grandReward = rewards[#rewards]
    if _grandReward.category == "custom_currency" then
        grand_prize_image.image = custom_currency_Icon
    elseif _grandReward.category == "container" then
        print("F")
        grand_prize_image:LoadFromCdnUrl("https://cdn.highrisegame.com/container/".. _grandReward.item_id .."/thumbnail")
    else
        print("E")
        grand_prize_image:LoadItemPreview(_grandReward.category, _grandReward.item_id) -- Load the reward icon.
        local item_type = PrankModule.CategoryToType(_grandReward.category)

        local displayName = _grandReward.displayName and _grandReward.displayName or ""
        grand_title.text = tostring(displayName)
        grand_title:AddToClassList(_grandReward.rarity)
    end

    cost_label.text = utils.formatNumber(_grandReward.cost)
    local item_type = PrankModule.CategoryToType(_grandReward.category)
    finalRewardID = _grandReward.item_id
    finalRewardType = item_type
    
end

grand_prize_image:RegisterPressCallback(function()
    UI:ExecuteDeepLink("http://high.rs/item?id=" .. finalRewardID .. "&type=Container")
    print("http://high.rs/item?id=" .. finalRewardID .. "&type=" .. "Container")
end)

function self:Start()
    eventUIModule.DisableUIs({"progressTiersOBJ"})

    Timer.Every(1, function()
        for i, timeData in ipairs(timesLeft) do
            timeData[1] = timeData[1] - 1
            timeData[2].text = utils.unixToHMS(timeData[1])
            if timeData[1] <= 0 then
                timeData[3]:RemoveFromHierarchy()
                table.remove(timesLeft, i)
            end
        end
    end)
end

function GetCurrentReward()
    for i, reward in ipairs(progressData.main_tier_rewards) do
        if  reward.cost == progressData.currentGoal then
            print("Found current reward", reward.cost, progressData.currentGoal)
            return reward, i
        end
    end
    print("Current reward not found", progressData.currentGoal)
    return progressData.main_tier_rewards[#progressData.main_tier_rewards], #progressData.main_tier_rewards
end

click_off:RegisterPressCallback(function()
    eventUIModule.DisableUIs({"progressTiersOBJ"})
    eventUIModule.ShowMainUI()
end)