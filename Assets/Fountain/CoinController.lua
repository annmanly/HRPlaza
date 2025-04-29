--!Type(Client)

--!SerializeField
local positionCurve:AnimationCurve = nil
local TweenModule = require("TweenModule")
Tween = TweenModule.Tween
local tempTime = 0
local speed = 2
local startPos = nil
local targetPos = nil
local angularSpeed = 500

local throwTween = Tween:new(
    0,
    1,
    1.25,
    false,
    false,
    TweenModule.Easing.easeOutBack,
    function(value, t)
        positionOffset = positionCurve:Evaluate(value)
        self.gameObject.transform.position = Vector3.Lerp(startPos, targetPos, value) + Vector3.new(0, positionOffset*2, 0)
        self.gameObject.transform.eulerAngles = Vector3.new(value*angularSpeed, 0, 0)
    end,
    function()
        GameObject.Destroy(self.gameObject)
    end
)

function self:Awake()
    startPos = self.gameObject.transform.position + Vector3.new(0,2,0)

end

function throw(targetPosition)
    targetPos = targetPosition
    throwTween:start()
end
