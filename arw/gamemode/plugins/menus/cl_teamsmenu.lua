function teammenu()

	if GetGlobalInt( "GameState" ) == 2 or GetGlobalInt( "GameState" ) == 3 then 	
		GAMEMODE:AddNotify("You cannot change teams at this time.", NOTIFY_GENERIC, 5)
		return 
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
	Americanicon:SetModel( "models/kriegsyntax/awoi/rebels/private/playermodel.mdl" ) 
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
	Britishicon:SetModel( "models/kriegsyntax/awoi/british/private/playermodel.mdl" ) 
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

