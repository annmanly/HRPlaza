--[[
	
	Copyright (c) 2024 Pocket Worlds

	This software is provided 'as-is', without any express or implied
	warranty.  In no event will the authors be held liable for any damages
	arising from the use of this software.

	Permission is granted to anyone to use this software for any purpose,
	including commercial applications, and to alter it and redistribute it
	freely, subject to the following restrictions:

	1. The origin of this software must not be misrepresented; you must not
	claim that you wrote the original software. If you use this software
	in a product, an acknowledgment in the product documentation would be
	appreciated but is not required.
	2. Altered source versions must be plainly marked as such, and must not be
	misrepresented as being the original software.
	3. This notice may not be removed or altered from any source distribution.
	
--]] 

--!Type(Module)

--!SerializeField
local enableVoice: boolean = true

--!SerializeField
local defaultChannel: number = 0

--!SerializeField
local noVoiceChannelName: string = "General Chat"

--!SerializeField
local voiceChannelName: string = "General Voice"

--!SerializeField
local broadcastChannelName: string = "Broadcast"

--!SerializeField
local enableProximityChat: boolean = true

--!SerializeField
--!Tooltip("The distance between players where their voice starts to get softer")
local maxVolumeDistance: number = 15

--!SerializeField
--!Tooltip("The distance between players where you can no longer hear them")
local minVolumeDistance: number = 30

local channels = {}
local defaultChannelInfo = nil

local DefaultChannel = { 
    NoVoice = 0,
    Voice = 1,
    Broadcast = 2
}

local function CreateChannel(name : string, allowsVoice : boolean) : ChannelInfo
	local channel = Chat:CreateChannel(name, true, allowsVoice)
	table.insert(channels, channel)
	return channel
end

function self:ServerStart()
	if enableVoice then
		--Channels are displayed in the order they are created, always show the default first
		local noVoiceChannel = CreateNoVoiceChannel()
		local voiceChannel = CreateVoiceChannel()
		local broadcastChannel = CreateBroadcastChannel()

		if defaultChannel == DefaultChannel.NoVoice then
			defaultChannelInfo = noVoiceChannel
		elseif defaultChannel == DefaultChannel.Voice then
			defaultChannelInfo = voiceChannel
		else
			defaultChannelInfo = broadcastChannel
		end
	else
		defaultChannelInfo = CreateChannel(noVoiceChannelName, false)
	end

	--Always add new players to all of the channels
	server.PlayerConnected:Connect(function(player)
		if defaultChannelInfo ~= nil then
			Chat:AddPlayerToChannel(defaultChannelInfo, player)
		end

		for index, channel in channels do
			if channel ~= defaultChannelInfo then
				Chat:AddPlayerToChannel(channel, player)
			end
		end
	end)
end

function CreateNoVoiceChannel() : ChannelInfo
	local noVoiceChannel = CreateChannel(noVoiceChannelName, true)
	noVoiceChannel.speakerFilter = function(player) return false end
	return noVoiceChannel
end

function CreateVoiceChannel() : ChannelInfo
	local voiceChannel = CreateChannel(voiceChannelName, true)
	if enableProximityChat then
		voiceChannel:EnableProximityChat(maxVolumeDistance, minVolumeDistance)
	end
	return voiceChannel
end

function CreateBroadcastChannel() : ChannelInfo
	local broadcastChannel = CreateChannel(broadcastChannelName, true)
	broadcastChannel.speakerFilter = OwnersAndModeratorsOnly
	return broadcastChannel
end

function OwnersAndModeratorsOnly(player : Player)
	return player.user.id == game.info.ownerId or player.user.id == game.info.creatorId or player.isModerator
end