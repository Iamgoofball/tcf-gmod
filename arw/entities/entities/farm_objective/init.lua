AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:Initialize()
	
	self:SetModel("models/props/de_inferno/spireb.mdl")
	self:SetModelScale(1,1)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:PhysicsDestroy()
	self:DropToFloor()
	self:SetAmericanPoints(0)
	self:SetBritishPoints(0)
	self:SetControlTeam("Neutral")
	self:SetLetter("A")
	
end

local delay = 0

function ENT:Think() 

	self.AmericanPoints = 0
	self.BritishPoints = 0
	
	for _, v in pairs (ents.FindInBox( self:GetPos() - Vector(250,250,3), self:GetPos() + Vector(250,250,80) )) do
		if GetGlobalString("GameTypeSelected") != GameType[5].name then
			if v:IsPlayer() and v:Alive() then
				if team.GetName(v:Team()) == Config["Team1PrettyName"] then
					self.AmericanPoints = self.AmericanPoints + 1
				elseif team.GetName(v:Team()) == Config["Team2PrettyName"] then
					self.BritishPoints  = self.BritishPoints  + 1
				end
			end
		else
			if v:IsPlayer() and v:Alive() then
				if GetGlobalEntity("Team2VIP") == v then
					self.BritishPoints  = self.BritishPoints  + 1
				end
				if GetGlobalEntity("Team1VIP") == v then
					self.AmericanPoints = self.AmericanPoints + 1
				end
			end
		end
	end
	self:SetAmericanPoints(self.AmericanPoints)
	self:SetBritishPoints(self.BritishPoints)
	if self.AmericanPoints > self.BritishPoints  then
	
		self.ControlTeam = Config["Team1PrettyName"]
		self:SetControlTeam(self.ControlTeam)
		
	elseif self.BritishPoints > self.AmericanPoints then
	
		self.ControlTeam = Config["Team2PrettyName"]
		self:SetControlTeam(self.ControlTeam)
		
	elseif self.BritishPoints == self.AmericanPoints && (self.BritishPoints != 0 && self.AmericanPoints != 0) then
		self.ControlTeam = "Contested"
		self:SetControlTeam(self.ControlTeam)
	end
	
	if CurTime() < delay then return end
	
	for _, v in pairs (ents.FindInBox( self:GetPos() - Vector(250,250,3), self:GetPos() + Vector(250,250,20) )) do
		if v:IsPlayer() then
			v:AddExp(Config["objective-reward"])
		end
	end
	delay = CurTime() + Config["objective-reward-refresh"]
end