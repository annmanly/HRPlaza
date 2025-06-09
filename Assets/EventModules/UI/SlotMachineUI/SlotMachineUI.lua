--!Type(UI)

--!SerializeField
local Particle: ParticleSystem = nil
--!SerializeField
local ItemIcons: {Texture} = nil

--!Bind
local slot_container: UILuaView = nil
--!Bind
local Slot_Content: VisualElement = nil

local BumpTween
local SpinTween
local PopInTween
local popOutTween

function self:Start()

    local TweenModule = require("TweenModule")
    local Tween = TweenModule.Tween
    local Easing = TweenModule.Easing

    BumpTween = Tween:new(
        1,                      -- from
        1.25,                    -- to
        .2,                      -- duration in seconds
        false,                    -- loop
        true,                     -- pingPong
        Easing.easeOutBack,          -- easing function
        function(value, t)         -- onUpdate callback
            self.transform.localScale = Vector3.new(value, value, value)

            slot_container.style.borderTopColor = StyleColor.new(Color.new(255, 255, 255, (t-1)*-1 ))
            slot_container.style.borderBottomColor = StyleColor.new(Color.new(255, 255, 255, (t-1)*-1 ))
            slot_container.style.borderLeftColor = StyleColor.new(Color.new(255, 255, 255, (t-1)*-1 ))
            slot_container.style.borderRightColor = StyleColor.new(Color.new(255, 255, 255, (t-1)*-1 ))
        end,
        function()             -- onComplete callback
            Timer.After(.5, function()
                popOutTween:start()
            end)
        end
    )

    SpinTween = Tween:new(
        0,
        90,
        .75,
        false,
        false,
        Easing.slotEaseInOut,
        function(value, t)
            Slot_Content.style.translate = StyleTranslate.new(Translate.new(Length.new(0), Length.Percent(value)))
        end,
        function()
            Slot_Content.style.translate = StyleTranslate.new(Translate.new(Length.new(0), Length.Percent(90)))
            BumpTween:start()
            Particle:Play()
        end
    )

    PopInTween = Tween:new(
        0,                      -- from
        1,                    -- to
        .25,                      -- duration in seconds
        false,
        false,
        Easing.bounce,          -- easing function
        function(value)         -- onUpdate callback
            self.transform.localScale = Vector3.new(value, value, value)
        end,
        function()             -- onComplete callback
            self.transform.localScale = Vector3.new(1, 1, 1)
        end
    )

    popOutTween = Tween:new(
        1,                      -- from
        1.5,                    -- to
        .5,                      -- duration in seconds
        false,
        false,
        Easing.linear,          -- easing function
        function(value, t)         -- onUpdate callback
            self.transform.localScale = Vector3.new(value, value, value)
            Slot_Content.style.opacity = StyleFloat.new(1-t)
        end,
        function()             -- onComplete callback
            self.transform.localScale = Vector3.new(1, 1, 1)
            Slot_Content.style.opacity = StyleFloat.new(1)
            self.gameObject:SetActive(false)
        end
    )

    self.gameObject:SetActive(false)
end

function CreateItem(itemID: number)
    local _item = Image.new()
    _item:AddToClassList("Slot__Item")

    _item.image = ItemIcons[itemID]

    Slot_Content:Add(_item)
end

function Spin(prizeID: number)

    Slot_Content:Clear()

    slot_container.style.borderTopColor = StyleColor.new(Color.new(255, 255, 255, 1))
    slot_container.style.borderBottomColor = StyleColor.new(Color.new(255, 255, 255, 1))
    slot_container.style.borderLeftColor = StyleColor.new(Color.new(255, 255, 255, 1))
    slot_container.style.borderRightColor = StyleColor.new(Color.new(255, 255, 255, 1))

    PopInTween:start()

    for i=1, 10 do 
        if i == 1 then
            CreateItem(prizeID)
        else
            CreateItem(math.random(1, #ItemIcons))
        end
    end

    SpinTween:start()
end