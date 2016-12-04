DeriveGamemode( "tcf_base" )

GM.Name 	= "Vietnam War RP" -- Rename this to what category you want to show up as under the server browser.
--[[
				SETUP TUTORIAL:
		1. Make sure FolderName config is set properly. VERY IMPORTANT!!!
		2. Configure team names and all the below config stuff.
		3. Go through the file and make sure to update any Location or Objective/TeaCrates related positions for your map you're using.
		4. The gamemode is by default set up for rp_nn_vietnam2.
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
Config["FolderName"] = "vietnam"

-- Configure the gamemode's basics here.
Config["Team1Name"] = "american"
Config["Team2Name"] = "vietcong"
Config["Team1PrettyName"] = "American"
Config["Team2PrettyName"] = "Vietcong"
Config["Team1Icon"] = "materials/gui/american-icon.png"
Config["Team2Icon"] = "materials/gui/vietcong-icon.png"
Config["Team1MenuModel"] = "models/player/kuma/vietnam_us_marine.mdl"
Config["Team2MenuModel"] = "models/player/viet1.mdl"
Config["GM.Team1Color"] = Color( 0, 51, 102, 255 )
Config["GM.Team2Color"] = Color( 102, 0, 0, 255 )
Config["Team1Win"] = "the United States won!"
Config["Team2Win"] = "the Vietcong won!"
Config["TieWin"] = "it's a Tie!"
Config["Team1DefaultPrimary"] = "tfa_m16"
Config["Team1DefaultSecondary"] = "tfa_colt1911"
Config["Team1DefaultMelee"] = "tfa_csgo_bayonet"
Config["Team2DefaultPrimary"] = "tfa_ak74"
Config["Team2DefaultSecondary"] = "tfa_luger"
Config["Team2DefaultMelee"] = "tfa_csgo_gut"
-- Turn this off if you haven't installed custom voice acting for the gamemode. If you've got custom voice acting, such as the sample included with the example ARW setup shown here, feel free to turn it on.
Config["VoiceActing"] = false
Config["WalkSpeed"] = 200
Config["RunSpeed"] = 350
-- Tea Party is themed after Revolutionary War stuff by default. You can use this to re-theme it to whatever you want.
Config["TeaPartyName"] = "Supply Raid"
Config["TeaPartyDescriptionStart"] = "The Vietcong must defend the Weapons Shipments for "
Config["TeaPartyDescriptionFinish"] = " seconds while the United States destroys them!"
Config["TeaPartyCrateModel"] = "models/props/CS_militia/crate_extrasmallmill.mdl"

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
				entname = "tfa_ak74", -- The entity class of the weapon.
				display = "AK-74", -- The display name of the weapon on the loadout screen.
				model = "models/weapons/tfa_w_tct_ak47.mdl", -- The icon model of the weapon on the loadout screen.
				damage = 5, -- This and the following two are purely cosmetic for you to show players the weapon's stats.
				accuracy = 10, -- See above.
				firerate = 1, -- See above.
				level = 0} -- The level required to use the weapon. 0 is always available.
Weapons[2] = {weptype = 1, 
				team = 3, 
				entname = "tfa_fal", 
				display = "FN FAL", 
				model = "models/weapons/tfa_w_fn_fal.mdl", 
				damage = 3, 
				accuracy = 3, 
				firerate = 8, 
				level = 3}
Weapons[3] = {weptype = 1, 
				team = 3, 
				entname = "tfa_thompson", 
				display = "Thompson Machine Gun", 
				model = "models/weapons/tfa_w_tommy_gun.mdl", 
				damage = 3, 
				accuracy = 5, 
				firerate = 1, 
				level = 5}
Weapons[4] = {weptype = 1, 
				team = 3, 
				entname = "tfa_dbarrel", 
				display = "Double Barrel Shotgun", 
				model = "models/weapons/w_double_barrel_shotgun.mdl", 
				damage = 3, 
				accuracy = 5, 
				firerate = 1, 
				level = 7}
Weapons[5] = {weptype = 1, 
				team = 3, 
				entname = "tfa_pkm", 
				display = "PKM", 
				model = "models/weapons/tfa_w_mach_russ_pkm.mdl", 
				damage = 3, 
				accuracy = 5, 
				firerate = 1, 
				level = 9}
Weapons[6] = {weptype = 1, 
				team = 3, 
				entname = "tfa_svt40", 
				display = "SVT 40", 
				model = "models/weapons/tfa_w_svt_40.mdl", 
				damage = 3, 
				accuracy = 5, 
				firerate = 1, 
				level = 11}
Weapons[7] = {weptype = 1, 
				team = 3, 
				entname = "tfa_dragunov", 
				display = "SVD Dragunov", 
				model = "models/weapons/w_svd_dragunov.mdl", 
				damage = 3, 
				accuracy = 5, 
				firerate = 1, 
				level = 13}

Weapons[8] = {weptype = 1, 
				team = 2, 
				entname = "tfa_m16", 
				display = "M16", 
				model = "models/weapons/w_rif_nam.mdl", 
				damage = 5, 
				accuracy = 10, 
				firerate = 1, 
				level = 0}
Weapons[9] = {weptype = 1, 
				team = 2, 
				entname = "tfa_m14sp", 
				display = "M14", 
				model = "models/weapons/tfa_w_snip_m14sp.mdl", 
				damage = 3, 
				accuracy = 3,
				firerate = 8, 
				level = 3}
Weapons[10] = {weptype = 1, 
				team = 2, 
				entname = "tfa_sten", 
				display = "STEN", 
				model = "models/weapons/tfa_w_sten.mdl", 
				damage = 3, 
				accuracy = 5, 
				firerate = 1, 
				level = 5}
Weapons[11] = {weptype = 1, 
				team = 2, 
				entname = "tfa_thompson", 
				display = "Thompson Machine Gun", 
				model = "models/weapons/tfa_w_tommy_gun.mdl", 
				damage = 5, 
				accuracy = 10, 
				firerate = 1, 
				level = 7}
Weapons[12] = {weptype = 1, 
				team = 2, 
				entname = "tfa_uzi", 
				display = "UZI", 
				model = "models/weapons/tfa_w_uzi_imi.mdl", 
				damage = 3, 
				accuracy = 3,
				firerate = 8, 
				level = 9}
Weapons[13] = {weptype = 1, 
				team = 2, 
				entname = "tfa_ithacam37", 
				display = "Ithaca M37", 
				model = "models/weapons/tfa_w_ithaca_m37.mdl", 
				damage = 3, 
				accuracy = 5, 
				firerate = 1, 
				level = 11}
Weapons[14] = {weptype = 1, 
				team = 2, 
				entname = "tfa_remington870", 
				display = "Remington 870", 
				model = "models/weapons/tfa_w_remington_870_tact.mdl", 
				damage = 5, 
				accuracy = 10, 
				firerate = 1, 
				level = 13}
Weapons[15] = {weptype = 1, 
				team = 2, 
				entname = "tfa_1897winchester", 
				display = "Winchester 1897", 
				model = "models/weapons/tfa_w_winchester_1897_trench.mdl", 
				damage = 3, 
				accuracy = 3,
				firerate = 8, 
				level = 15}
Weapons[16] = {weptype = 1, 
				team = 2, 
				entname = "tfa_m60", 
				display = "M60", 
				model = "models/weapons/tfa_w_m60_machine_gun.mdl", 
				damage = 3, 
				accuracy = 5, 
				firerate = 1, 
				level = 17}
Weapons[17] = {weptype = 1, 
				team = 2, 
				entname = "tfa_m1918bar", 
				display = "M1918 BAR", 
				model = "models/weapons/w_m1918_bar.mdl", 
				damage = 5, 
				accuracy = 10, 
				firerate = 1, 
				level = 21}

Weapons[18] = {weptype = 2, 
				team = 3, 
				entname = "tfa_luger", 
				display = "P08 Luger", 
				model = "models/weapons/tfa_w_luger_p08.mdl", 
				damage = 5, 
				accuracy = 10, 
				firerate = 1, 
				level = 0}
Weapons[19] = {weptype = 2, 
				team = 3, 
				entname = "tfa_model3russian", 
				display = "S&W Model 3 Russian", 
				model = "models/weapons/tfa_w_model_3_rus.mdl", 
				damage = 3, 
				accuracy = 3, 
				firerate = 8, 
				level = 3}
Weapons[20] = {weptype = 2, 
				team = 3, 
				entname = "tfa_model627", 
				display = "S&W Model 627", 
				model = "models/weapons/tfa_w_sw_model_627.mdl", 
				damage = 3, 
				accuracy = 5, 
				firerate = 1, 
				level = 5}

Weapons[21] = {weptype = 2, 
				team = 3, 
				entname = "tfa_tfap_dmaka", 
				display = "Dual Makarov PMs", 
				model = "models/weapons/w_tfap_dmaka.mdl", 
				damage = 3, 
				accuracy = 5, 
				firerate = 1, 
				level = 7}

Weapons[22] = {weptype = 2, 
				team = 3, 
				entname = "tfa_deagle", 
				display = "Desert Eagle", 
				model = "models/weapons/tfa_w_tcom_deagle.mdl", 
				damage = 3, 
				accuracy = 5, 
				firerate = 1, 
				level = 9}
				
Weapons[23] = {weptype = 2, 
				team = 2, 
				entname = "tfa_colt1911", 
				display = "M1911", 
				model = "models/weapons/tfa_w__dmgf_co1911.mdl", 
				damage = 5, 
				accuracy = 10, 
				firerate = 1, 
				level = 0}
Weapons[24] = {weptype = 2, 
				team = 2, 
				entname = "tfa_coltpython", 
				display = "Colt Python", 
				model = "models/weapons/tfa_w_colt_python.mdl", 
				damage = 3, 
				accuracy = 3, 
				firerate = 8, 
				level = 3}
Weapons[25] = {weptype = 2, 
				team = 2, 
				entname = "tfa_model500", 
				display = "S&W Model 500", 
				model = "models/weapons/tfa_w_sw_model_500.mdl", 
				damage = 3, 
				accuracy = 5, 
				firerate = 1, 
				level = 5}

				
-- Spawn locations for both teams during all 3 round types.
Location = {}
	
Location[Config["Team1PrettyName"] .. "-spawn"] = {pos = Vector(-5871.654297, 7516.008301, -1684.170898)}
Location[Config["Team2PrettyName"] .. "-spawn"] = {pos = Vector(6670.944824, -9335.085938, -1625.492920)}

Location[Config["Team1PrettyName"] .. "-prep"] = {pos = Vector(-5157.967285, 8037.030273, -1684.260864)}
Location[Config["Team2PrettyName"] .. "-prep"] = {pos = Vector(4399.638672, -8603.383789, -1676.277710)}

Location[Config["Team1PrettyName"] .. "-Fight"] = {pos = Vector(-2117.828369, 6218.711914, -1690.270508)}
Location[Config["Team2PrettyName"] .. "-Fight"] = {pos = Vector(4772.946777, -7500.398926, -1692.193848)}

-- The King of The Hill capture point's location.
Location["KOTH"] = {pos = Vector(4691.348633, 5451.136230, -1692.217651)}

-- Currently unused. Feel free to ignore.
Location["Paper"] = {pos = Vector(-790.058105, -45.686008, 213.875656)}

-- All the objectives for Capture Points. Feel free to add/remove as many as you like, as long as there is at least one on the map.
Objectives = {}
Objectives[2] = {pos = Vector(4691.348633, 5451.136230, -1692.217651), letter = "A"}
Objectives[1] = {pos = Vector(4740.453613, -2990.869629, -1708.269043), letter = "B"}
Objectives[3] = {pos = Vector(1906.654175, 8093.217773, -1692.223511), letter = "C"}

TeaCrates = {}
-- All the objectives for Tea Party(or whatever you rename it). Feel free to add/remove as many as you like, as long as there is at least one on the map.
TeaCrates[1] = {pos = Vector(4912.886719, -2903.359619, -1708.266602)}
TeaCrates[2] = {pos = Vector(4916.408203, -3122.998779, -1708.159058)}
TeaCrates[3] = {pos = Vector(4626.555176, -3014.354492, -1708.156616)}

TeaCrates[4] = {pos = Vector(4994.906738, -321.208679, -1692.209717)}
TeaCrates[5] = {pos = Vector(4747.408203, -250.036713, -1692.251831)}
TeaCrates[6] = {pos = Vector(4782.194336, -33.231884, -1692.217896)}

TeaCrates[7] = {pos = Vector(3879.020508, 1414.724487, -1692.223633)}
TeaCrates[8] = {pos = Vector(3847.974121, 1062.530273, -1692.193115)}
TeaCrates[9] = {pos = Vector(3976.565918, 877.016357, -1692.255371)}

TeaCrates[10] = {pos = Vector(5181.037598, 4852.590332, -1692.183716)}
TeaCrates[11] = {pos = Vector(5256.152832, 5058.269531, -1692.152954)}
TeaCrates[12] = {pos = Vector(5052.517578, 5229.719238, -1692.155273)}

TeaCrates[13] = {pos = Vector(4184.304688, 6014.091309, -1692.184448)}
TeaCrates[14] = {pos = Vector(4188.718262, 5850.924316, -1692.281250)}
TeaCrates[15] = {pos = Vector(4011.644531, 5785.638672, -1692.281860)}

TeaCrates[16] = {pos = Vector(3771.544189, 4998.338379, -1692.276611)}
TeaCrates[17] = {pos = Vector(3653.063965, 5228.243652, -1692.274902)}
TeaCrates[18] = {pos = Vector(3487.616699, 5119.355957, -1692.248901)}

TeaCrates[19] = {pos = Vector(1199.858276, -1209.986084, -1164.475220)}
TeaCrates[20] = {pos = Vector(1183.060669, -1058.504761, -1155.125977)}
TeaCrates[21] = {pos = Vector(1411.714600, -874.873047, -1190.050171)}

Rank = {}
-- Ensure these playermodels are set to the ones you want to use for gameplay.
Rank[Config["Team1PrettyName"] .. "-Private"] = {name = "Private", model = "models/player/kuma/vietnam_us_marine.mdl"}
Rank[Config["Team2PrettyName"] .. "-Private"] = {name = "Private", model = "models/player/viet1.mdl"}

Rank[Config["Team1PrettyName"] .. "-Corporal"] = {name = "Corporal", model = "models/player/kuma/vietnam_us_marine.mdl"}
Rank[Config["Team2PrettyName"] .. "-Corporal"] = {name = "Corporal", model = "models/player/viet1.mdl"}

Rank[Config["Team1PrettyName"] .. "-Sergeant"] = {name = "Sergent", model = "models/player/kuma/vietnam_us_marine.mdl"}
Rank[Config["Team2PrettyName"] .. "-Sergeant"] = {name = "Sergent", model = "models/player/vietcong04.mdl"}

Rank[Config["Team1PrettyName"] .. "-SergeantMajor"] = {name = "SergentMajor", model = "models/player/kuma/vietnam_us_marine.mdl"}
Rank[Config["Team2PrettyName"] .. "-SergeantMajor"] = {name = "SergentMajor", model = "models/player/vietcong04.mdl"}

Rank[Config["Team1PrettyName"] .. "-Lieutenant"] = {name = "Lieutenant", model = "models/player/kuma/vietnam_us_marine.mdl"}
Rank[Config["Team2PrettyName"] .. "-Lieutenant"] = {name = "Lieutenant", model = "models/player/vietcong05.mdl"}

Rank[Config["Team1PrettyName"] .. "-Captain"] = {name = "Captain", model = "models/player/kuma/vietnam_us_marine.mdl"}
Rank[Config["Team2PrettyName"] .. "-Captain"] = {name = "Captain", model = "models/player/vietcong03.mdl"}

Rank[Config["Team1PrettyName"] .. "-Major"] = {name = "Major", model = "models/player/kuma/vietnam_us_marine.mdl"}
Rank[Config["Team2PrettyName"] .. "-Major"] = {name = "Major", model = "models/player/vietcong01.mdl"}


team.SetUp( 1, "Undecieded", Color( 0, 204, 0, 255 ) ) 
team.SetUp( 2, Config["Team1PrettyName"], Config["GM.Team1Color"] ) 
team.SetUp( 3, Config["Team2PrettyName"], Config["GM.Team2Color"] ) 