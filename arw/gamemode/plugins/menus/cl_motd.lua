

concommand.Add( "motdpls", function()

	local w, h = 1500,800
	
	local MainPanel = vgui.Create( "DFrame" )
	MainPanel:SetPos(ScrW() / 2 - w / 2, ScrH() / 2 - h / 2)
	MainPanel:SetTitle(" ")
	MainPanel:ShowCloseButton( false )
	MainPanel:SetVisible( true )
	MainPanel:SetDraggable( false )
	MainPanel:MakePopup()
	MainPanel:SetSize( w, h ) 
	
	function MainPanel:Paint()
	
		surface.SetDrawColor( 255, 178, 102, 255 )
		surface.DrawRect( 0, 55, w, h - 55 )
		
		surface.SetDrawColor( 255, 178, 102, 255 )
		surface.DrawRect( 0, 0, 193.75 * #pages + 5 * #pages + 5, 60 )

	end
	
	pages = {}
	
	pages[1] = { name="Rules", click = function() print("sup") end, site = "http://steamcommunity.com/groups/electricmangocommunity/discussions/0/154641879457215943/" }
	pages[2] = { name="Change Log", click = function() end, site = "http://steamcommunity.com/groups/electricmangocommunity/discussions/2/154641879457228569/" }
	pages[3] = { name="Donate", click = function() end, site = "http://us5.mirror.gmchosting.garrysmod.co/192.99.239.62_27015/donate.html" }
	pages[4] = { name="Close", click = function() MainPanel:Close() end }
	
	
	local SitePanel = vgui.Create("DPanel", MainPanel)
	SitePanel:SetPos( 5, 60 )
	SitePanel:SetSize( w - 10, h - 65 )
	
	function SitePanel:Paint()
		
		surface.SetDrawColor( 0, 0, 0, 255 )
		surface.DrawRect( 0, 0, self:GetWide() , self:GetTall() )
	
	end
	
	Site = vgui.Create( "HTML", SitePanel )
	Site:Dock( FILL )
	Site:OpenURL( pages[1].site )
	
	PageList = vgui.Create("DPanelList", MainPanel)
	PageList:SetPos(0, 0)
	PageList:SetSize(w, 60)
	PageList:SetSpacing(5)
	PageList:SetPadding(5)
	PageList:EnableVerticalScrollbar(false)
	PageList:EnableHorizontal(true)
	
	for i=1,#pages do
	
		local PageButtonBG = vgui.Create("DPanel")
		PageButtonBG:SetSize(193.75, 50)
		
		local PageButton = vgui.Create( "DButton", PageButtonBG )
		PageButton:SetPos( 0, 0 )
		PageButton:SetText( " " )
		PageButton:SetSize( PageButtonBG:GetWide(), PageButtonBG:GetTall() )
		
		PageButton.DoClick = function()
		
			pages[i].click()
			
			if pages[i].site != nil then
				
				--if Site:IsValid() != nil then Site:Remove() end
				
				Site = vgui.Create( "HTML", SitePanel )
				Site:Dock( FILL )
				Site:OpenURL( pages[i].site )
				
			elseif Site:IsValid() then
				Site:Remove()
			end
			
		end
		
		function PageButton:Paint()
			
			surface.SetDrawColor(255,255,255) 
			surface.SetMaterial( Material(  "materials/gui/menu-button3.png" ) ) 
			surface.DrawTexturedRect(0,0,self:GetWide(),self:GetTall())
		
			draw.SimpleText(pages[i].name, "Basic_Font_Big", self:GetWide() / 2, self:GetTall() / 2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			
		end
		
		PageList:AddItem(PageButtonBG)
	
	end
	
end )