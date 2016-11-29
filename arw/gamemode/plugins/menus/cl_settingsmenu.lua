function settingsmenu()

	local DFrame = vgui.Create( "DFrame" )
	DFrame:Center()
	DFrame:SetTitle("Settings")
	DFrame:ShowCloseButton( true )
	DFrame:SetVisible( true )
	DFrame:SetDraggable( true )
	DFrame:MakePopup()
	DFrame:SetSize( 400, 400 ) -- Set the size of the panel

	local Music = vgui.Create( "DNumSlider", DFrame )
	Music:SetPos( 50, 50 )
	Music:SetSize( 300, 20 )
	Music:SetText( "Music Volume" )
	Music:SetMin( 0 )
	Music:SetMax( 1 )
	Music:SetDecimals( 1 )	
	Music:SetValue( LocalPlayer():GetNWInt("music_volume", 0.1) )	
	Music.OnValueChanged = function( panel, value )
		LocalPlayer():SetNWInt("music_volume", value)
	end
	
	local TP = vgui.Create( "DNumSlider", DFrame )
	TP:SetPos( 50, 75 )
	TP:SetSize( 300, 20 )
	TP:SetText( "Thirdperson" )
	TP:SetMin( 0 )
	TP:SetMax( 1 )
	TP:SetDecimals( 0 )	
	TP:SetValue( LocalPlayer():GetNWInt("thirdperson", 1) )	
	TP.OnValueChanged = function( panel, value )
		LocalPlayer():SetNWInt("thirdperson", math.floor(value))
	end
	
end
net.Receive( 'open_settings', settingsmenu )
