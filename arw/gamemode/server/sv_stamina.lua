

util.AddNetworkString( "StaminaDrowning" )
util.AddNetworkString( "StaminaSpawn" )


CreateConVar("sv_bur_maxstamina", "100", FCVAR_REPLICATED + FCVAR_ARCHIVE , "" )
CreateConVar("sv_bur_regenmul", "1000000", FCVAR_REPLICATED + FCVAR_ARCHIVE , "" )
CreateConVar("sv_bur_decaymul", "0.5", FCVAR_REPLICATED + FCVAR_ARCHIVE , "" )


net.Receive("StaminaDrowning", function(len,ply)

	local dmg = DamageInfo()
	dmg:AddDamage(10)
	dmg:SetDamageType(DMG_DROWN)
	dmg:SetAttacker(ply)
	dmg:SetInflictor(ply)
	
	ply:TakeDamageInfo(dmg)


end)


function StaminaResetVariables(ply)
	
	net.Start("StaminaSpawn")
	
		net.WriteFloat(GetConVarNumber("sv_bur_maxstamina"))
		net.WriteFloat(GetConVarNumber("sv_bur_regenmul"))
		net.WriteFloat(GetConVarNumber("sv_bur_decaymul"))

	net.Send(ply)


end

hook.Add("PlayerSpawn","Stamina Reset Variables",StaminaResetVariables)
hook.Add("PlayerInitialSpawn","Stamina Reset Variables",StaminaResetVariables)



