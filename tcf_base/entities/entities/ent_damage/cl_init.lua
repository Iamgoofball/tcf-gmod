include("shared.lua")
local soil = Material( "materials/gui/british-icon.png", "noclamp" )
local maxhealth = ENT.StartingHealth
local smooth = ENT.StartingHealth
function ENT:Draw()

	self:DrawModel()
	if self:GetPos():Distance(LocalPlayer():GetPos()) < 350 then
		
		-- angle --
		local Ang = self:GetAngles()
		Ang:RotateAroundAxis( Ang:Forward(), 90)
		Ang:RotateAroundAxis( Ang:Right(), 0)
		
		local eyeang = LocalPlayer():EyeAngles().y - 90 -- Face upwards
		local SpinAng = Angle( 0, eyeang, 90 )
	
	
		-- position --
		local UpTranslate = 2 + math.sin(CurTime()) * 2 
		local RightTranslate = 0
		local ForwardTranslate = 10

		cam.Start3D2D(self:GetPos() + self:GetUp() * 60, SpinAng, 0.1)
			
			surface.SetDrawColor(255,255,255, 255)
			surface.SetMaterial( Material(  "materials/gui/exp-background3.png" ) )  --Use dir icon16/ for silkicons
			surface.DrawTexturedRect(-250,0,500,100)
			
			surface.SetDrawColor( 0, 0, 0, 255 )
			surface.DrawRect( -230, 20, 460, 60 )
			
			local wi = 460
			local width = self:GetEntHealth()/maxhealth*(wi)
			local width = math.Clamp(width, 0, wi)
			
			surface.SetDrawColor( 90, 0, 0, 255 )
			surface.DrawRect( -230, 20, Lerp(8 * FrameTime(), width, 460), 60 )
			if LocalPlayer():Team() == 3 then
				
				surface.SetDrawColor(255,255,255, 255)
				surface.SetMaterial( Material(  "materials/gui/defend-icon.png" ) )  --Use dir icon16/ for silkicons
				surface.DrawTexturedRect(-50,-200,100,100)
				
			elseif LocalPlayer():Team() == 2 then
				
				surface.SetDrawColor(255,255,255, 255)
				surface.SetMaterial( Material(  "materials/gui/contest-icon.png" ) )  --Use dir icon16/ for silkicons
				surface.DrawTexturedRect(-50,-200,100,100)
				
			end
			
			
			

		cam.End3D2D()

		
	end

end