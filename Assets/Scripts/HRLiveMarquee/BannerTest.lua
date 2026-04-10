--!Type(UI)
--!Bind
local indexLabel: UILabel = nil
--!Bind
local imageDisplay: UIImage = nil

bannerURLs = {
	[1] = "https://cdn.highrisegame.com/HRLive_Banners_Test/Coffee & Crime Banner-2 (7).png",
	[2] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image02.png",
	[3] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image03.png",
	[4] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image04.png",
	[5] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image05.png",
	[6] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image06.png",
	[7] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image07.png",
	[8] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image08.png",
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