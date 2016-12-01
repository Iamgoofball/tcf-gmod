function teammenu()

	if GetGlobalInt( "GameState" ) == 2 or GetGlobalInt( "GameState" ) == 3 then 
		if LocalPlayer():Team() == 2 or LocalPlayer():Team() == 3 then
			GAMEMODE:AddNotify("You cannot change teams at this time.", NOTIFY_GENERIC, 5)
			return
		end
		
	end
	
	
	local Menu = vgui.Create( "DFrame" )
	Menu:SetSize(1000, 800);
	Menu:Center()
	Menu:SetTitle(" ");
	Menu:ShowCloseButton( false )
	Menu:SetVisible( true )
	Menu:SetDraggable( false )
	Menu:MakePopup()
	
	
	function Menu:Paint()
		
		draw.SimpleText( "Choose Sides", "Basic_Font_3D", self:GetWide() / 2 , 100, Color( 255,255,255,startAlpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		
		surface.SetDrawColor(255,255,255)
		surface.SetMaterial( Material(  "materials/gui/scroll-menu.png" ) )
		surface.DrawTexturedRect(0,0,self:GetWide(),self:GetTall())
		
	end

	local Americanicon = vgui.Create( "DModelPanel", Menu )
	Americanicon:SetPos( 100, 200 )
	Americanicon:SetSize( 350, 400 )
	Americanicon:SetModel( Rank[Config["Team1PrettyName"] .. "-Private"] ) 
	function Americanicon:LayoutEntity( Entity ) return end 
	function Americanicon.Entity:GetPlayerColor() return Vector ( 1, 0, 0 ) end 
	
	function Americanicon:DoClick()
		if #team.GetPlayers( 2 ) > #team.GetPlayers( 3 ) then return end
		net.Start( "SetTeam" )
		net.WriteUInt( 2, 8 ) 
		net.SendToServer()
		
		Menu:Close()
		
	end
	
	function Americanicon:PaintOver()
		
		if #team.GetPlayers( 2 ) > #team.GetPlayers( 3 ) then
			
			surface.SetDrawColor(255,255,255)
			surface.SetMaterial( Material(  "materials/gui/banner2.png" ) )
			surface.DrawTexturedRect(0, self:GetTall() / 2 - 50, 350, 150)
			
			draw.SimpleText( "Full", "Basic_Font_3D", self:GetWide() / 2 , self:GetTall() / 2 + 22, Color( 255,255,255,startAlpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		
	end
	
	local Britishicon = vgui.Create( "DModelPanel", Menu )
	Britishicon:SetPos( Menu:GetWide() - 450, 200 )
	Britishicon:SetSize( 350, 400 )
	Britishicon:SetModel( Rank[Config["Team2PrettyName"] .. "-Private"] ) 
	function Britishicon:LayoutEntity( Entity ) return end 
	function Britishicon.Entity:GetPlayerColor() return Vector ( 1, 0, 0 ) end 
	
	function Britishicon:DoClick()
		if #team.GetPlayers( 3 ) > #team.GetPlayers( 2 ) then return end
		net.Start( "SetTeam" )
		net.WriteUInt( 3, 8 ) 
		net.SendToServer()
		
		Menu:Close()
		
	end
	
	function Britishicon:PaintOver()
		
		if #team.GetPlayers( 3 ) > #team.GetPlayers( 2 ) then
		
			surface.SetDrawColor(255,255,255)
			surface.SetMaterial( Material(  "materials/gui/banner2.png" ) )
			surface.DrawTexturedRect(0, self:GetTall() / 2 - 50, 350, 150)
			
			draw.SimpleText( "Full", "Basic_Font_3D", self:GetWide() / 2 , self:GetTall() / 2 + 22, Color( 255,255,255,startAlpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		
	end

end
net.Receive( 'open_teammenu', teammenu )

local function TeamMenuBackground( ply, pos, angles, fov )
	if LocalPlayer():Team() != 1 then return end
	local view = {}

	view.origin = Vector(121.603180, -2636.916992, 537.893677)-( angles:Forward()*100 )
	view.angles = angles
	view.fov = fov
	view.drawviewer = true

	return view
end

hook.Add( "CalcView", "TeamMenuBackground", TeamMenuBackground )

function tutorialmenu()
	
	local w, h = 800,200
	local page = 1
	local MainPanel = vgui.Create( "DFrame" )
	MainPanel:SetPos(ScrW() / 2 - w / 2, ScrH())
	MainPanel:MoveTo( ScrW() / 2 - w / 2, ScrH() - 300 - h / 2, 1, 0, 0.1)
	MainPanel:SetTitle(" ")
	MainPanel:ShowCloseButton( false )
	MainPanel:SetVisible( true )
	MainPanel:SetDraggable( false )
	MainPanel:MakePopup()
	MainPanel:SetSize( w, h ) 

	local DScrollPanel = vgui.Create( "DScrollPanel", MainPanel )
	DScrollPanel:SetSize( w - 20, h - 20 )
	DScrollPanel:SetPos( 10, 10 )
	
	function MainPanel:Paint()
		
		surface.SetDrawColor(255,255,255)
		surface.SetMaterial( Material(  "materials/gui/exp-background3.png" ) ) 
		surface.DrawTexturedRect(0,0,w,h)
		--draw.SimpleTextOutlined("Hello "..LocalPlayer():Nick()..", I see you are new to the regiment.\n I am Commander Stinky Nuts.", "NamePanelFont", 10, 50, Color(255, 255, 255, 150), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 150))
	end
	

	-- Scrollbar styling --
	local sbar = DScrollPanel:GetVBar()
	function sbar:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
	end
	function sbar.btnUp:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w-1, h, Color( 200, 100, 0 ) )
	end
	function sbar.btnDown:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w-1, h, Color( 200, 100, 0 ) )
	end
	function sbar.btnGrip:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w-1, h, Color( 100, 200, 0 ) )
	end
			
	-- Description --
	local DLabel = vgui.Create( "DLabel", DScrollPanel )
	DLabel:SetFont("NamePanelFont")
	DLabel:SetColor( Color(255,255,255) )
	DLabel:SetPos( 5, 30 )
	DLabel:SizeToContents()
	function DLabel:Paint()
		if page == 1 then
			DLabel:SetText( "Hello, I see you are new to the regiment.\nI am Commander George Washington." )
		elseif page == 2 then
			DLabel:SetText( "Welcome to the Revolutionary War!\nThe American Rebels fight against the British Empire\nfor independence!" )
		elseif page == 3 then
			DLabel:SetText( "After finishing this tutorial, you may pick a side in the battle!\nDuring the Rest phase is the only time you can\nswitch teams with F1." )
		elseif page == 4 then
			DLabel:SetText( "To start off, the game runs in 3 different phases.\nThe phases are as follows: Rest, Prep, and Battle!" )
		elseif page == 5 then
			DLabel:SetText( "During the Rest phase, the teams are in their bases.\nUse this time to plan and strategize!" )
		elseif page == 6 then
			DLabel:SetText( "During the Prep phase, the teams are in the loadout menu.\nYou can also vote on the Round-Type with Tickets!" )
		elseif page == 7 then
			DLabel:SetText( "During the Battle phase, the teams are on the field\ncompleting their objectives.\nPay attention to the notifications in the bottom right!" )
		elseif page == 8 then
			DLabel:SetText( "Winning battles and accomplishing objectives gets you\nMoney, Experience, and Tickets.\nUse experience to level up and get new guns!\nUse Tickets to vote on gamemodes!" )
		elseif page == 9 then
			DLabel:SetText( "Congratulations, you're ready for combat!\nNow get out there and shoot some redcoats!" )
		end
		DLabel:SizeToContents()
	end
	function DScrollPanel:Paint()

		
		--draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 244,244,244 ) ) -- background
		draw.RoundedBox( 0, 0, 0, self:GetWide(), 10, Color( 153,0,0,250 ) ) -- bar
		
		draw.RoundedBox( 0, 0, 10, self:GetWide(), 5, Color( 103,0,0,250 ) ) -- bar shadow
		
		
		surface.SetDrawColor(0,0,0) -- frame outline
		surface.DrawOutlinedRect(0,0,self:GetWide(),self:GetTall())

		surface.SetDrawColor(255,255,255)
		surface.SetMaterial( Material(  "materials/gui/notification-leader.png" ) ) 
		surface.DrawTexturedRect(730, 120 ,50,50)
	end


	
	local Close = vgui.Create( "DButton", MainPanel )
	Close:SetPos(w - 55, -5)
	Close:SetSize( 50, 50 ) 
	Close:SetText(">")
	
	function Close:Paint()
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	end
	
	function Close.DoClick() 
		if page != 9 then
			page = page + 1
			if page == 9 then
				Close:SetText("X")
			end
			DLabel:Paint()
		else
			MainPanel:Close()
			teammenu()
		end
	end
	


	
end
net.Receive( 'open_tutorial', tutorialmenu )
