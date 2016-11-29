//Made this for use with client/server, in an attempt to prevent repeat functions. IncludePlugins is no longer used - sportsfreak
local fil, Folders = file.Find("gamemodes/arw/gamemode/plugins/*", "GAME")
print("LOADING PLUGINS! TOTAL TO LOAD: ", table.Count(Folders))
for i,v in pairs(Folders) do
	
	local Files = file.Find("gamemodes/arw/gamemode/plugins/"..v.."/*.lua", "GAME")
	for q,w in pairs(Files) do
		if string.find(w,"sh") == 1 then
			include("plugins/"..v.."/"..w)
			AddCSLuaFile("plugins/"..v.."/"..w)
		elseif string.find(w,"sv") == 1 then
			include("plugins/"..v.."/"..w)
		elseif string.find(w,"cl") == 1 then
			AddCSLuaFile("plugins/"..v.."/"..w)
		end
	end
end