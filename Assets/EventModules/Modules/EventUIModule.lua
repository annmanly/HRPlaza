--!Type(Module)

--!SerializeField
local energyShopLink: string = ""
--!SerializeField
local itemBoostShopLink: string = ""
--!SerializeField
local tutorialPopupOBJ: GameObject = nil
--!SerializeField
local progressTiersOBJ: GameObject = nil
--!SerializeField
local EventInfoObj: GameObject = nil
--!SerializeField
local EventHudOBJ: GameObject = nil
--!SerializeField
local energyWidget: GameObject = nil
--!SerializeField
local EventObjs: GameObject = nil
--!SerializeField
local bongoMeterOBJ: GameObject = nil
--!SerializeField
local buffsShopOBJ: GameObject = nil
--!SerializeField
local rewardParticleOBJ: GameObject = nil
--!SerializeField
local buffHUDOBJ: GameObject = nil

--!SerializeField
local WelcomeUIObj: GameObject = nil
--!SerializeField
local HudButtonsOBJ: GameObject = nil


--!SerializeField
local mainCam : GameObject = nil -- Main camera object.

--!SerializeField
local BuffIcons: {Texture} = nil -- Prefab for the balloon pop effect.
buffIcons = BuffIcons

--!SerializeField
local customCurrencyIcon: Texture = nil -- Prefab for the balloon pop effect.
_customCurrencyIcon = customCurrencyIcon

--!SerializeField
local storeTransform: Transform = nil -- Prefab for the balloon pop effect.
--!SerializeField
local tutParticle: ParticleSystem = nil -- Prefab for the balloon pop effect.
local tutorialActive = false

uiOBJs = {
	eventInfoObj = EventInfoObj,
	eventHudObj = EventHudOBJ,
	energyWidget = energyWidget,
	tutorialPopup = tutorialPopupOBJ,
	progressTiersOBJ = progressTiersOBJ,
	WelcomeUIObj = WelcomeUIObj,
	hudButtonsOBJ = HudButtonsOBJ,
	bongoMeterOBJ = bongoMeterOBJ,
	buffHUDOBJ = buffHUDOBJ,
}

energyUI = nil
bongoMeter = nil
rewardParticleUI = nil
buffsShopUI = nil
buffHUD = nil

local preTokens = 0
local preXP = 0
local latestTickets = 0

local container: VisualElement

updateTicketsEvent = Event.new("UpdateTicketsEvent")
updateXPEvent = Event.new("updateXPEvent")

local EventActive = BoolValue.new("EventActive", true)

local PrankModule = require("PrankModule")
local gameManager = require("GameManager")
local clientPrankModule = require("ClientPrankModule")

local audioManager = require("AudioManager")

tiers_claimed_data = {} -- ntry : {min = x, claimed = false}

function DisableAllUI()
	for k, v in uiOBJs do
		if v ~= nil then
			v:SetActive(false)
		end
	end
end

function DisableUIs(UIs)
	for _, UI in ipairs(UIs) do
		--print("Disabling UI: " .. UI)
		if uiOBJs[UI] == nil then
			print("UI: " .. UI .. " Object not found")
		else
			uiOBJs[UI]:SetActive(false)
		end
	end
end
function EnableUIs(UIs)
	for _, ui in pairs(UIs) do
		if uiOBJs[ui] == nil then
			print("UI Object: " .. ": " .. "not found")
		else
			uiOBJs[ui]:SetActive(true)
		end
	end
end

function GetUIobj(ui: string)
	return uiOBJs[ui]
end

function OpenLeaderboard()
	clientPrankModule.OpenLeaderboard()
end

function OpenProgressRewards()
	clientPrankModule.OpenProgressRewards()
end

function ShowTutorialPopup()
	DisableUIs({ "eventHudObj", "energyWidget", "hudButtonsOBJ", "bongoMeterOBJ", "buffHUDOBJ"})
	WelcomeUIObj:SetActive(true)
	--WelcomeUIObj:GetComponent(UIWelcomePopup).ShowState(1)
end

function OpenEnergyShop()
	print("Opening Energy Shop")
	-- Open the energy shop.
	UI:ExecuteDeepLink(energyShopLink)
	print("Energy Shop Link: " .. energyShopLink)
end

function OpenItemBoostShop()
	-- Open the item boost shop.
	UI:ExecuteDeepLink(itemBoostShopLink)
end

function OpenBuffsShop()
	DisableUIs({ "eventHudObj", "energyWidget", "hudButtonsOBJ", "bongoMeterOBJ", "buffHUDOBJ"})
	buffsShopOBJ:SetActive(true)
	buffsShopUI.InitBuffsShop()
end

function CloseBuffsShop()
	buffsShopOBJ:SetActive(false)
	ShowMainUI()
end

function ShowMainUI()
	EnableUIs({ "eventHudObj", "energyWidget" , "hudButtonsOBJ", "bongoMeterOBJ", "buffHUDOBJ"})
end

function ShowResult(response: PrankModule.PrankResponse)
	local tokensGained = response.state.eventStatus.luckyTokens - preTokens
	preTokens = response.state.eventStatus.luckyTokens
	latestTickets = response.state.eventStatus.ticketsTotal

	local xpGained = response.state.eventStatus.exp - preXP
	preXP = response.state.eventStatus.exp
	
	--print("Exp Gained: " .. xpGained)
	EventHudOBJ:GetComponent(hudMain).UpdateEventValuesResponse(response, tokensGained)

	print("Tokens Gained: " .. response.ticketsGained)
	rewardParticleUI.TicketAward(response.ticketsGained)

	energyUI.SetStateValues(response.state)


	updateTicketsEvent:Fire(response.state.eventStatus.ticketsTotal)
	updateXPEvent:Fire(response.state.eventStatus.exp)
end

function PlayUITicketReward(tickets: number)
	if tickets > 0 then
		rewardParticleUI.TicketAward(tickets)
	end
end

function SyncState(state: PrankModule.UserPrankState)
	preTokens = state.eventStatus.luckyTokens
	preXP = state.eventStatus.exp
	latestTickets = state.eventStatus.ticketsTotal
	EventHudOBJ:GetComponent(hudMain).UpdateEventValuesState(state)

	energyUI.SetStateValues(state)

	updateTicketsEvent:Fire(state.eventStatus.ticketsTotal)
	updateXPEvent:Fire(state.eventStatus.exp)
end

function UpdateTicketsXP(tickets: number, xp: number)

	updateTicketsEvent:Fire(latestTickets + tickets)
	latestTickets = latestTickets + tickets

	updateXPEvent:Fire(xp)
end

local lineRenderer: LineRenderer = nil
local lineMaterial: Material = nil
local offset: number = 0
function StartTutorial()
	tutParticle:Play()
	lineRenderer = self.gameObject:GetComponent(LineRenderer)
    lineRenderer.positionCount = 2
	lineMaterial = lineRenderer.material;
    UpdateLine()
	tutorialActive = true
end
function EndTutorial()
	tutParticle:Stop()
	tutorialActive = false
	if lineRenderer ~= nil then
		lineRenderer.positionCount = 0
	end
end

function UpdateLine()
    if (client.localPlayer.character.gameObject.transform ~= nil and storeTransform ~= nil) then
        lineRenderer:SetPosition(0, client.localPlayer.character.gameObject.transform.position)
        lineRenderer:SetPosition(1, storeTransform.position)
		offset += Time.deltaTime * -.15;
        lineMaterial.mainTextureOffset = Vector2.new(offset, 0);
	end
end

function ShowPopup(popup: string, state)
	if popup == "eventInfo" then
		local _progressData = EventHudOBJ:GetComponent(hudMain).GetProgressData()
		print(typeof(_progressData))
		if _progressData == nil then return end

		DisableUIs({ "eventHudObj", "energyWidget", "hudButtonsOBJ", "bongoMeterOBJ", "buffHUDOBJ" })

		EventInfoObj:SetActive(true)
		local popupScript = EventInfoObj:GetComponent(EventInfo)

		_progressData.rank = state.eventStatus.rank
		popupScript.SetProgressData(_progressData)
	end
	if popup == "progress" then
		local _progressData = EventHudOBJ:GetComponent(hudMain).GetProgressData()
		if _progressData == nil then return end

		DisableUIs({ "eventHudObj", "energyWidget", "hudButtonsOBJ", "bongoMeterOBJ", "buffHUDOBJ" })
		EnableUIs({"progressTiersOBJ"})
		local _progressTiersUIScript = uiOBJs["progressTiersOBJ"]:GetComponent(progressTiersUI)
		_progressTiersUIScript.SetProgressData(_progressData)
	end
end

function ClosePopup(popup: string)
	if popup == "eventInfo" then
		DisableUIs({ "eventInfoObj" })
		ShowMainUI()
	end
end

function EndEvent()
	EventObjs:SetActive(false)
end

function SetEventData(eventData: PrankModule.Event)
	EventHudOBJ:GetComponent(hudMain).SetEventData(eventData)
end

function SetEnergyShopLink(id: string)
	energyShopLink = "https://high.rs/shop?type=ic&id=" .. id
	print("Energy Shop Link: " .. energyShopLink)
end

function self:ClientAwake()
	EventActive.Changed:Connect(function(value)
		if value == false then
			EndEvent()
		end
	end)

	local canInvFetch = true
	InventoryManager.inventoryChanged:Connect(function()
		if canInvFetch then 
			canInvFetch = false
			Timer.After(0.5,function()
				print("INVENTORY CHANGED SYNCING UI")
				clientPrankModule.SyncUItoState()
				Timer.After(0.2, function() canInvFetch = true end)
			end)
		end
	end)

end

function self:ClientStart()
	DisableUIs({"eventInfoObj"})
	energyUI = energyWidget:GetComponent(EnergyTimer)
	bongoMeter = bongoMeterOBJ:GetComponent(BongoMeter)
	rewardParticleUI = rewardParticleOBJ:GetComponent(RewardParticle)
	buffsShopUI = buffsShopOBJ:GetComponent(BuffsShop)
	buffHUD = buffHUDOBJ:GetComponent(BuffhudDisplay)

	CloseBuffsShop()
	bongoMeterOBJ:SetActive(false)
	buffHUDOBJ:SetActive(false)
end

function self:ClientUpdate()
	if tutorialActive then
		if storeTransform ~= nil then
			UpdateLine()
		end
	end
end

function self:ServerAwake()
end
