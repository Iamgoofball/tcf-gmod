ENT.Type = "anim"

ENT.Category = "Objectives"

ENT.PrintName = "Farm Objective"

ENT.Author = "Senpai"

ENT.AmericanPoints = 0
		
ENT.BritishPoints = 0
		
ENT.ControlTeam = " "

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "AmericanPoints")
	self:NetworkVar("Int", 1, "BritishPoints")
	self:NetworkVar("String", 0, "ControlTeam")
	self:NetworkVar("String", 1, "Letter")
end