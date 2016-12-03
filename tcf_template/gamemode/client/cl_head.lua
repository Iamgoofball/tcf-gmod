surface.CreateFont("NamePanelFont", {
	font = "ChatFont",
	size = 35,
	weight = 100,
	antialias = true,
})

----------------------------------------------------------------------------
//                                 Variables                              \\
----------------------------------------------------------------------------	

----------------------------------------------------------------------------
//                                 The Hud                                \\
----------------------------------------------------------------------------
function DrawName( ply )
	
	--if LocalPlayer() == ply then return end
	if ply:GetPos():Distance(LocalPlayer():GetPos()) < 400 then
		if (ply:Alive()) then
			local Head = ply:LookupBone("ValveBiped.Bip01_Head1")
			local HeadPos, HeadAng = ply:GetBonePosition(Head)
			local Pos = HeadPos + Vector(0, 0, 15)
			local eyeang = LocalPlayer():EyeAngles().y - 90 -- Face upwards
			local Ang = Angle( 0, eyeang, 90 )
			
			cam.Start3D2D(Pos + Vector(math.sin(CurTime()), 0, math.sin(CurTime()) * 2), Ang, 0.1)
				if Config["player-tags-esp"] == true then
					cam.IgnoreZ( true )
				end
				
				//Name Box\\	
				
				surface.SetDrawColor(255,255,255)
				surface.SetMaterial( Material(  "materials/gui/exp-background3.png" ) )  --Use dir icon16/ for silkicons
				surface.DrawTexturedRect(-95,-25,245,30)	
				
				surface.SetDrawColor(255,255,255)
				surface.SetMaterial( Material(  "materials/gui/exp-background3.png" ) )  --Use dir icon16/ for silkicons
				surface.DrawTexturedRect(-150,-25,50,50)
				
				surface.SetDrawColor(255,255,255)
				surface.SetMaterial( Material(  "materials/gui/"..team.GetName( ply:Team() ).."-icon.png" ) )  --Use dir icon16/ for silkicons
				surface.DrawTexturedRect(-146,-21,42,42)
				
				draw.SimpleTextOutlined(ply:GetLevel(), "NamePanelFont", -125, -2, Color(255, 255, 255, 150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 150))

				
				if ply:IsSpeaking() then
					surface.SetDrawColor(255,255,255)
					surface.SetMaterial( Material(  "voice/icntlk_pl" ) )  --Use dir icon16/ for silkicons
					surface.DrawTexturedRect(-150,-25,50,50)	
				end
			
				draw.SimpleTextOutlined(string.sub(ply:Nick(), 1, 14), "NamePanelFont", -90, -12, Color(255, 255, 255, 150), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 150))
				draw.SimpleTextOutlined(string.sub(ply:GetRank(), 1, 14), "NamePanelFont", 0, -50, Color(255, 255, 255, 150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 150))
				
				//Health\\
				
				surface.SetDrawColor( 0, 0, 0, 255 )
				surface.DrawRect( -95, 12, 245, 12 )
					
				surface.SetDrawColor( 250, 0, 0, 100 )
				surface.DrawRect( -95, 12, ply:Health() * 2.45, 12 )
					
				draw.OutlinedBox( -95, 12, 245, 12, 1, Color( 10, 10, 10 ) )
				cam.IgnoreZ( false )
			cam.End3D2D()
		end
	end
 
end
hook.Add( "PostPlayerDraw", "DrawName", DrawName )






