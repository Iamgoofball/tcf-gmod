surface.CreateFont( "Gun_Text", {
	font 		= "Verdana",
	size 		= 30,
	weight 		= 400,
	antialias 	= true,
	prettyblur = 1,
})

concommand.Add( "loadout", function()
	
	local w, h = 600,450
	local smooth = 30
	
	local page = 1
	
	local MainPanel = vgui.Create( "DFrame" )
	MainPanel:SetPos(ScrW() / 2 - w / 2, ScrH() / 2 - h / 2)
	MainPanel:SetTitle(" ")
	MainPanel:ShowCloseButton( false )
	MainPanel:SetVisible( true )
	MainPanel:SetDraggable( false )
	MainPanel:MakePopup()
	MainPanel:SetSize( w, h ) 
	
	function MainPanel:Paint()
		
		local Timeleft = math.floor((GetGlobalInt("StateStartTime") + GetGlobalInt("StateEndTime")) - GetGlobalInt("CurrentServerRealTime"))
	
		local wi = 588
		local width = Timeleft/30*(wi)
		local width = math.Clamp(width, 0, wi)
		smooth = math.Approach(smooth, width, 25*FrameTime())
		
		surface.SetDrawColor(255,255,255)
		surface.SetMaterial( Material(  "materials/gui/menu-background.png" ) ) 
		surface.DrawTexturedRect(0,0,w,h)
		
		-------------------------------------------------------
		// Pages \\
		-------------------------------------------------------
		
		surface.SetDrawColor(255,255,255) -- primary
		surface.SetMaterial( Material(  "materials/gui/menu-button3.png" ) ) 
		surface.DrawTexturedRect(5,0,194,50)
		
		if page > 1 then
		
			surface.SetDrawColor(255,255,255) 
			surface.SetMaterial( Material(  "icon16/accept.png" ) ) 
			surface.DrawTexturedRect(10,5,20,20)
		
		end
		
		draw.SimpleText("Rifle", "Basic_Font_Big", 97 + 5, 25, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		surface.SetDrawColor(255,255,255) -- secondary
		surface.SetMaterial( Material(  "materials/gui/menu-button3.png" ) ) 
		surface.DrawTexturedRect(203,0,194,50)
		
		if page >
		2 then
		
			surface.SetDrawColor(255,255,255) 
			surface.SetMaterial( Material(  "icon16/accept.png" ) ) 
			surface.DrawTexturedRect(9 + 199,5,20,20)
		
		end
		
		draw.SimpleText("Secondary", "Basic_Font_Big", 96 + 204, 25, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		
		surface.SetDrawColor(255,255,255) -- voting
		surface.SetMaterial( Material(  "materials/gui/menu-button3.png" ) ) 
		surface.DrawTexturedRect(401,0,194,50)
		
		draw.SimpleText("Voting", "Basic_Font_Big", 97 + 401, 25, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		
		
		-------------------------------------------------------
		// Timer \\
		-------------------------------------------------------
		surface.SetDrawColor( 198, 198, 53, 255 ) -- background
		surface.DrawRect( 4, h - 21, w - 8, 16 )
		
		surface.SetDrawColor( 0, 0, 0, 255 ) -- bar
		surface.DrawRect( 6, h - 18, 588, 10 )
		
		surface.SetDrawColor( 255, 0, 0, 255 ) -- bar
		surface.DrawRect( 6, h - 18, width, 10 )
		
		surface.SetDrawColor( 0, 255, 0, 255 ) -- timer block
		surface.DrawRect( 6 + 197, h - 18, 10, 10 )
		
		surface.SetDrawColor( 0, 255, 0, 255 ) -- timer block
		surface.DrawRect( 6 + 197 + 197, h - 18, 10, 10 )
		
		
	end
	
	function MainPanel:Think() 
	
		local Timeleft = math.floor((GetGlobalInt("StateStartTime") + GetGlobalInt("StateEndTime")) - GetGlobalInt("CurrentServerRealTime"))

		if Timeleft == 20 && page == 1 then
			page = 2
			WeaponRefresh(2)
		elseif Timeleft == 10 && page == 2 then
			page = 3
			WeaponRefresh(3)
		elseif Timeleft == 0 then
			page = 1
			MainPanel:Close()
		end
		
	end

	
	--[[local devclose = vgui.Create( "DButton", MainPanel )
	devclose:SetPos( w - 55, h - 50 )
	devclose:SetText( "x" )
	devclose:SetSize( 50, 50 )
	devclose.DoClick = function()
		MainPanel:Close()
	end]]--
	
	WeaponList = vgui.Create("DPanelList", MainPanel)
	WeaponList:SetPos(0, 55)
	WeaponList:SetSize(w, h - 115)
	WeaponList:SetSpacing(4)
	WeaponList:SetPadding(4)
	WeaponList:EnableVerticalScrollbar(true)
	WeaponList:EnableHorizontal(true)
	
	function WeaponRefresh(arg)
	
		if WeaponList:IsValid() then WeaponList:Clear() end
		
		--local delay = .1
		
		for i=1,#Weapons do 
		
			--timer.Simple(i*delay,function()
				
				if Weapons[i].weptype == arg && Weapons[i].team == LocalPlayer():Team() then 
					
					local MainWeaponPanel = vgui.Create("DPanel")
					MainWeaponPanel:SetSize(528, 60)
					MainWeaponPanel.Paint = function()
						
						draw.RoundedBox(0, 0, 0, MainWeaponPanel:GetWide(), MainWeaponPanel:GetTall(), Color(37, 37, 39, 255))
						
						--[[surface.SetDrawColor(255,255,255)
						surface.SetMaterial( Material(  "materials/gui/exp-background.png" ) ) 
						surface.DrawTexturedRect(0,0,MainWeaponPanel:GetWide(),MainWeaponPanel:GetTall())]]
						
						draw.SimpleText(Weapons[i].display, "Gun_Text", 61, 30, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
					
					
				end
				
				local wepicon = vgui.Create("DModelPanel", MainWeaponPanel)
				wepicon:SetPos( 4, 4 )
				wepicon:SetSize(52, 52)
				wepicon:SetModel(Weapons[i].model)
				
				wepicon:SetDirectionalLight( BOX_RIGHT, Color( 255, 255, 255 ) )

				-- Thanks Neth https://facepunch.com/showthread.php?t=1440586
				local mn, mx = wepicon.Entity:GetRenderBounds()
				local size = 0
				size = math.max( size, math.abs(mn.x) + math.abs(mx.x) )
				size = math.max( size, math.abs(mn.y) + math.abs(mx.y) )
				size = math.max( size, math.abs(mn.z) + math.abs(mx.z) )

				wepicon:SetFOV( 30 )

				wepicon:SetCamPos( Vector( size, size, size ) )
				wepicon:SetLookAt( (mn + mx) * 0.5 )
				
				wepicon.LayoutEntity = function()
					
				end
				
				if Weapons[i].level <= tonumber(LocalPlayer():GetLevel()) then
				
					function wepicon:PaintOver()
					
						if wepicon:IsHovered() then
						
							draw.OutlinedBox( 0, 0, self:GetWide(), self:GetTall(), 1, Color(200,1,9) )
			
						end
						
					end
					
					wepicon.DoClick = function()
						
						page = page + 1
						
						if page < 3 then
						
							WeaponList:Clear()
							
							WeaponRefresh(page)
							
						else
						
							WeaponList:Clear()
							
							VotingList = vgui.Create("DPanelList", MainPanel)
							
							VotingList:SetPos(0, 55)
							VotingList:SetSize(w, h - 115)
							VotingList:SetSpacing(5)
							VotingList:SetPadding(5)
							--VotingList:EnableVerticalScrollbar(true)
							VotingList:EnableHorizontal(true)
							
							for i=1,#GameType do
							
								local GameTypeOption = vgui.Create("DPanel")
								GameTypeOption:SetSize(143.75, 168.75)
								
								GameTypeOption.Paint = function()
									
									draw.RoundedBox(4, 0, 0, GameTypeOption:GetWide(), 143.75, Color(0, 0, 0, 150))
									
									surface.SetDrawColor(255,255,255)
									surface.SetMaterial( Material(  "materials/gui/ticket-icon.png" ) ) 
									surface.DrawTexturedRect(GameTypeOption:GetWide() / 2 - 30,GameTypeOption:GetTall() - 20,15,15)
									
									draw.SimpleText(GetGlobalInt( "GameType"..i.."votes", 0 ), "default", GameTypeOption:GetWide() / 2, GameTypeOption:GetTall() - 15, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

									
								end

								local DButton = vgui.Create( "DButton", GameTypeOption )
								DButton:SetPos( 4, 4 )
								DButton:SetText( " " )
								DButton:SetSize( 143.75 - 8, 143.75 - 8 )
								
								DButton.DoClick = function()
									net.Start( "SendVote" )
										net.WriteUInt( i, 8 )
									net.SendToServer()
								end
								
								DButton.Paint = function()
									surface.SetDrawColor(255,255,255)
									surface.SetMaterial( Material(  GameType[i].icon ) ) 
									surface.DrawTexturedRect(0,0,DButton:GetWide(),DButton:GetTall())
								end
								
								DButton:SetTooltipPanel( true )
								DButton:SetToolTip(GameType[i].name)
								
							
								VotingList:AddItem(GameTypeOption)
							
							end

							
						end
						
						net.Start( "SetLoadoutWeapon" )
						net.WriteUInt( Weapons[i].weptype, 8 )
						net.WriteString( Weapons[i].entname, 32 )
						net.SendToServer()
						
						
					end
					
				else
				
					local locked = vgui.Create( "DImage", MainWeaponPanel )	
					locked:SetPos( 4, 4 )	
					locked:SetSize( 52, 52 )
					locked:SetImage( "scripted/breen_fakemonitor_1" )
					
					function locked:PaintOver()
						draw.SimpleText("Locked", "Basic_Font", self:GetWide() / 2, self:GetTall() / 2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					end
					
					wepicon:SetCursor( "arrow" )

				end
				
				local WeaponStatsPanel = vgui.Create("DPanel")
				WeaponStatsPanel:SetSize(60, 60)
				WeaponStatsPanel:SetTooltipPanel( true )
				WeaponStatsPanel:SetToolTip(" Damage\n Accuracy\n Firerate")
				WeaponStatsPanel.Paint = function()
					draw.RoundedBox(0, 0, 0, WeaponStatsPanel:GetWide(), WeaponStatsPanel:GetTall(), Color(37, 37, 39, 255))
					
					local wi = 40
					
					--damage
					draw.RoundedBox(0, 4, 5, WeaponStatsPanel:GetWide() - 8, 13, Color(100, 100, 39, 255))
					draw.RoundedBox(0, 6, 7, WeaponStatsPanel:GetWide() - 12, 9, Color(50, 37, 39, 255))
					
					local width = Weapons[i].damage/10*(wi)
					local width = math.Clamp(width, 0, wi)
					
					draw.RoundedBox(0, 6, 7, width, 9, Color(255, 37, 39, 255))
					
					--accuracy
					draw.RoundedBox(0, 4, 23, WeaponStatsPanel:GetWide() - 8, 13, Color(100, 100, 39, 255))
					draw.RoundedBox(0, 6, 25, WeaponStatsPanel:GetWide() - 12, 9, Color(50, 37, 39, 255))
					
					local width = Weapons[i].accuracy/10*(wi)
					local width = math.Clamp(width, 0, wi)
					
					draw.RoundedBox(0, 6, 25, width, 9, Color(255, 37, 39, 255))
					
					--Fire rate
					draw.RoundedBox(0, 4, 41, WeaponStatsPanel:GetWide() - 8, 13, Color(100, 100, 39, 255))
					draw.RoundedBox(0, 6, 43, WeaponStatsPanel:GetWide() - 12, 9, Color(50, 37, 39, 255))
					
					local width = Weapons[i].firerate/10*(wi)
					local width = math.Clamp(width, 0, wi)
					
					draw.RoundedBox(0, 6, 43, width, 9, Color(255, 37, 39, 255))
					
				end
				
				WeaponList:AddItem(MainWeaponPanel)
				WeaponList:AddItem(WeaponStatsPanel)
				
			end
						
		end
		
	end		
	WeaponRefresh(1)
end )
