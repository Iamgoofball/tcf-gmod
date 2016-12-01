GM.Name 	= "American Revolutionary War RP" -- Rename this to what category you want to show up as under the server browser.
GM.Author 	= "Senpai Noodles and Iamgoofball"
GM.Email 	= "N/A"
GM.Website 	= "N/A"
--[[
				SETUP TUTORIAL:
		1. Make sure FolderName config is set properly. VERY IMPORTANT!!!
		2. Configure team names and all the below config stuff.
		3. Go through the file and make sure to update any Location or Objective/TeaCrates related positions for your map you're using.
		4. The gamemode is by default set up for the following maps: arw_fields/acw_battlefield_farmlands/rp_arw_nomad/rp_arw_imperium or any versions of these series of maps.
		5. If you are not using the maps listed in step 4, please make sure to gather locations for stuff using the following:
			A. Load up the map in sandbox
			B. Go to a location you want to put a Capture Point at.
			C. Open your console, type "getpos", and hit enter.
			D. You should get an output like this: "setpos 500 420 340;setang 420 69 666"
			C. Turn the first three numbers into a vector in a text editor, format it like this: Vector(500,420,340)
			E. Set up the Capture Point line down by the others in the file like this: "Objectives[1] = {pos = Vector(500,420,340), letter = "A"}"
			F. Make sure that the number inside Objectives[] is the next number in the sequence.
			G. Repeat these steps for as many Objectives and TeaCrates as you want to add, or to add the required stuff like Barricades, player spawns, and the KOTH point!
		6. Set up the weapons, following the instructions listed there.
		7. Edit the rank playermodels to be what you want them to be for the two teams.
		8. Launch the server, and enjoy!

]]--



Config = {}
-- IMPORTANT: MAKE SURE THIS NAME MATCHES UP WITH THE FOLDER NAME FOR THE GAMEMODE OR ELSE SHIT BREAKS
Config["FolderName"] = "arw"

-- Configure the gamemode's basics here.
Config["Team1Name"] = "rebel"
Config["Team2Name"] = "british"
Config["Team1PrettyName"] = "American"
Config["Team2PrettyName"] = "British"
Config["Team1Icon"] = "materials/gui/american-icon.png"
Config["Team2Icon"] = "materials/gui/british-icon.png"
Config["Team1MenuModel"] = "models/kriegsyntax/awoi/rebels/private/playermodel.mdl"
Config["Team2MenuModel"] = "models/kriegsyntax/awoi/british/private/playermodel.mdl"
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
-- Turn this off if you haven't installed custom voice acting for the gamemode. If you've got custom voice acting, such as the sample included with the example ARW setup shown here, feel free to turn it on.
Config["VoiceActing"] = true

-- Tea Party is themed after Revolutionary War stuff by default. You can use this to re-theme it to whatever you want.
Config["TeaPartyName"] = "Tea Party"
Config["TeaPartyDescriptionStart"] = "The British must defend the Tea Crates for "
Config["TeaPartyDescriptionFinish"] = " seconds while the Rebels destroy them!"
Config["TeaPartyCrateModel"] = "models/props/de_inferno/wine_barrel.mdl"

-- Other options for configuration.
Config["RestTime"] = 60
Config["RoundTime"] = 300
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

-- Gamemodes. Don't disable any or add any new ones without setting them up in init.lua (DO NOT ATTEMPT UNLESS YOU KNOW WHAT YOU'RE DOING), but feel free to rename/modify their icon.
GameType = {}

GameType[1] = { name = "Team Deathmatch", icon = "materials/gametype/tdm-icon.png"}
GameType[2] = { name = "Capture Points", icon = "materials/gametype/ctp-icon.png"}
GameType[3] = { name = "King of The Hill", icon = "materials/gametype/koth-icon.png"}
GameType[4] = { name = Config["TeaPartyName"], icon = "materials/gametype/tp-icon.png"}
GameType[5] = { name = "VIP", icon = "materials/gametype/vip-icon.png"}
GameType[6] = { name = "Random", icon = "materials/gametype/random-icon.png"}


Weapons = {}
-- When adding new weapons, ensure the index stays in order and no numbers are skipped.
Weapons[1] = {weptype = 1, -- 1 for Primary, 2 for Secondary
				team = 3, -- 2 for Team 1, 3 for Team 2.
				entname = "tfa_british_rifle_1", -- The entity class of the weapon.
				display = "Long Land Pattern", -- The display name of the weapon on the loadout screen.
				model = "models/weapons/awoi/w_short_land_pattern.mdl", -- The icon model of the weapon on the loadout screen.
				damage = 5, -- This and the following two are purely cosmetic for you to show players the weapon's stats.
				accuracy = 10, -- See above.
				firerate = 1, -- See above.
				level = 0} -- The level required to use the weapon. 0 is always available.
Weapons[2] = {weptype = 1, 
				team = 3, 
				entname = "tfa_british_rifle_2", 
				display = "Long Land Multi-Shot Pattern", 
				model = "models/weapons/awoi/w_short_land_pattern.mdl", 
				damage = 3, 
				accuracy = 3, 
				firerate = 8, 
				level = 5}
Weapons[3] = {weptype = 1, 
				team = 3, 
				entname = "tfa_british_rifle_3", 
				display = "Long Land Shotgun Pattern", 
				model = "models/weapons/awoi/w_short_land_pattern.mdl", 
				damage = 3, 
				accuracy = 5, 
				firerate = 1, 
				level = 10}

Weapons[4] = {weptype = 1, 
				team = 2, 
				entname = "tfa_american_rifle_1", 
				display = "Charleville Model 1728", 
				model = "models/weapons/awoi/w_model_1728.mdl", 
				damage = 5, 
				accuracy = 10, 
				firerate = 1, 
				level = 0}
Weapons[5] = {weptype = 1, 
				team = 2, 
				entname = "tfa_american_rifle_2", 
				display = "Charleville Multi-Shot Model 1728", 
				model = "models/weapons/awoi/w_model_1728.mdl", 
				damage = 3, 
				accuracy = 3,
				firerate = 8, 
				level = 5}
Weapons[6] = {weptype = 1, 
				team = 2, 
				entname = "tfa_american_rifle_3", 
				display = "Charleville Shotgun Model 1728", 
				model = "models/weapons/awoi/w_model_1728.mdl", 
				damage = 3, 
				accuracy = 5, 
				firerate = 1, 
				level = 10}
Weapons[7] = {weptype = 2, 
				team = 3, 
				entname = "tfa_british_pistol_1", 
				display = "English Dragoon Pistol", 
				model = "models/weapons/awoi/w_english_dragoon_pistol.mdl", 
				damage = 5, 
				accuracy = 10, 
				firerate = 1, 
				level = 0}
Weapons[8] = {weptype = 2, 
				team = 3, 
				entname = "tfa_british_pistol_2", 
				display = "English Multi-Shot Dragoon Pistol", 
				model = "models/weapons/awoi/w_english_dragoon_pistol.mdl", 
				damage = 3, 
				accuracy = 3, 
				firerate = 8, 
				level = 5}
Weapons[9] = {weptype = 2, 
				team = 3, 
				entname = "tfa_british_pistol_3", 
				display = "English Shotgun Dragoon Pistol", 
				model = "models/weapons/awoi/w_english_dragoon_pistol.mdl", 
				damage = 3, 
				accuracy = 5, 
				firerate = 1, 
				level = 10}

Weapons[10] = {weptype = 2, 
				team = 2, 
				entname = "tfa_american_pistol_1", 
				display = "French 1766 Cavalry Pistol", model = "models/weapons/awoi/w_french_1766_cavalry_pistol.mdl", 
				damage = 5, 
				accuracy = 10, 
				firerate = 1, 
				level = 0}
Weapons[11] = {weptype = 2, 
				team = 2, 
				entname = "tfa_american_pistol_2", 
				display = "French Multi-Shot Cavalry Pistol", 
				model = "models/weapons/awoi/w_french_1766_cavalry_pistol.mdl", 
				damage = 3, 
				accuracy = 3, 
				firerate = 8, 
				level = 5}
Weapons[12] = {weptype = 2, 
				team = 2, 
				entname = "tfa_american_pistol_3", 
				display = "French Shotgun Cavalry Pistol", 
				model = "models/weapons/awoi/w_french_1766_cavalry_pistol.mdl", 
				damage = 3, 
				accuracy = 5, 
				firerate = 1, 
				level = 10}

				
-- Spawn locations for both teams during all 3 round types.
Location = {}
	
Location[Config["Team2PrettyName"] .. "-spawn"] = {pos = Vector(8888.750977, 2070.588867, 195.946396)}
Location[Config["Team1PrettyName"] .. "-spawn"] = {pos = Vector(-7397.078613, -1323.084473, 196.989029)}

Location[Config["Team1PrettyName"] .. "-spawn-display"] = {pos = Vector(-3001.453369, 598.242676, 284.071167)}
Location[Config["Team2PrettyName"] .. "-spawn-display"] = {pos = Vector(3045.126953, -146.878693, 284.796997)}

Location[Config["Team1PrettyName"] .. "-prep"] = {pos = Vector(-3930.692627, 525.278259, 193.856583)}
Location[Config["Team2PrettyName"] .. "-prep"] = {pos = Vector(4873.492188, -150.858917, 205.890381)}

Location[Config["Team1PrettyName"] .. "-Fight"] = {pos = Vector(-3001.453369, 598.242676, 284.071167)}
Location[Config["Team2PrettyName"] .. "-Fight"] = {pos = Vector(3045.126953, -146.878693, 284.796997)}

-- One of these is required for Capture Points.
Location["Barricade"] = {pos = Vector(129.681686, -4250.608398, 249.985199)}

-- The King of The Hill capture point's location.
Location["KOTH"] = {pos = Vector(152.299698, -5508.940430, 206.572662)}

-- Currently unused. Feel free to ignore.
Location["Paper"] = {pos = Vector(-790.058105, -45.686008, 213.875656)}

-- All the objectives for Capture Points. Feel free to add/remove as many as you like, as long as there is at least one on the map.
Objectives = {}
Objectives[2] = {pos = Vector(730.632874, 3378.484619, 205.509277), letter = "A"}
Objectives[1] = {pos = Vector(-759.893005, -48.941532, 160.737976), letter = "B"}
Objectives[3] = {pos = Vector(59.757538, -1851.403320, 134.939987), letter = "C"}
Objectives[4] = {pos = Vector(124.558128, -5437.647949, 219.013824), letter = "D"}

TeaCrates = {}
-- All the objectives for Tea Party(or whatever you rename it). Feel free to add/remove as many as you like, as long as there is at least one on the map.
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
-- Ensure these playermodels are set to the ones you want to use for gameplay.
Rank[Config["Team1PrettyName"] .. "-Private"] = {name = "Private", model = "models/kriegsyntax/awoi/rebels/private/playermodel.mdl"}
Rank[Config["Team2PrettyName"] .. "-Private"] = {name = "Private", model = "models/kriegsyntax/awoi/british/private/playermodel.mdl"}

Rank[Config["Team1PrettyName"] .. "-Corporal"] = {name = "Corporal", model = "models/kriegsyntax/awoi/rebels/private/playermodel.mdl"}
Rank[Config["Team2PrettyName"] .. "-Corporal"] = {name = "Corporal", model = "models/kriegsyntax/awoi/british/private/playermodel.mdl"}

Rank[Config["Team1PrettyName"] .. "-Sergeant"] = {name = "Sergent", model = "models/kriegsyntax/awoi/rebels/private/playermodel.mdl"}
Rank[Config["Team2PrettyName"] .. "-Sergeant"] = {name = "Sergent", model = "models/kriegsyntax/awoi/british/private/playermodel.mdl"}

Rank[Config["Team1PrettyName"] .. "-SergeantMajor"] = {name = "SergentMajor", model = "models/kriegsyntax/awoi/rebels/private/playermodel.mdl"}
Rank[Config["Team2PrettyName"] .. "-SergeantMajor"] = {name = "SergentMajor", model = "models/kriegsyntax/awoi/british/private/playermodel.mdl"}

Rank[Config["Team1PrettyName"] .. "-Lieutenant"] = {name = "Lieutenant", model = "models/kriegsyntax/awoi/rebels/private/playermodel.mdl"}
Rank[Config["Team2PrettyName"] .. "-Lieutenant"] = {name = "Lieutenant", model = "models/kriegsyntax/awoi/british/private/playermodel.mdl"}

Rank[Config["Team1PrettyName"] .. "-Captain"] = {name = "Captain", model = "models/kriegsyntax/awoi/rebels/private/playermodel.mdl"}
Rank[Config["Team2PrettyName"] .. "-Captain"] = {name = "Captain", model = "models/kriegsyntax/awoi/british/private/playermodel.mdl"}

Rank[Config["Team1PrettyName"] .. "-Major"] = {name = "Major", model = "models/kriegsyntax/awoi/rebels/private/playermodel.mdl"}
Rank[Config["Team2PrettyName"] .. "-Major"] = {name = "Major", model = "models/kriegsyntax/awoi/british/private/playermodel.mdl"}






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
	if Config["VoiceActing"] != true then
		return
	end
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
