
local x = ScrW()
local y = ScrH()

-- Scoreboard --
surface.CreateFont( "ScoreboardFont", {
	font = "Tehoma",
	size = 15,
	weight = 600,
	antialias = true,
})
surface.CreateFont( "ScoreboardInfo", {
	font = "Roboto",
	size = 25,
	weight = 600,
	antialias = true,
})

local alpha = 0

function GM:ScoreboardShow()
	self.ShowScoreBoard = true
end

function GM:ScoreboardHide()
	self.ShowScoreBoard = false
	alpha = 0
end

function GM:GetTeamScoreInfo()
	local TeamInfo = {}
	
	for _, ply in pairs( player.GetAll() ) do
		local _team = ply:Team()
		--local _deaths = ply:Deaths()
		local _ping = ply:Ping()
		local _Name = ply:Nick()
		local _xp = ply:GetNWInt("Level")
		
		if (not TeamInfo[_team]) then
			TeamInfo[_team] = {}
			TeamInfo[_team].TeamName = team.GetName( _team )
			TeamInfo[_team].Color = team.GetColor( _team )
			TeamInfo[_team].Players = {}
		end		
		
		local PlayerInfo = {}
		--PlayerInfo.Deaths = _deaths
		PlayerInfo.Ping = _ping
		PlayerInfo.Name = _Name
		PlayerInfo.PlayerObj = ply
		PlayerInfo.xp = _xp
		PlayerInfo.Deaths = ply:Deaths()
		PlayerInfo.Color = team.GetColor( _team )
		
		local insertPos = #TeamInfo[_team].Players + 1
		for idx, info in pairs(TeamInfo[_team].Players) do
			--[[if (PlayerInfo.Deaths < info.Deaths) then
				insertPos = idx
				break
			elseif (PlayerInfo.Deaths == info.Deaths) then
				if (PlayerInfo.Name < info.Name) then
					insertPos = idx
					break
				end
			end]]
		end
		
		table.insert(TeamInfo[_team].Players, insertPos, PlayerInfo)
	end
	
	return TeamInfo
end

function GM:HUDDrawScoreBoard()

	if not self.ShowScoreBoard then return end
	
	local opac = 255
	if self.ScoreDesign == nil then
		self.ScoreDesign = {}
		self.ScoreDesign.HeaderY = 0
		self.ScoreDesign.Height = ScrH() / 2
	end
	
	if !(alpha >= 255) then
		alpha = alpha + 9
	end

	local ScoreboardInfo = self:GetTeamScoreInfo()
	
	local xOffset = x * 0.15
	local yOffset = 32
	local scrWidth = x
	local scrHeight = 1
	local boardWidth = scrWidth - (2 * xOffset)
	local boardHeight = scrHeight
	local colWidth = 75

	local ScoreboardFont = "ScoreboardFont"
	local ScoreboardInfoFont = "ScoreboardInfo"
	
	boardWidth = math.Clamp(boardWidth, 400, 600)
	boardHeight = self.ScoreDesign.Height
	
	xOffset = (ScrW() - boardWidth) / 2.0
	yOffset = (ScrH() - boardHeight) / 2.0
	yOffset = yOffset - ScrH() / 4.0
	yOffset = math.Clamp( yOffset, 32, ScrH() )

	-- Background
	local blur = Material("pp/blurscreen")
	local function DrawBlurRect(x, y, w, h)
		local X, Y = 0,0

		surface.SetDrawColor(255,255,255)
		surface.SetMaterial(blur)

		for i = 1, 5 do
			blur:SetFloat("$blur", (i / 3) * (5))
			blur:Recompute()

			render.UpdateScreenEffectTexture()

			render.SetScissorRect(x, y, x+w, y+h, true)
				surface.DrawTexturedRect(X * -1, Y * -1, ScrW(), ScrH())
			render.SetScissorRect(0, 0, 0, 0, false)
		end
	   
	   draw.RoundedBox(0,x,y,w,h,Color(0,0,0,10 + alpha - 55))
	   surface.SetDrawColor(0,0,0)
	   surface.DrawOutlinedRect(x,y,w,h)
	   
	end

    DrawBlurRect( 0, 0, ScrW(), ScrH(), 1)

	--draw.RoundedBox(0, 0, 0, x, y, Color(0, 0, 0, 150))
	
	-- Header
	--surface.SetDrawColor( 56,175,148,alpha )
	--surface.DrawRect( xOffset, yOffset + 28, boardWidth, 5 )
	
	surface.SetDrawColor(255,255,255, alpha)
	surface.SetMaterial( Material(  "materials/gui/exp-background3.png" ) )
	surface.DrawTexturedRect(xOffset, yOffset, boardWidth, self.ScoreDesign.HeaderY)	
	
	--surface.SetDrawColor( 53,190,163,alpha )
	--surface.DrawRect( xOffset, yOffset -5, boardWidth, self.ScoreDesign.HeaderY )
	--draw.RoundedBoxEx(6, xOffset, yOffset, boardWidth, self.ScoreDesign.HeaderY, Color(24, 24, 24, 255), true, true, false, false)
	--draw.RoundedBoxEx(6, xOffset, yOffset + 30, boardWidth, self.ScoreDesign.Height - 25, Color(240, 240, 240, 255), false, false, true, true)
	-- Header text
	local ySpacing = yOffset + 25
	draw.SimpleTextOutlined( GetGlobalString("ServerName"), ScoreboardFont, xOffset + boardWidth * 0.5, ySpacing - 10, Color(255,255,255,alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0.5, Color(60,60,60,120) )
	ySpacing = ySpacing + 8
	self.ScoreDesign.HeaderY = ySpacing - yOffset
	ySpacing = ySpacing + 2

	-- Titles
	draw.SimpleText("Name", ScoreboardFont, xOffset + 60, ySpacing - 10, Color(255,255,255,120), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0.5, Color(255,255,255,120))
	draw.SimpleText("Level", ScoreboardFont, xOffset + boardWidth - (colWidth*3) + 20, ySpacing - 9, Color(255,255,255,120), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0.5, Color(255,255,255,120))
	draw.SimpleText("Deaths", ScoreboardFont, xOffset + boardWidth - (colWidth*2) + 20, ySpacing - 9, Color(255,255,255,120), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0.5, Color(255,255,255,120))
	draw.SimpleText("Ping", ScoreboardFont, xOffset + boardWidth - (colWidth*1) + 20, ySpacing - 9, Color(255,255,255,120), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0.5, Color(255,255,255,120))

	ySpacing = ySpacing + 3

	local yPosition = ySpacing
	for team,info in pairs(ScoreboardInfo) do
		--[[local teamText = info.TeamName .. "  (" .. #info.Players .. " Players)"
		
		draw.RoundedBox(0, xOffset, yPosition, boardWidth, 19, Color(info.Color.r, info.Color.g, info.Color.b, 255))
		
		yPosition = yPosition + 2
		
		draw.SimpleText(teamText, ScoreboardFont, xOffset, yPosition, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)]]

		yPosition = yPosition + 0
		
		for index, plinfo in pairs(info.Players) do
					
			
			draw.RoundedBox(0, xOffset, yPosition, 30, 30, plinfo.Color)
			draw.RoundedBox(0, xOffset + 32, yPosition, boardWidth - 32, 30, plinfo.Color)
			draw.RoundedBox(0, xOffset + boardWidth - 3, yPosition, 3, 30, Color(244, 244,249,alpha))
			
			--[[local Avatar = vgui.Create( "AvatarImage", Panel )
			Avatar:SetSize( 30, 30 )
			Avatar:SetPos( xOffset, yPosition )
			Avatar:SetPlayer( ply, 64 )]]

			
			local px = xOffset + 34
			--draw.SimpleText(plinfo.Name, ScoreboardInfoFont, px, yPosition, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
			draw.SimpleTextOutlined( plinfo.Name, ScoreboardInfoFont, px, yPosition, Color(255,255,255,alpha), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0.5, Color(60,60,60,120) )

			px = xOffset + boardWidth - (colWidth*3) + 8	
			draw.SimpleText(plinfo.xp, ScoreboardInfoFont, px, yPosition, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)

			px = xOffset + boardWidth - (colWidth*2) + 8			
			draw.SimpleText(plinfo.Deaths, ScoreboardInfoFont, px, yPosition, Color(255, 255, 255, alpha), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
			
			px = xOffset + boardWidth - (colWidth*1.08) + 15			
			draw.SimpleText(plinfo.Ping, ScoreboardInfoFont, px, yPosition, Color(255, 255, 255, alpha), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
			
			
			yPosition = yPosition + 35
			

		end
	end
	self.ScoreDesign.Height = (self.ScoreDesign.Height * 2) + (yPosition-yOffset)
	self.ScoreDesign.Height = self.ScoreDesign.Height / 3
	
	surface.SetDrawColor( 234,243,248,alpha )
	surface.DrawRect( xOffset, yPosition + 4, boardWidth, 20 )
	
	surface.SetDrawColor( 245,105,78,alpha )
	surface.DrawRect( xOffset, yPosition + 4, 3, 20 )

	
	


end

