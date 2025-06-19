--!Type(UI)

--!Bind
local imageDisplay:UIImage = nil


function setImage(newURL)
    imageDisplay:LoadFromCdnUrl(newURL)

end