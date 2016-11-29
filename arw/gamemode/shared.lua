GM.Name 	= "American Revolutionary War RP" -- Rename this to what category you want to show up as under the server browser.
GM.Author 	= "Senpai Noodles and Iamgoofball"
GM.Email 	= "N/A"
GM.Website 	= "N/A"

Config = {}

-- Configure the gamemode's basics here.
Config["Team1Name"] = "rebel"
Config["Team2Name"] = "british"
Config["Team1PrettyName"] = "American"
Config["Team2PrettyName"] = "British"
Config["GM.Team1Color"] = Color( 0, 51, 102, 255 )
Config["GM.Team2Color"] = Color( 102, 0, 0, 255 )
Config["Team1Win"] = "the Americans won!"
Config["Team2Win"] = "the British Empire won!"
Config["TieWin"] = "it's a Tie!"
Config["Team1DefaultPrimary"] = "tfa_american_rifle_1"
Config["Team1DefaultSecondary"] = "tfa_american_pistol_1"
Config["Team1DefaultMelee"] = "tfa_american_sword_1"
Config["Team2DefaultPrimary"] = "tfa_british_rifle_1"
Config["Team2DefaultSecondary"] = "tfa_british_pistol_1"
Config["Team2DefaultMelee"] = "tfa_british_sword_1"

-- Tea Party is themed after Revolutionary War stuff by default. You can use this to re-theme it to whatever you want.
Config["TeaPartyName"] = "Tea Party"
Config["TeaPartyDescriptionStart"] = "The British must defend the Tea Crates for "
Config["TeaPartyDescriptionFinish"] = " seconds while the Rebels destroy them!"
Config["TeaPartyCrateModel"] = "models/props/de_inferno/wine_barrel.mdl"

Config["regen-delay"] = 15 
Config["kill-reward"] = 100 -- higher rank kills is this * 2 exp
Config["barricade-reward"] = 200 -- exp
Config["round-exp-reward"] = 300 -- what a player gets rewarded for team win
Config["round-cash-reward"] = 1000 
Config["player-tags-esp"] = true 
Config["death-sound"] = Sound("soundtrack/kill.wav")
Config["loot-reward"] = 300
Config["objective-reward"] = 50 -- every Config["objective-reward-refresh"] seconds when in objective zone
Config["objective-reward-refresh"] = 8 -- how many seconds reward refreshing for objectives

function GM:Initialize()

	self.BaseClass.Initialize( self )
	
end

team.SetUp( 1, "Undecieded", Color( 0, 204, 0, 255 ) ) 
team.SetUp( 2, Config["Team1PrettyName"], Config["GM.Team1Color"] ) 
team.SetUp( 3, Config["Team2PrettyName"], Config["GM.Team2Color"] ) 
team.SetUp( 4, "Spectator", Color( 204, 0, 204, 255 ) ) 

function GM:ScalePlayerDamage( ply, hitgroup, dmginfo )

	if hitgroup == HITGROUP_HEAD then
		if GetGlobalEntity("Team2VIP") == ply or GetGlobalEntity("Team1VIP") == ply then
			dmginfo:ScaleDamage(1)
		else
			dmginfo:ScaleDamage(2)
		end
	else
		if GetGlobalEntity("Team2VIP") == ply or GetGlobalEntity("Team1VIP") == ply then
			dmginfo:ScaleDamage(0.5)
		else
			dmginfo:ScaleDamage(1)
		end
	end

end

function GM:PlayerButtonDown( ply, button )
	if ply.cooldown == true then
		return
	end
	if button == KEY_V and ply.is_voicechat != true then
		ply.is_voicechat = true
		print("voice chat on:")
		print(ply.is_voicechat)
		return
	end
	if button == KEY_0 and ply.is_voicechat == true then
		ply.is_voicechat = false
		print("voice chat off: ")
		print(ply.is_voicechat)
		return
	end
	if button == KEY_1 and ply.is_voicechat == true and ply:Alive() == true then
		if SERVER then
			ply:Say("(VOICE) Help!", true)
		end
		local sounds_r = {1,2,3,4}
		local sounds_b = {1,2,3}
		if SERVER then
			if ply:Team() == 2 then
				ply:EmitSound("voice/" .. Config["Team1Name"] .. "/help/" .. Config["Team1Name"] .. "-help-"..table.Random(sounds_r)..".wav")
			elseif ply:Team() == 3 then
				ply:EmitSound("voice/" .. Config["Team2Name"] .. "/help/" .. Config["Team2Name"] .. "-help-"..table.Random(sounds_b)..".wav")
			end
		end
		ply.is_voicechat = false
		ply.cooldown = true
		timer.Simple( 3, function() ply.cooldown = false end )
		return
	end
	if button == KEY_2 and ply.is_voicechat == true and ply:Alive() == true then
		local sounds_r = {1,2}
		local sounds_b = {1,2}
		if SERVER then
			if ply:Team() == 2 then
				ply:EmitSound("voice/" .. Config["Team1Name"] .. "/battle_cry/" .. Config["Team1Name"] .. "-battlecry-"..table.Random(sounds_r)..".wav")
			elseif ply:Team() == 3 then
				ply:EmitSound("voice/" .. Config["Team2Name"] .. "/battle_cry/" .. Config["Team2Name"] .. "-battle_cry-"..table.Random(sounds_b)..".wav")
			end
		end
		ply.is_voicechat = false
		ply.cooldown = true
		timer.Simple( 3, function() ply.cooldown = false end )
		return
	end
	if button == KEY_3 and ply.is_voicechat == true and ply:Alive() == true then
		local sounds_r = {1,2,3,4,5,6}
		local sounds_b = {1,2}
		if SERVER then
			if ply:Team() == 2 then
				ply:EmitSound("voice/" .. Config["Team1Name"] .. "/cheers/" .. Config["Team1Name"] .. "-cheers-"..table.Random(sounds_r)..".wav")
			elseif ply:Team() == 3 then
				ply:EmitSound("voice/" .. Config["Team2Name"] .. "/cheers/" .. Config["Team2Name"] .. "-cheers-"..table.Random(sounds_b)..".wav")
			end
		end
		ply.is_voicechat = false
		ply.cooldown = true
		timer.Simple( 3, function() ply.cooldown = false end )
		return
	end
	if button == KEY_4 and ply.is_voicechat == true and ply:Alive() == true then
		local sounds_r = {1,2,3,4,5,6,7,8}
		local sounds_b = {1,2,3,4}
		if SERVER then
			if ply:Team() == 2 then
				ply:EmitSound("voice/" .. Config["Team1Name"] .. "/jeers/" .. Config["Team1Name"] .. "-taunt-"..table.Random(sounds_r)..".wav")
			elseif ply:Team() == 3 then
				ply:EmitSound("voice/" .. Config["Team2Name"] .. "/jeers/" .. Config["Team2Name"] .. "-jeers-"..table.Random(sounds_b)..".wav")
			end
		end
		ply.is_voicechat = false
		ply.cooldown = true
		timer.Simple( 3, function() ply.cooldown = false end )
		return
	end
	if button == KEY_5 and ply.is_voicechat == true and ply:Alive() == true then
		if SERVER then
			ply:Say("(VOICE) Thanks!", true)
		end
		local sounds_r = {1,2,3}
		local sounds_b = {1,2}
		if SERVER then
			if ply:Team() == 2 then
				ply:EmitSound("voice/" .. Config["Team1Name"] .. "/thanks/" .. Config["Team1Name"] .. "-thanks-"..table.Random(sounds_r)..".wav")
			elseif ply:Team() == 3 then
				ply:EmitSound("voice/" .. Config["Team2Name"] .. "/thanks/" .. Config["Team2Name"] .. "-thanks-"..table.Random(sounds_b)..".wav")
			end
		end
		ply.is_voicechat = false
		ply.cooldown = true
		timer.Simple( 3, function() ply.cooldown = false end )
		return
	end
	if button == KEY_6 and ply.is_voicechat == true and ply:Alive() == true then
		if SERVER then
			ply:Say("(VOICE) Go Go Go!", true)
		end
		local sounds_r = {1,2,3,4}
		local sounds_b = {1,2,3}
		if SERVER then
			if ply:Team() == 2 then
				ply:EmitSound("voice/" .. Config["Team1Name"] .. "/gogogo/" .. Config["Team1Name"] .. "-gogogo-"..table.Random(sounds_r)..".wav")
			elseif ply:Team() == 3 then
				ply:EmitSound("voice/" .. Config["Team2Name"] .. "/gogogo/" .. Config["Team2Name"] .. "-gogogo-"..table.Random(sounds_b)..".wav")
			end
		end
		ply.is_voicechat = false
		ply.cooldown = true
		timer.Simple( 3, function() ply.cooldown = false end )
		return
	end
	if button == KEY_7 and ply.is_voicechat == true and ply:Alive() == true then
		if SERVER then
			ply:Say("(VOICE) Yes.", true)
		end
		local sounds_r = {1,2,3}
		local sounds_b = {1,2,3}
		if SERVER then
			if ply:Team() == 2 then
				ply:EmitSound("voice/" .. Config["Team1Name"] .. "/yes/" .. Config["Team1Name"] .. "-yes-"..table.Random(sounds_r)..".wav")
			elseif ply:Team() == 3 then
				ply:EmitSound("voice/" .. Config["Team2Name"] .. "/yes/" .. Config["Team2Name"] .. "-yes-"..table.Random(sounds_b)..".wav")
			end
		end
		ply.is_voicechat = false
		ply.cooldown = true
		timer.Simple( 3, function() ply.cooldown = false end )
		return
	end
	if button == KEY_8 and ply.is_voicechat == true and ply:Alive() == true then
		if SERVER then
			ply:Say("(VOICE) No.", true)
		end
		local sounds_r = {1,2,3,4}
		local sounds_b = {1,2,3}
		if SERVER then
			if ply:Team() == 2 then
				ply:EmitSound("voice/" .. Config["Team1Name"] .. "/no/" .. Config["Team1Name"] .. "-no-"..table.Random(sounds_r)..".wav")
			elseif ply:Team() == 3 then
				ply:EmitSound("voice/" .. Config["Team2Name"] .. "/no/" .. Config["Team2Name"] .. "-no-"..table.Random(sounds_b)..".wav")
			end
		end
		ply.is_voicechat = false
		ply.cooldown = true
		timer.Simple( 3, function() ply.cooldown = false end )
		return
	end
	if button == KEY_9 and ply.is_voicechat == true and ply:Alive() == true then
		if SERVER then
			ply:Say("(VOICE) Complete the objective!", true)
		end
		if GetGlobalString("GameTypeSelected") == GameType[1].name then
			local sounds_b = {7,8}
			local sounds_r = {9,10}
			if SERVER then
				if ply:Team() == 2 then
					ply:EmitSound("voice/" .. Config["Team1Name"] .. "/objective/" .. Config["Team1Name"] .. "-objectivespecific-"..table.Random(sounds_r)..".wav")
				elseif ply:Team() == 3 then
					ply:EmitSound("voice/" .. Config["Team2Name"] .. "/objective/" .. Config["Team2Name"] .. "-objective_specific-"..table.Random(sounds_b)..".wav")
				end
			end
		elseif GetGlobalString("GameTypeSelected") == GameType[2].name then
			local sounds_b = {10}
			local sounds_r = {11}
			if SERVER then
				if ply:Team() == 2 then
					ply:EmitSound("voice/" .. Config["Team1Name"] .. "/objective/" .. Config["Team1Name"] .. "-objectivespecific-"..table.Random(sounds_r)..".wav")
				elseif ply:Team() == 3 then
					ply:EmitSound("voice/" .. Config["Team2Name"] .. "/objective/" .. Config["Team2Name"] .. "-objective_specific-"..table.Random(sounds_b)..".wav")
				end
			end
		elseif GetGlobalString("GameTypeSelected") == GameType[3].name then
			local sounds_b = {5,6}
			local sounds_r = {3,6}
			if SERVER then
				if ply:Team() == 2 then
					ply:EmitSound("voice/" .. Config["Team1Name"] .. "/objective/" .. Config["Team1Name"] .. "-objectivespecific-"..table.Random(sounds_r)..".wav")
				elseif ply:Team() == 3 then
					ply:EmitSound("voice/" .. Config["Team2Name"] .. "/objective/" .. Config["Team2Name"] .. "-objective_specific-"..table.Random(sounds_b)..".wav")
				end
			end
		elseif GetGlobalString("GameTypeSelected") == GameType[4].name then
			local sounds_b = {3,4}
			local sounds_r = {1,4,8}
			if SERVER then
				if ply:Team() == 2 then
					ply:EmitSound("voice/" .. Config["Team1Name"] .. "/objective/" .. Config["Team1Name"] .. "-objectivespecific-"..table.Random(sounds_r)..".wav")
				elseif ply:Team() == 3 then
					ply:EmitSound("voice/" .. Config["Team2Name"] .. "/objective/" .. Config["Team2Name"] .. "-objective_specific-"..table.Random(sounds_b)..".wav")
				end
			end
		elseif GetGlobalString("GameTypeSelected") == GameType[5].name then
			local sounds_b = {9}
			local sounds_r = {12}
			if SERVER then
				if ply:Team() == 2 then
					ply:EmitSound("voice/" .. Config["Team1Name"] .. "/objective/" .. Config["Team1Name"] .. "-objectivespecific-"..table.Random(sounds_r)..".wav")
				elseif ply:Team() == 3 then
					ply:EmitSound("voice/" .. Config["Team2Name"] .. "/objective/" .. Config["Team2Name"] .. "-objective_specific-"..table.Random(sounds_b)..".wav")
				end
			end
		end
		ply.is_voicechat = false
		ply.cooldown = true
		timer.Simple( 3, function() ply.cooldown = false end )
		return
	end
end

-- place shared tables here --

GameType = {}

GameType[1] = { name = "Team Deathmatch", icon = "materials/gametype/tdm-icon.png"}
GameType[2] = { name = "Capture Points", icon = "materials/gametype/ctp-icon.png"}
GameType[3] = { name = "King of The Hill", icon = "materials/gametype/koth-icon.png"}
GameType[4] = { name = Config["TeaPartyName"], icon = "materials/gametype/tp-icon.png"}
GameType[5] = { name = "VIP", icon = "materials/gametype/vip-icon.png"}
GameType[6] = { name = "Random", icon = "materials/gametype/random-icon.png"}


Weapons = {}

Weapons[1] = {weptype = 1, team = 3, entname = "tfa_british_rifle_1", display = "Long Land Pattern", model = "models/weapons/awoi/w_short_land_pattern.mdl", damage = 5, accuracy = 10, firerate = 1, level = 0}
Weapons[2] = {weptype = 1, team = 3, entname = "tfa_british_rifle_2", display = "Long Land Multi-Shot Pattern", model = "models/weapons/awoi/w_short_land_pattern.mdl", damage = 3, accuracy = 3, firerate = 8, level = 5}
Weapons[3] = {weptype = 1, team = 3, entname = "tfa_british_rifle_3", display = "Long Land Shotgun Pattern", model = "models/weapons/awoi/w_short_land_pattern.mdl", damage = 3, accuracy = 5, firerate = 1, level = 10}

Weapons[4] = {weptype = 1, team = 2, entname = "tfa_american_rifle_1", display = "Charleville Model 1728", model = "models/weapons/awoi/w_model_1728.mdl", damage = 5, accuracy = 10, firerate = 1, level = 0}
Weapons[5] = {weptype = 1, team = 2, entname = "tfa_american_rifle_2", display = "Charleville Multi-Shot Model 1728", model = "models/weapons/awoi/w_model_1728.mdl", damage = 3, accuracy = 3, firerate = 8, level = 5}
Weapons[6] = {weptype = 1, team = 2, entname = "tfa_american_rifle_3", display = "Charleville Shotgun Model 1728", model = "models/weapons/awoi/w_model_1728.mdl", damage = 3, accuracy = 5, firerate = 1, level = 10}

Weapons[7] = {weptype = 2, team = 3, entname = "tfa_british_pistol_1", display = "English Dragoon Pistol", model = "models/weapons/awoi/w_english_dragoon_pistol.mdl", damage = 5, accuracy = 10, firerate = 1, level = 0}
Weapons[8] = {weptype = 2, team = 3, entname = "tfa_british_pistol_2", display = "English Multi-Shot Dragoon Pistol", model = "models/weapons/awoi/w_english_dragoon_pistol.mdl", damage = 3, accuracy = 3, firerate = 8, level = 5}
Weapons[9] = {weptype = 2, team = 3, entname = "tfa_british_pistol_3", display = "English Shotgun Dragoon Pistol", model = "models/weapons/awoi/w_english_dragoon_pistol.mdl", damage = 3, accuracy = 5, firerate = 1, level = 10}

Weapons[10] = {weptype = 2, team = 2, entname = "tfa_american_pistol_1", display = "French 1766 Cavalry Pistol", model = "models/weapons/awoi/w_french_1766_cavalry_pistol.mdl", damage = 5, accuracy = 10, firerate = 1, level = 0}
Weapons[11] = {weptype = 2, team = 2, entname = "tfa_american_pistol_2", display = "French Multi-Shot Cavalry Pistol", model = "models/weapons/awoi/w_french_1766_cavalry_pistol.mdl", damage = 3, accuracy = 3, firerate = 8, level = 5}
Weapons[12] = {weptype = 2, team = 2, entname = "tfa_american_pistol_3", display = "French Shotgun Cavalry Pistol", model = "models/weapons/awoi/w_french_1766_cavalry_pistol.mdl", damage = 3, accuracy = 5, firerate = 1, level = 10}

Location = {}
	
Location["British-spawn"] = {pos = Vector(8888.750977, 2070.588867, 195.946396)}
Location["American-spawn"] = {pos = Vector(-7397.078613, -1323.084473, 196.989029)}

Location["American-spawn-display"] = {pos = Vector(-3001.453369, 598.242676, 284.071167)}
Location["British-spawn-display"] = {pos = Vector(3045.126953, -146.878693, 284.796997)}

Location["American-prep"] = {pos = Vector(-3930.692627, 525.278259, 193.856583)}
Location["British-prep"] = {pos = Vector(4873.492188, -150.858917, 205.890381)}

Location["American-Fight"] = {pos = Vector(-3001.453369, 598.242676, 284.071167)}
Location["British-Fight"] = {pos = Vector(3045.126953, -146.878693, 284.796997)}

Location["Barricade"] = {pos = Vector(129.681686, -4250.608398, 249.985199)}

Location["KOTH"] = {pos = Vector(152.299698, -5508.940430, 206.572662)}

Location["Paper"] = {pos = Vector(-790.058105, -45.686008, 213.875656)}


Objectives = {}

Objectives[2] = {pos = Vector(730.632874, 3378.484619, 205.509277), letter = "A"} -- flag

Objectives[1] = {pos = Vector(-759.893005, -48.941532, 160.737976), letter = "B"} -- farm

Objectives[3] = {pos = Vector(59.757538, -1851.403320, 134.939987), letter = "C"} -- well

Objectives[4] = {pos = Vector(124.558128, -5437.647949, 219.013824), letter = "D"} -- fort

TeaCrates = {}

TeaCrates[1] = {pos = Vector(557.825806, -5619.362793, 249.031250)}
TeaCrates[2] = {pos = Vector(547.544678, -5846.391113, 249.031250)}
TeaCrates[3] = {pos = Vector(345.031311, -5957.604004, 249.031250)}

TeaCrates[4] = {pos = Vector(-383.222351, -5654.589355, 249.031250)}
TeaCrates[5] = {pos = Vector(-464.142975, -5384.095215, 249.031250)}
TeaCrates[6] = {pos = Vector(-687.777710, -5578.760254, 249.031250)}

TeaCrates[7] = {pos = Vector(13.822784, -2401.628662, 162.782272)}
TeaCrates[8] = {pos = Vector(-86.861954, -2416.200928, 164.113464)}
TeaCrates[9] = {pos = Vector(-60.340714, -2292.388916, 164.673431)}

TeaCrates[10] = {pos = Vector(-1290.126099, -1114.311646, 192.213455)}
TeaCrates[11] = {pos = Vector(-1111.859131, -1089.209839, 198.177856)}
TeaCrates[12] = {pos = Vector(-1188.244629, -863.862427, 210.978821)}

TeaCrates[13] = {pos = Vector(-1116.227539, -228.156967, 220.343048)}
TeaCrates[14] = {pos = Vector(-831.201050, -16.967257, 215.175766)}
TeaCrates[15] = {pos = Vector(-541.809692, -4.899796, 226.122406)}

TeaCrates[16] = {pos = Vector(-780.686218, 2537.644531, 263.383484)}
TeaCrates[17] = {pos = Vector(-615.908508, 2514.665283, 284.019562)}
TeaCrates[18] = {pos = Vector(-728.508057, 2163.985107, 304.579559)}

TeaCrates[19] = {pos = Vector(923.803833, 3431.851563, 264.812592)}
TeaCrates[20] = {pos = Vector(553.439331, 3409.010010, 266.337585)}
TeaCrates[21] = {pos = Vector(734.179993, 3101.103516, 263.925964)}

Rank = {}

Rank["American-Private"] = {name = "Private", model = "models/kriegsyntax/awoi/" .. Config["Team1Name"] .. "s/private/playermodel.mdl"}
Rank["British-Private"] = {name = "Private", model = "models/kriegsyntax/awoi/" .. Config["Team2Name"] .. "/private/playermodel.mdl"}

Rank["American-Corporal"] = {name = "Corporal", model = "models/kriegsyntax/awoi/" .. Config["Team1Name"] .. "s/private/playermodel.mdl"}
Rank["British-Corporal"] = {name = "Corporal", model = "models/kriegsyntax/awoi/" .. Config["Team2Name"] .. "/private/playermodel.mdl"}

Rank["American-Sergeant"] = {name = "Sergent", model = "models/kriegsyntax/awoi/" .. Config["Team1Name"] .. "s/private/playermodel.mdl"}
Rank["British-Sergeant"] = {name = "Sergent", model = "models/kriegsyntax/awoi/" .. Config["Team2Name"] .. "/private/playermodel.mdl"}

Rank["American-SergeantMajor"] = {name = "SergentMajor", model = "models/kriegsyntax/awoi/" .. Config["Team1Name"] .. "s/private/playermodel.mdl"}
Rank["British-SergeantMajor"] = {name = "SergentMajor", model = "models/kriegsyntax/awoi/" .. Config["Team2Name"] .. "/private/playermodel.mdl"}

Rank["American-Lieutenant"] = {name = "Lieutenant", model = "models/kriegsyntax/awoi/" .. Config["Team1Name"] .. "s/private/playermodel.mdl"}
Rank["British-Lieutenant"] = {name = "Lieutenant", model = "models/kriegsyntax/awoi/" .. Config["Team2Name"] .. "/private/playermodel.mdl"}

Rank["American-Captain"] = {name = "Captain", model = "models/kriegsyntax/awoi/" .. Config["Team1Name"] .. "s/private/playermodel.mdl"}
Rank["British-Captain"] = {name = "Captain", model = "models/kriegsyntax/awoi/" .. Config["Team2Name"] .. "/private/playermodel.mdl"}

Rank["American-Major"] = {name = "Major", model = "models/kriegsyntax/awoi/" .. Config["Team1Name"] .. "s/private/playermodel.mdl"}
Rank["British-Major"] = {name = "Major", model = "models/kriegsyntax/awoi/" .. Config["Team2Name"] .. "/private/playermodel.mdl"}

local meta = FindMetaTable("Player")

function meta:GetRank()
	
	local level = tonumber(self:GetNetworkedInt( "Level" ))

	if level >= 0 && level <= 9 then
		return "Private"
	elseif level >= 10 && level <= 14 then
		return "Corporal"
	elseif level >= 15 && level <= 29 then
		return "Sergeant"
	elseif level >= 30 && level <= 39 then
		return "SergeantMajor"
	elseif level >= 40 && level <= 59 then
		return "Lieutenant"
	elseif level >= 60 && level <= 89 then
		return "Captain"
	elseif level >= 90 then
		return "Major"
	end
	
end
