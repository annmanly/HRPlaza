--!Type(Client)

--!SerializeField
local emote_ids : { string } = {} -- List of emote IDs.
--!SerializeField
local is_loop : boolean = false -- Should the emotes loop?

function self:Awake()
    local character = self.gameObject:GetComponent(Character)
    if not character then
        print("No Character component found on " .. self.gameObject.name)
        return
    end

    local function playEmote()
        if #emote_ids == 0 then
            print("No emotes to play on " .. self.gameObject.name)
            return
        end

        -- Pick a random emote and play it.
        local emoteIndex = math.random(1, #emote_ids)
        character:PlayEmote(emote_ids[emoteIndex], false, function()
            -- If it should loop, play another emote after this one.
            if is_loop then
                playEmote() -- Calls itself to start another emote.
            end
        end)
    end

    playEmote()
end
