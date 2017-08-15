net.Receive( "playsong", function( len, ply )
	 local song = net.ReadString()
	 surface.PlaySound( song )
end )