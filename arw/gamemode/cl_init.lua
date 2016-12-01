function IncludePlugins(dir)
	MsgN("Starting to include CL Plugins!");
	local fil, Folders = file.Find(dir.."*", "LUA")
	MsgN("Total: ", table.Count(Folders));
	
	for k,v in pairs(Folders)do
		if(v != "." and v != "..")then
			local Files = file.Find(dir..v.."/*.lua", "LUA");
			
			for q,w in pairs(Files) do
				include("plugins/"..v.."/"..w)
			end
		end
	end
end

include( 'shared.lua' )

// Clientside only stuff goes here

function DrawVIP( ply )
	if GetGlobalString("GameTypeSelected") == GameType[5].name then
		local dist = LocalPlayer():GetPos():Distance(EyePos())
		local dist_calc = dist / 10000
		local mathmemes = 1 + dist_calc
		local sizecalc = 255 * mathmemes
		
		if LocalPlayer() == ply then return end
		if (GetGlobalEntity("Team2VIP") == ply) or (GetGlobalEntity("Team1VIP") == ply) then
			local Head = ply:LookupBone("ValveBiped.Bip01_Head1")
			local HeadPos, HeadAng = ply:GetBonePosition(Head)
			local Pos = HeadPos + Vector(0, 0, 15)
			local eyeang = LocalPlayer():EyeAngles().y - 90 -- Face upwards
			local Ang = Angle( 0, eyeang, 90 )
			
			cam.Start3D2D(Pos + Vector(math.sin(CurTime()), 0, math.sin(CurTime()) * 2), Ang, 0.1)
				cam.IgnoreZ( true )
				
					
					
					surface.SetDrawColor(255,255,255)
					surface.SetMaterial( Material(  "materials/gui/contest-icon.png" ) ) 
					surface.DrawTexturedRect(-sizecalc / 2,-400,sizecalc,sizecalc)
					
				
					
				cam.IgnoreZ( false )
		
			cam.End3D2D()
		end
	end
end
hook.Add( "PostPlayerDraw", "DrawVIP", DrawVIP )



include("shared.lua")

MsgN("Loading Clientside Files")
for _, file in pairs(file.Find(Config["FolderName"] .. "/gamemode/client/*.lua", "LUA")) do
	MsgN("-> "..file)
	include(Config["FolderName"] .. "/gamemode/client/"..file)
end

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

IncludePlugins(Config["FolderName"] .. "/gamemode/plugins/") -- load last
