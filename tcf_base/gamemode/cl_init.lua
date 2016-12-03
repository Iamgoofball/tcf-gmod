include( 'shared.lua' )

hook.Add( "PreDrawHalos", "VIPHalos", function()
	if GetGlobalString("GameTypeSelected") == GameType[5].name then
		local green_shit = {}
		local red_shit = {}
		for fuck, shit in pairs( players.GetAll() ) do
			if GetGlobalEntity("Team2VIP") == shit or GetGlobalEntity("Team1VIP") == shit then
				if shit:Team() == LocalPlayer():Team() then
					table.insert( green_shit, shit)
				else
					table.insert( red_shit, shit)
				end
			end
		end
		halo.Add( green_shit, Color( 0, 255, 0 ), 0, 0, 1, true, true)
		halo.Add( red_shit, Color( 255, 0, 0 ), 0, 0, 1, true, true)
	end
end )

surface.CreateFont( "Basic_Font_Screen", {
	font 		= "Arial",
	size 		= 18,
	weight 		= 700,
	antialias 	= true,
	prettyblur = 1,
})
surface.CreateFont( "Basic_Font_Tiny", {
	font 		= "Verdana",
	size 		= 18,
	weight 		= 1000,
	antialias 	= true,
	prettyblur = 1,
})
surface.CreateFont( "Basic_Font", {
	font 		= "Verdana",
	size 		= 16,
	weight 		= 100,
	antialias 	= true,
	prettyblur = 1,
})
surface.CreateFont( "Observation_Font", {
	font 		= "Roboto",
	size 		= 25,
	weight 		= 100,
	antialias 	= true,
	prettyblur = 1,
})
surface.CreateFont( "Basic_Font_Big", {
	font 		= "Verdana",
	size 		= 32,
	weight 		= 1000,
	antialias 	= true,
	prettyblur = 1,
})
surface.CreateFont( "Basic_Font_3D", {
	font 		= "Verdana",
	size 		= 68,
	weight 		= 400,
	antialias 	= true,
	prettyblur = 1,
})
surface.CreateFont( "Basic_Font_3D_Small", {
	font 		= "Verdana",
	size 		= 55,
	weight 		= 400,
	antialias 	= true,
	prettyblur = 1,
})
local tab = {
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = 0,
	["$pp_colour_contrast"] = 1.25,
	["$pp_colour_colour"] = 1,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0
}
hook.Add( "RenderScreenspaceEffects", "dildo_mcnugget", function()
	DrawColorModify( tab ) --Draws Color Modify effect
	RunConsoleCommand("pp_bokeh", "1")
	RunConsoleCommand("pp_bokeh_blur", "0.640000")
	RunConsoleCommand("pp_bokeh_distance", "0")
	RunConsoleCommand("pp_bokeh_focus", "24")
	RunConsoleCommand("pp_vignette", "1")
	RunConsoleCommand("pp_vignette_constant", "1")
	RunConsoleCommand("pp_vignette_passes", "1")
end )

MsgN("Loading Clientside Files")
for _, file in pairs(file.Find(Config["FolderName"] .. "/gamemode/client/*.lua", "LUA")) do
	MsgN("-> "..file)
	include(Config["FolderName"] .. "/gamemode/client/"..file)
end

MsgN("Loading Shared Files")
for _, file in pairs(file.Find(Config["FolderName"] .. "/gamemode/shared/*.lua", "LUA")) do
	MsgN("-> "..file)
	include(Config["FolderName"] .. "/gamemode/shared/"..file)
end
