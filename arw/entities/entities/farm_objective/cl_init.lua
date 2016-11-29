include("shared.lua")

local statusimage = Material( "materials/gui/contest-icon.png", "noclamp" )

surface.CreateFont( "Objective_Letter", {
	font 		= "Verdana",
	size 		= 400,
	weight 		= 400,
	antialias 	= true,
	prettyblur = 1,
})

function ENT:Draw()
	
	self:DrawModel()
		
	-- angle --
	local Ang = self:GetAngles()
	Ang:RotateAroundAxis( Ang:Forward(), 90)
	Ang:RotateAroundAxis( Ang:Right(), -90)
		
	-- position --
	local UpTranslate = 2 + math.sin(CurTime()) * 2 
	local RightTranslate = -10
	local ForwardTranslate = 10
		
	-- fading -- 
	local dist = self:GetPos():Distance(EyePos())
	local dist_calc = dist / 700
	local mathmemes = 1 - dist_calc
	local alphacalc = 255 * mathmemes

	cam.Start3D2D(self:GetPos() + self:GetUp() * 1 + self:GetRight() * RightTranslate + self:GetForward() * -10, Ang + Angle(180, 90, 90), 0.1)
		
		if self:GetControlTeam() == "Neutral" then
		
			surface.SetDrawColor( 0, 153, 76, 150 )
			surface.DrawRect( -2500, -2500, 5000, 5000 )
			draw.OutlinedBox( -2500, -2500, 5000, 5000, 20, Color(255,255,255) )
			
		elseif self:GetControlTeam() == "Contested" then
			
			surface.SetDrawColor( Color( 255, 255, 255, 150 ) )
			surface.SetMaterial( Material( "materials/gui/contest-icon.png" ) )
			surface.DrawTexturedRect( -2500, -2500, 5000, 5000 )
			draw.OutlinedBox( -2500, -2500, 5000, 5000, 20, Color(255,255,255) )
			
		else
			
			surface.SetDrawColor( Color( 255, 255, 255, 150 ) )
			surface.SetMaterial( Material( "materials/gui/"..self:GetControlTeam().."-icon.png" ) )
			surface.DrawTexturedRect( -2500, -2500, 5000, 5000 )
			draw.OutlinedBox( -2500, -2500, 5000, 5000, 20, Color(255,255,255) )
			
		end
		
	cam.End3D2D()
	
	local eyeang = LocalPlayer():EyeAngles().y - 90 -- Face upwards
	local SpinAng = Angle( 0, eyeang, 90 )
	
	local dist = self:GetPos():Distance(EyePos())
	local dist_calc = dist / 700
	local mathmemes = 1 + dist_calc
	local sizecalc = 255 * mathmemes
	
	cam.Start3D2D(self:GetPos() + self:GetUp() * 1 + self:GetRight() * RightTranslate + self:GetForward() * -10, SpinAng, 0.1)
		
		cam.IgnoreZ( true )
			
			surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
			
			if self:GetControlTeam() == "Contested" or self:GetControlTeam() == "Neutral" then
				
				surface.SetMaterial( Material( "materials/gui/contest-icon.png" ) )
			else
			
				surface.SetMaterial( Material( "materials/gui/"..self:GetControlTeam().."-icon.png" ) )
				
			end
			
			surface.DrawTexturedRect( -sizecalc / 2, -4200, sizecalc, sizecalc )
			
			draw.SimpleTextOutlined(self:GetLetter(), "Objective_Letter", 0, sizecalc - 1000, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 150))
			
		cam.IgnoreZ( false )
		
	cam.End3D2D()
	


end
