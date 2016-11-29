--[[ SHARED ]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Category = "Boats"
ENT.PrintName = "Minimal Floater"
ENT.Author = "Senpai"boatpieces = {}boatpieces[1] = { position = Vector(90,0,0), angle = Angle(0,0,0), model = "models/props_phx/construct/wood/wood_panel2x4.mdl"}boatpieces[2] = { position = Vector(180,0,0), angle = Angle(0,0,0), model = "models/props_phx/construct/wood/wood_panel2x4.mdl"}--[[ INIT_SV (SERVER) ]]if SERVER then	function ENT:Initialize()				self:SetModel("models/props_phx/construct/wood/wood_panel2x4.mdl")				self:SetModelScale(1,0)		self:PhysicsInit(SOLID_VPHYSICS)		self:SetMoveType(MOVETYPE_VPHYSICS)				self:PhysicsDestroy()				for i=1,#boatpieces do			local item = ents.Create("prop_physics")			item:SetModel(boatpieces[ i ].model)			item:SetPos(self:GetPos() + boatpieces[ i ].position)						item:SetAngles(angle)			item:SetParent(self, MOVETYPE_NONE) --MOVETYPE_NONE			item:PhysicsInit(SOLID_VPHYSICS)			item:SetMoveType(MOVETYPE_VPHYSICS)			item:SetSolid(SOLID_VPHYSICS)			item:Spawn()						end			endend
-- [[ INIT_CL (CLIENT) ]]
if CLIENT then	function ENT:Draw()
		self:DrawModel()		--[[if self:GetPos():Distance(LocalPlayer():GetPos()) < 350 then						-- angle --			local Ang = self:GetAngles()			Ang:RotateAroundAxis( Ang:Forward(), 90)			Ang:RotateAroundAxis( Ang:Right(), -90)						-- position --			local UpTranslate = 2 + math.sin(CurTime()) * 2 			local RightTranslate = -10			local ForwardTranslate = 10						-- fading -- 			local dist = self:GetPos():Distance(EyePos())			local dist_calc = dist / 700			local mathmemes = 1 - dist_calc			local alphacalc = 255 * mathmemes			cam.Start3D2D(self:GetPos() + self:GetUp() * 1 + self:GetRight() * RightTranslate + self:GetForward() * -10, Ang + Angle(180, 90, 90), 0.2)												surface.SetDrawColor( Color( 255, 255, 255, 255 ) )				surface.SetMaterial( soil )				surface.DrawTexturedRect( 0, 0, 100, 100 )								draw.OutlinedBox( 1, 1, 100, 100, 5, Color(250,90,160) )			cam.End3D2D()								end]]
	end
end
