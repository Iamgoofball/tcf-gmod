-- Build hud --
local hud_img = vgui.Create( "DImage"  )	

local ExpNeeded = 1000

local fVisualHealth = 0

local smooth = 0

function hud()

---------------------------------------------------------------
//                     EXP BAR                               \\
---------------------------------------------------------------

	local playerExp = LocalPlayer():GetNWInt("Exp")
	
	local w = 600
	local width = playerExp/ExpNeeded*(w)

	local width = math.Clamp(width, 0, w)
	smooth = math.Approach(smooth, width, 100*FrameTime())

	
	surface.SetDrawColor(255,255,255)
	surface.SetMaterial( Material(  "materials/gui/exp-background3.png" ) )
	surface.DrawTexturedRect(ScrW() / 2 - 305,15,610,30)
	
	draw.RoundedBoxEx( 0, ScrW() / 2 - 300, 20, 600, 20, Color(0,0,0), false, false, false, false ) -- background bar
	draw.RoundedBoxEx( 0, ScrW() / 2 - 300, 20, smooth, 20, Color(153,200,0), false, false, false, false ) -- Exp bar
	
	surface.SetDrawColor( 0,0,0, 100 )
	surface.SetMaterial( Material ( "vgui/gradient-u" )	) 
	surface.DrawTexturedRect( ScrW() / 2 - 300, 20, smooth + 1, 10 )
	
	
	surface.SetDrawColor(255,255,255)
	surface.SetMaterial( Material(  "materials/gui/level-background.png" ) ) 
	surface.DrawTexturedRect(ScrW() / 2 - 30,25,60,30)
	
	draw.RoundedBoxEx( 0, ScrW() / 2 - 25, 30, 50, 20, Color(102,100,0), false, false, false, false ) -- background bar
		
	draw.SimpleText(LocalPlayer():GetNWInt("Level"), "Basic_Font_Screen", ScrW() / 2, 32, Color(255,255,255), TEXT_ALIGN_CENTER)
	draw.SimpleText(LocalPlayer():GetRank(), "Basic_Font_Screen", ScrW() / 2, 55, Color(255,255,255), TEXT_ALIGN_CENTER)

---------------------------------------------------------------
//                     TIMER                                 \\
---------------------------------------------------------------

	surface.SetDrawColor(255,255,255)
	surface.SetMaterial( Material(  "materials/gui/exp-background3.png" ) )
	surface.DrawTexturedRect(20,15,200,30)
	
	if GetGlobalInt( "GameState" ) == 1 then
		
		PhaseText = "Resting"

	elseif GetGlobalInt( "GameState" ) == 2 then
		
		PhaseText = "Prep"
		
	elseif GetGlobalInt( "GameState" ) == 3 then
	
		PhaseText = "Battle!"
		
	end
	
	local timeleft = math.floor((GetGlobalInt("StateStartTime") + GetGlobalInt("StateEndTime")) - GetGlobalInt("CurrentServerRealTime"))
	
	if timeleft < 0 then
	
		timetext = "Waiting for players"
		
	else
	
		timetext = timeleft
		
	end
	
	draw.SimpleText(PhaseText.." "..timetext, "Basic_Font_Screen", 120, 20, Color(255,255,255), TEXT_ALIGN_CENTER)
	
---------------------------------------------------------------
//                     GameTypes                             \\
---------------------------------------------------------------
	-- Hardcoded shit
	-- Team Deathmatch

	if GetGlobalString("GameTypeSelected") == "Team Deathmatch" then
		
		if LocalPlayer().BurgerStamina < 100  then
			
			posi = 90

		
		else
		
			posi = 55
		end
		
		
		draw.RoundedBox( 4, ScrW() / 2 - 55, ScrH() - posi, 50, 50, Color(0,0,0,150) )

		surface.SetDrawColor(255,255,255)
		surface.SetMaterial( Material(  "materials/gui/american-icon.png" ) )
		surface.DrawTexturedRect(ScrW() / 2 - 50, ScrH() - posi + 5, 40, 40 )
		
		draw.SimpleText(GetGlobalInt("AmericanKills"), "Basic_Font_3D_Small", ScrW() / 2 - 55 + 25, ScrH() - posi + 22, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		
		draw.RoundedBox( 4, ScrW() / 2 + 5, ScrH() - posi, 50, 50, Color(0,0,0,150) )

		surface.SetDrawColor(255,255,255)
		surface.SetMaterial( Material(  "materials/gui/british-icon.png" ) )
		surface.DrawTexturedRect(ScrW() / 2 + 10, ScrH() - posi + 5, 40, 40 )
		
		draw.SimpleText(GetGlobalInt("BritishKills"), "Basic_Font_3D_Small", ScrW() / 2 + 5 + 25, ScrH() - posi + 22, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	
	elseif GetGlobalString("GameTypeSelected") == "Tea Party" then
		if LocalPlayer().BurgerStamina < 100  then
			
			posi = 90

		
		else
		
			posi = 55
		end
		draw.RoundedBox( 4, ScrW() / 2 - 25, ScrH() - posi + 5, 50, 50, Color(0,0,0,150) )

		surface.SetDrawColor(255,255,255)
		surface.SetMaterial( Material(  "materials/gui/british-icon.png" ) )
		surface.DrawTexturedRect(ScrW() / 2 - 20, ScrH() - posi + 10, 40, 40 )
		
		draw.SimpleText(GetGlobalInt("TeaCratesLeft"), "Basic_Font_3D_Small", ScrW() / 2, ScrH() - posi + 28, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	surface.SetDrawColor(255,255,255)
	surface.SetMaterial( Material(  "materials/gui/exp-background3.png" ) )
	surface.DrawTexturedRect(ScrW() - 220,15,200,30)
	draw.SimpleText(GetGlobalString("GameTypeSelected"), "Basic_Font_Screen", ScrW() - 120, 20, Color(255,255,255), TEXT_ALIGN_CENTER)

	
---------------------------------------------------------------
//                     Main Hud                              \\
---------------------------------------------------------------
	
	surface.SetDrawColor(0,0,0)
	surface.DrawRect(1, ScrH() - 75, 280, 50)
	
	fVisualHealth = Lerp(10 * FrameTime(), fVisualHealth, LocalPlayer():Health()) -- health bar
	surface.SetDrawColor(204,0,0)
	surface.DrawRect(1, ScrH() - 75, 280 * (fVisualHealth / 100), 50)
	
	surface.SetDrawColor( 250,250,250, 150 )
	surface.SetMaterial( Material ( "vgui/gradient-u" )	) -- If you use Material, cache it!
	surface.DrawTexturedRect( 1, ScrH() - 75, 280 * (fVisualHealth / 100), 10 )

	surface.SetDrawColor(255,255,255)
	surface.SetMaterial( Material(  "materials/gui/main-hud.png" ) )  --Use dir icon16/ for silkicons
	surface.DrawTexturedRect(0, ScrH()-150,350,150)
	
	--draw.RoundedBoxEx( 0, 0, ScrH()-150, 350, 150, Color(100,90,40), false, false, false, false ) -- background bar
	draw.SimpleText(LocalPlayer():Nick(), "Basic_Font_Screen", 95, ScrH() - 120, Color(255,255,255), TEXT_ALIGN_CENTER)
	draw.SimpleText("$"..LocalPlayer():GetNetworkedInt( "Money" ), "Basic_Font_Screen", 234, ScrH() - 120, Color(255,255,255), TEXT_ALIGN_CENTER)

	surface.SetDrawColor(255,255,255)
	surface.SetMaterial( Material(  "materials/gui/ticket-icon.png" ) )  --Use dir icon16/ for silkicons
	surface.DrawTexturedRect(290, ScrH()-125,30,30)
	
	draw.SimpleText(LocalPlayer():GetNetworkedInt( "Ticket" ), "default", 305, ScrH()-120, Color(255,255,255), TEXT_ALIGN_CENTER)

	
	surface.SetDrawColor(255,255,255)
	surface.SetMaterial( Material(  "materials/gui/"..team.GetName( LocalPlayer():Team() ).."-icon.png" ) )  --Use dir icon16/ for silkicons
	surface.DrawTexturedRect(ScrW() - 55, ScrH()-55,50,50)

	if LocalPlayer().is_voicechat == true then
		surface.SetDrawColor(255,255,255)
		surface.SetMaterial( Material(  "materials/gui/exp-background3.png" ) )
		surface.DrawTexturedRect(ScrW() - 220,300,200,200)
		draw.SimpleText("1 - Help!", "Basic_Font_Screen", ScrW() - 120, 300, Color(255,255,255), TEXT_ALIGN_CENTER)
		draw.SimpleText("2 - Battle Cry", "Basic_Font_Screen", ScrW() - 120, 300 + 20, Color(255,255,255), TEXT_ALIGN_CENTER)
		draw.SimpleText("3 - Cheers", "Basic_Font_Screen", ScrW() - 120, 300 + 40, Color(255,255,255), TEXT_ALIGN_CENTER)
		draw.SimpleText("4 - Jeers", "Basic_Font_Screen", ScrW() - 120, 300 + 60, Color(255,255,255), TEXT_ALIGN_CENTER)
		draw.SimpleText("5 - Thanks", "Basic_Font_Screen", ScrW() - 120, 300 + 80, Color(255,255,255), TEXT_ALIGN_CENTER)
		draw.SimpleText("6 - Go Go Go!", "Basic_Font_Screen", ScrW() - 120, 300 + 100, Color(255,255,255), TEXT_ALIGN_CENTER)
		draw.SimpleText("7 - Yes", "Basic_Font_Screen", ScrW() - 120, 300 + 120, Color(255,255,255), TEXT_ALIGN_CENTER)
		draw.SimpleText("8 - No", "Basic_Font_Screen", ScrW() - 120, 300 + 140, Color(255,255,255), TEXT_ALIGN_CENTER)
		draw.SimpleText("9 - Objective", "Basic_Font_Screen", ScrW() - 120, 300 + 160, Color(255,255,255), TEXT_ALIGN_CENTER)
		draw.SimpleText("0 - Close", "Basic_Font_Screen", ScrW() - 120, 300 + 180, Color(255,255,255), TEXT_ALIGN_CENTER)
	end
end
hook.Add("HUDPaint", "WeedHud", hud) 

-- Hide hud --
function hidehud(name)
	for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"}) do
		if name == v then return false end
	end
end
hook.Add("HUDShouldDraw", "HideDefaultHud", hidehud)

hook.Add("HUDDrawTargetID", "HideNameHP", function() return false end)


