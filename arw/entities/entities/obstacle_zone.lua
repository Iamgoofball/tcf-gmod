AddCSLuaFile()


ENT.Type = "anim"

ENT.Category = "Zones"

ENT.PrintName = "Obstacle Zone"

ENT.Author = "Senpai"

if SERVER then
	function ENT:Initialize()
		
		self:SetModel("models/props/de_inferno/spireb.mdl")
		self:SetModelScale(0.2,1)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_NONE)
		self:PhysicsDestroy()
		self:DropToFloor()
		
		local item = ents.Create("prop_physics")

			item:SetModel("models/props/de_inferno/spireb.mdl")

			item:SetModelScale(0.2,1)
			
			item:SetPos(self:GetPos() + Vector(1000,300,0))
			
			item:SetParent(self, MOVETYPE_NONE) --MOVETYPE_NONE

			item:PhysicsInit(SOLID_VPHYSICS)

			item:SetMoveType(MOVETYPE_VPHYSICS)

			item:SetSolid(SOLID_VPHYSICS)

			item:Spawn()
			
		local item = ents.Create("prop_physics")

			item:SetModel("models/props/de_inferno/spireb.mdl")

			item:SetModelScale(0.2,1)
			
			item:SetPos(self:GetPos() - Vector(1100,500,0))
			
			item:SetParent(self, MOVETYPE_NONE) --MOVETYPE_NONE

			item:PhysicsInit(SOLID_VPHYSICS)

			item:SetMoveType(MOVETYPE_VPHYSICS)

			item:SetSolid(SOLID_VPHYSICS)

			item:Spawn()
		
	end

	function ENT:Think() 


		for _, v in pairs (ents.FindInBox( self:GetPos() - Vector(250,250,3), self:GetPos() + Vector(250,250,20) )) do
			if v:IsPlayer() then
				
				v:ChatPrint(math.random(1,10000))
			end
		end
		
	end
end

if CLIENT then
	
	local statusimage = Material( "materials/gui/contest-icon.png", "noclamp" )

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
			
			
		cam.End3D2D()

	end

end