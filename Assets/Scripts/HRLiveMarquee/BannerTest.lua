--!Type(UI)
--!Bind
local indexLabel: UILabel = nil
--!Bind
local imageDisplay: UIImage = nil

bannerURLs = {
	[1] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image01.png",
	[2] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image02.png",
	[3] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image03.png",
	[4] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image04.png",
	[5] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image05.png",
	[6] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image06.png",
	[7] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image07.png",
	[8] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image08.png",
	[9] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image09.png",
	[10] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image10.png",
	[11] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image11.png",
	[12] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image12.png",
	[13] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image13.png",
	[14] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image14.png",
	[15] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image15.png",
	[16] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image16.png",
	[17] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image17.png",
	[18] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image18.png",
	[19] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image19.png",
	[20] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image20.png",
	[21] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image21.png",
	[22] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image22.png",
	[23] = "https://cdn.highrisegame.com/HRLiveBanners_WO_07.21.2025/Image23.png",
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