--!Type(Client)

--!SerializeField
local positionCurve:AnimationCurve = nil
local TweenModule = require("TweenModule")
Tween = TweenModule.Tween
local tempTime = 0
local speed = 2
local startPos = nil
local targetPos = nil
local angularSpeed = math.random(300, 500)

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
        self.gameObject.transform.eulerAngles = Vector3.new(value*angularSpeed, 0, value*(angularSpeed/2))
    end,
    function()
        
    end
)

function self:Awake()
    startPos = self.gameObject.transform.position

end

function throw(targetPosition)
    targetPos = targetPosition
    throwTween:start()
    Timer.After(.6, function() GameObject.Destroy(self.gameObject) throwTween:stop() end)
end
