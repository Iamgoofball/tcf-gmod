hook.Add( "PlayerCanHearPlayersVoice", "Maximum Range", function( listener, talker )
	if listener:GetPos():Distance( talker:GetPos() ) > 500 then return false end
end )