-- --[[

-- 	Copyright (c) 2024 Pocket Worlds

-- 	This software is provided 'as-is', without any express or implied
-- 	warranty.  In no event will the authors be held liable for any damages
-- 	arising from the use of this software.

-- 	Permission is granted to anyone to use this software for any purpose,
-- 	including commercial applications, and to alter it and redistribute it
-- 	freely.

-- --]]

--!Type(Client)

--!SerializeField
local longPressSound: AudioShader = nil

--!SerializeField
local raiseHeight: number = 0.5

--!SerializeField
local bounceDuration: number = 0.3

--!SerializeField
local tappableLayers: {string} = {"Default", "Character", "Tappable"}

local longPressCharacter : Character? = nil;
local longPressTween : Tween? = nil;
local tapMask: number = 0

function self:ClientAwake()
	SetupTapMask()

	Input.LongPressBegan:Connect(HandleLongPressBegan)
	Input.LongPressContinue:Connect(HandleLongPressContinue)
	Input.LongPressEnded:Connect(HandleLongPressEnded)
end

function SetupTapMask()
	for _, layerName in tappableLayers do
		tapMask = bit32.bor(tapMask, bit32.lshift(1, LayerMask.NameToLayer(layerName)))
	end
end

function HandleLongPressBegan(evt : LongPressBeganEvent)
	-- Cast a ray from the camera into the world
	local success, hit = RayCast(evt.position)
	if (not success or not hit.collider) then
		return
	end

	local character = hit.collider.gameObject:GetComponentInParent(Character)
	if not character or not character.player then
		return
	end

	longPressCharacter = character

	if longPressTween then
		longPressTween:Stop(false)
		longPressTween = nil
	end
end

function RayCast(position : Vector2)
	local camera = scene.mainCamera
	if not camera or not camera.isActiveAndEnabled then return false end

	-- Create a ray from the screen position
	local ray = camera:ScreenPointToRay(Vector3.new(position.x, position.y, 0))

	-- Cast a ray from the camera into the world
	return Physics.Raycast(ray, 1000, tapMask)
end

function HandleLongPressContinue(evt : LongPressContinueEvent)
	if longPressCharacter then
		local height = Easing.Sine(evt.progress) * raiseHeight
		longPressCharacter.renderPosition = Vector3.new(0,height, 0)
	end
end

function HandleLongPressEnded(evt : LongPressEndedEvent)
	if not longPressCharacter then return end

	local character = longPressCharacter
	longPressCharacter = nil

	-- always return back to start
	longPressTween = character:TweenRenderPositionTo(Vector3.zero)
		:EaseOutBounce(1, 3)
		:Duration(bounceDuration * evt.progress)
		:Play()

	if not evt.cancelled then
		if longPressSound then
			longPressSound:Play()
		end
		UI:OpenMiniProfile(character.player)
	end
end
