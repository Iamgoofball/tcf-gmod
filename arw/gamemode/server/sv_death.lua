hook.Add("PlayerDeathSound", "DeFlatline", function() return true end)


hook.Add("PlayerDeath", "NewSound", function(vic,unused1,unused2) vic:ConCommand("play "..Config["death-sound"]) end)