-----------------------------------------------------------------------------------------------
-- Client Lua Script for DingDong
-- Copyright (c) DoctorVanGogh on Wildstar forums - All Rights reserved
-----------------------------------------------------------------------------------------------

require "Sound"

local ktSoundRedirects = {
	--[[
		Currently we only redirect one sound - known uses: 
			challenge reward spinner -> holo window open
		From all I remember, this sounds closest to the original spinner
	]]	
	[Sound.PlayUI11To13GenericPushButtonDigital01] = Sound.PlayUIWindowHoloOpen
}

local DingDong = Apollo.GetPackage("Gemini:Addon-1.0").tPackage:NewAddon(
																	"DingDong", 
																	false, 
																	{ },
																	"Gemini:Hook-1.0")
									
								
function DingDong:OnInitialize()
	if not self:IsHooked(Sound, "Play") then
		self:RawHook(Sound, "Play")
	end
end
			

function DingDong:Play(nSoundId, ...)
	if ktSoundRedirects[nSoundId] then
		nSoundId = ktSoundRedirects[nSoundId]
	end
	self.hooks[Sound].Play(nSoundId, unpack(arg))
end			