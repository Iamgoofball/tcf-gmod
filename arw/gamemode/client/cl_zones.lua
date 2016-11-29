hook.Add( "PostDrawOpaqueRenderables", "example", function()

	cam.Start3D2D( Location["American-spawn-display"].pos , Angle(0,90,90) , 1 )
		if LocalPlayer():GetPos():Distance(Location["American-spawn-display"].pos) < 1500 then
		
			-- fading -- 
			local dist = Location["American-spawn-display"].pos:Distance(EyePos())
			local dist_calc = dist / 2000
			local mathmemes = 1 - dist_calc
			local alphacalc = 255 * mathmemes

			surface.SetDrawColor(255,255,255,alphacalc)
			surface.SetMaterial( Material(  "materials/gui/american-icon.png" ) )  --Use dir icon16/ for silkicons
			surface.DrawTexturedRect(0,0,30,30)
		end
	cam.End3D2D()
	
	cam.Start3D2D( Location["British-spawn-display"].pos , Angle(0,270,90) , 1 )
		if LocalPlayer():GetPos():Distance(Location["British-spawn-display"].pos) < 1500 then
		
			-- fading -- 
			local dist = Location["British-spawn-display"].pos:Distance(EyePos())
			local dist_calc = dist / 2000
			local mathmemes = 1 - dist_calc
			local alphacalc = 255 * mathmemes

			surface.SetDrawColor(255,255,255,alphacalc)
			surface.SetMaterial( Material(  "materials/gui/british-icon.png" ) )  --Use dir icon16/ for silkicons
			surface.DrawTexturedRect(0,0,30,30)
		end
	cam.End3D2D()
end )