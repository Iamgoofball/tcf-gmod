SWEP.Author			= "Senpai Noodles"
SWEP.Contact			= ""
SWEP.Purpose			= ""
SWEP.Instructions		= "Left click spawns manhack"
 
SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true

SWEP.HoldType = "physgun"
SWEP.ViewModelFOV = 59.497487437186
SWEP.ViewModelFlip = false
SWEP.UseHands = false
SWEP.ViewModel = "models/weapons/v_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"

SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01"] = { scale = Vector(1, 1, 1), pos = Vector(0, -0.556, 0), angle = Angle(0, 0, 0) }
}
SWEP.WElements = {
	["pot"] = { type = "Model", model = "models/props_junk/terracotta01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.752, 5.714, 0), angle = Angle(1.169, 0, -157.793), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["element_name"] = { type = "Model", model = "models/rottweiler/drugs/cannabis.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "pot", pos = Vector(0, 0, 0), angle = Angle(0, 0, -5.844), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}



SWEP.DrawCrosshair		= false
 
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "none"
SWEP.Primary.Delay = 1
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"
 
local ShootSound = Sound( "Metal.SawbladeStick" )
 
/*---------------------------------------------------------
	Reload does nothing
---------------------------------------------------------*/
function SWEP:Reload()
end
 
/*---------------------------------------------------------
  Think does nothing
---------------------------------------------------------*/
function SWEP:Think()	
end
 
/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	if SERVER then
		local tr = self.Owner:GetEyeTrace() 
		local ent = ents.Create("prop_physics") 
		if self.Owner:GetPos():Distance(tr.HitPos) < 90 then
			self.Owner:Freeze( true )
			self.Owner:GodEnable()
			self.Owner:SendLua("surface.PlaySound(\"player/footsteps/dirt1.wav\")") 
			timer.Simple( 0.5, function() 
				self.Owner:Freeze( false )
				self.Owner:GodDisable()
				ent:SetModel("models/rottweiler/drugs/cannabis.mdl") --models/rottweiler/drugs/cannabis.mdl & models/rottweiler/drugs/cannabis_flowering.mdl & models/rottweiler/drugs/joint.mdl
				ent:SetPos(tr.HitPos + self.Owner:GetAimVector() * 35 ) 
				ent:Spawn() 
				ent:SetMoveType(MOVETYPE_NONE)
				ent:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
				timer.Simple( 5, function() 
					ent:SetModel("models/rottweiler/drugs/cannabis_flowering.mdl") 
					timer.Simple( 5, function() 
						local vPoint = Vector( ent:GetPos() )
						local effectdata = EffectData()
						effectdata:SetOrigin( vPoint )
						util.Effect( "HL1Gib", effectdata )
						ent:Remove() 
					end )
				end )
			end )
		end
	end
	if CLIENT then
		
		MainPanelWidth,MainPanelHeight = 500,300
		
		local MainPanel = vgui.Create( "DFrame" )
		MainPanel:SetPos(ScrW() / 2 - MainPanelWidth / 2, ScrH() / 2 - MainPanelHeight / 2)
		MainPanel:SetSize( MainPanelWidth, MainPanelHeight )
		MainPanel:SetTitle( " " )
		MainPanel:SetDraggable( false )
		MainPanel:ShowCloseButton( false )
		MainPanel:MakePopup()
		
		function MainPanel:Paint()
			draw.RoundedBox( 0, 0, 0, MainPanelWidth, MainPanelHeight, Color( 43, 44, 47, 255 ) )
			draw.RoundedBox( 0, 0, 0, MainPanelWidth, 20, Color( 31, 35, 38, 255 ) )
			draw.OutlinedBox( 0, 0, MainPanelWidth, MainPanelHeight, 1, Color(31, 35, 38, 255) )
			
			draw.SimpleText( "$"..LocalPlayer():GetNWInt("money"), "Basic_Font_Big", MainPanelWidth / 2 , 50, Color( 0,153,76,255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

		end
		
		timer.Create( "Planting", 1, 3, function() 
			if timer.TimeLeft( "Planting" ) <= 1 then
				MainPanel:ShowCloseButton( true )
			end
		end )
		
	end
end
 
/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
--[[function SWEP:SecondaryAttack()
 
	local tr = self.Owner:GetEyeTrace()
	if ( tr.HitWorld ) then return end
 
	self.Weapon:EmitSound( ShootSound )
	self.BaseClass.ShootEffects( self )
 
	local effectdata = EffectData()
	effectdata:SetOrigin( tr.HitPos )
	effectdata:SetNormal( tr.HitNormal )
	effectdata:SetMagnitude( 8 )
	effectdata:SetScale( 1 )
	effectdata:SetRadius( 16 )
	util.Effect( "Sparks", effectdata )
 
	// The rest is only done on the server
	if ( !SERVER ) then return end
 
	// Make a rollermine
	local ent = ents.Create( "npc_rollermine" )
 	ent:SetPos( tr.HitPos + self.Owner:GetAimVector() * -16 )
	ent:SetAngles( tr.HitNormal:Angle() )
	ent:Spawn()
 
	// Weld it to the object that we hit
	local weld = constraint.Weld( tr.Entity, ent, tr.PhysicsBone, 0, 0 )
 
	undo.Create( "Rollermine" )
	undo.AddEntity( weld )
	undo.AddEntity( ent )
	undo.SetPlayer( self.Owner )
	undo.Finish()
end]]