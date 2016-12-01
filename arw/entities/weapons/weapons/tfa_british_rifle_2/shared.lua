-- Variables that are used on both client and server
SWEP.Gun = ("tfa_10mm_pistol") -- must be the name of your swep but NO CAPITALS!
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "tfa_blacklisted" SWEP.PrintName = SWEP.Gun return end
end
SWEP.Category				= "American Rev War TFA Weps"
SWEP.Author				= "Iamgoofball"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Long Land Multi-Shot Pattern"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 1				-- Slot in the weapon selection menu
SWEP.SlotPos				= 1			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight				= 3			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "ar2"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles
SWEP.DoMuzzleFlash = true
SWEP.CustomMuzzleFlash = true
SWEP.MuzzleFlashEffect = "effect_awoi_smoke" --Change to a string of your muzzle flash effect
SWEP.ViewModelFOV			= 50
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/awoi/v_long_land_pattern.mdl"	-- Weapon world model
SWEP.WorldModel				= "models/weapons/awoi/w_long_land_pattern.mdl"	-- Weapon view model
SWEP.UseHands				= false
SWEP.Base					= "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.Primary.Sound			= Sound ("weapons/AWoI/musket_1_fire.wav")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 60			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 3		-- Size of a clip
SWEP.Primary.DefaultClip		= 80		-- Bullets you start with
SWEP.Primary.KickUp				= 0.4		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.3		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.3		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "ar2"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.DisableChambering = true

SWEP.Secondary.IronFOV			= 65		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 25	-- Base damage per bullet
SWEP.Primary.Spread		= 0.005	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .0001 -- Ironsight accuracy, should be the same for shotguns

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector (-7.7, -5, 6.7)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.SightsPos = Vector (-7.7, -5, 6.7)
SWEP.SightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(3.444, -7.823, -6.27)
SWEP.RunSightsAng = Vector(-10.695, 0, 0)

SWEP.InspectPosDef = Vector(19.779, -11.658, -2.241)
-- SWEP.RunSightsPos = Vector (-0.7883, 0, 2.4235)
-- SWEP.RunSightsAng = Vector (-14.417, -0.7137, 0)

if GetConVar("sv_tfa_default_clip") == nil then
	print("sv_tfa_default_clip is missing!  You might've hit the lua limit.  Contact the SWEP author(s).")
else
	if GetConVar("sv_tfa_default_clip"):GetInt() != -1 then
		SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * GetConVar("sv_tfa_default_clip"):GetInt()
	end
end

if GetConVar("sv_tfa_unique_slots") != nil then
	if not (GetConVar("sv_tfa_unique_slots"):GetBool()) then 
		SWEP.SlotPos = 2
	end
end