SWEP.Base = "tfa_melee_base"
SWEP.PrintName = "Epee"

SWEP.ViewModel = "models/weapons/awoi/v_epee.mdl"
SWEP.ViewModelFOV = 55
SWEP.VMPos = Vector(0,0,0)
SWEP.UseHands = false
SWEP.CameraOffset = Angle(0,0,0)

SWEP.InspectPos = Vector(17.184, -4.891, -11.652) - SWEP.VMPos
SWEP.InspectAng = Vector(70, 46.431, 70)

SWEP.WorldModel = "models/weapons/awoi/w_epee.mdl"
SWEP.HoldType = "melee2"

SWEP.Primary.Directional = true

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.DisableIdleAnimations = false

SWEP.Primary.Attacks = {
	{
		['act'] = ACT_VM_PRIMARYATTACK, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 16*4.8, -- Trace distance
		['dir'] = Vector(-65,0,0), -- Trace arc cast
		['dmg'] = 25, --Damage
		['dmgtype'] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		['delay'] = 0.4, --Delay
		['spr'] = true, --Allow attack while sprinting?
		['snd'] = "weapons/awoi/melee/sword_swing.wav", -- Sound ID
		['snd_delay'] = 0.26,
		["viewpunch"] = Angle(1,-5,0), --viewpunch angle
		['end'] = 0.8, --time before next attack
		['hull'] = 16, --Hullsize
		['direction'] = "L", --Swing dir,
		['hitflesh'] = "weapons/awoi/melee/knife_hitflesh.wav",
		['hitworld'] = "weapons/awoi/melee/knife_hitwall.wav"
	}
}

SWEP.Secondary.Attacks = {}


SWEP.Secondary.CanBash = true
SWEP.Secondary.BashDamage = 50
