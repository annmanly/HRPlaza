--!Type(Client)

--!SerializeField
local emote_ids : { string } = {} -- List of emote IDs.
--!SerializeField
local is_loop : boolean = false -- Should the emotes loop?

local character = nil

function self:Awake()
    character = self.gameObject:GetComponent(Character)
    if not character then
        print("No Character component found on " .. self.gameObject.name)
        return
    end

    playEmote()
end

function self:Update()
    if character == nil or not is_loop then return end

    if character.state == CharacterState.Idle then
        playEmote()
    end
end

function playEmote()
    if #emote_ids == 0 then
        print("No emotes to play on " .. self.gameObject.name)
        return
    end

    -- Pick a random emote and play it.
    local emoteIndex = math.random(1, #emote_ids)
    character:PlayEmote(emote_ids[emoteIndex], false)
end