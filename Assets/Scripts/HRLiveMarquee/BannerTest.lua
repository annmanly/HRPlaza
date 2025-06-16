--!Type(UI)
--!Bind
local indexLabel: UILabel = nil
--!Bind
local imageDisplay: UIImage = nil

bannerURLs = {
	[1] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_16_2025/01.png",
	[2] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_16_2025/02.png",
	[3] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_16_2025/03.png",
	[4] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_16_2025/04.png",
	[5] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_16_2025/05.png",
	[6] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_16_2025/06.png",
	[7] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_16_2025/07.png",
	[8] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_16_2025/08.png",
	[9] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_16_2025/09.png",
	[10] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_16_2025/10.png",
	[11] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_16_2025/11.png",
	[12] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_16_2025/12.png",
	[13] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_16_2025/13.png",
	[14] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_16_2025/14fixed.png",
}

function self:Awake()

    index = 1 
    indexLabel:SetPrelocalizedText(`BANNER {index}`)
    imageDisplay:LoadFromCdnUrl(bannerURLs[index])
    Timer.Every(1, function() 
        imageDisplay:LoadFromCdnUrl(bannerURLs[index])
        indexLabel:SetPrelocalizedText(`BANNER {index}`)
        index += 1
        if index > #bannerURLs then index = 1 end
    end)
end