--!Type(UI)
--!Bind
local indexLabel: UILabel = nil
--!Bind
local imageDisplay: UIImage = nil

bannerURLs = {
	[1] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_30_2025_new/image01.png",
	[2] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_30_2025_new/image02.png",
	[3] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_30_2025_new/image03.png",
	[4] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_30_2025_new/image04.png",
	[5] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_30_2025_new/image05.png",
	[6] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_30_2025_new/image06.png",
	[7] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_30_2025_new/image07.png",
	[8] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_30_2025_new/image08.png",
	[9] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_30_2025_new/image09.png",
	[10] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_30_2025_new/image10.png",
	[11] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_30_2025_new/image11.png",
	[12] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_30_2025_new/image12.png",
	[13] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_30_2025_new/image13.png",
	[14] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_30_2025_new/image14.png",
	[15] = "https://cdn.highrisegame.com/HRLiveEventBanners/WO_06_30_2025_new/image15.png",
}




function self:Awake()
	Timer.After(10, function()
		index = 1 
		indexLabel:SetPrelocalizedText(`BANNER {index}`)
		imageDisplay:LoadFromCdnUrl(bannerURLs[index])
		Timer.Every(1, function() 
			imageDisplay:LoadFromCdnUrl(bannerURLs[index])
			indexLabel:SetPrelocalizedText(`BANNER {index}`)
			index += 1
			if index > #bannerURLs then index = 1 end
		end)
	end)
end