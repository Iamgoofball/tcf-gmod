
AddCSLuaFile( "cl_init.lua" )

include( "shared.lua" )

include( "resources.lua" )

AddCSLuaFile( "shared.lua" )

MsgN("_-_-_-_- Server Files -_-_-_-_")
MsgN("Loading Server Files")
for _, file in pairs (file.Find(Config["FolderName"] .. "/gamemode/server/*.lua", "LUA")) do
   MsgN("-> "..file)
   include(Config["FolderName"] .. "/gamemode/server/"..file) 
end

MsgN("_-_-_-_- Shared Files -_-_-_-_")
MsgN("Loading Shared Files")
for _, file in pairs (file.Find(Config["FolderName"] .. "/gamemode/shared/*.lua", "LUA")) do
   MsgN("-> "..file)
   AddCSLuaFile(Config["FolderName"] .. "/gamemode/shared/"..file)
end

MsgN("_-_-_-_- Client Files -_-_-_-_")
MsgN("Loading Client Files")
for _, file in pairs (file.Find(Config["FolderName"] .. "/gamemode/client/*.lua", "LUA")) do
   MsgN("-> "..file)
   AddCSLuaFile(Config["FolderName"] .. "/gamemode/client/"..file)
end


function GM:Initialize()

   util.AddNetworkString( 'open_teammenu' )
   util.AddNetworkString( 'open_settings' )
   util.AddNetworkString( 'open_tutorial' )
   util.AddNetworkString( 'open_loadout' )
   util.AddNetworkString( 'SetTeam' )
   util.AddNetworkString( 'playsong' )

   
   SetGlobalInt( "GameState", 1 ) -- 1/rest 2/prep 3/battle
   SetGlobalInt( "StateStartTime", RealTime())
   SetGlobalString( "GameTypeSelected", nil)
   
end

---------------------------------------------------------------------------------
--///							  Round System								\\\--
---------------------------------------------------------------------------------
local round = {}

-- Variables
round.PrepTime	= 30	-- 30 second prep
round.Rest	= Config["RestTime"]	-- 30 second breaks
round.Time	= Config["RoundTime"]	-- 5 minute rounds

function round.Broadcast(Text)

	for k, v in pairs(player.GetAll()) do
	
		v:SendLua("GAMEMODE:AddNotify(\""..Text.."\", NOTIFY_GENERIC, 10)")
		
	end
	
	print(Text)
	
end

function round.RestTime()
	SetGlobalEntity("Team2VIP", nil)
	SetGlobalEntity("Team1VIP", nil)
	SetGlobalInt( "GameState", 1 )
	SetGlobalInt( "StateStartTime", RealTime())
	SetGlobalInt( "StateEndTime", round.Rest)

	local Players = player.GetAll()
	
	for i = 1, table.Count(Players) do
	
		local ply = Players[i]
		
		if team.GetName( ply:Team() ) != "Undecieded" then
		
			round.LoadoutSpawning( ply )
			
			if team.GetName(ply:Team()) == Config["Team2PrettyName"] then
			
				ply:SetPos(Vector(8888.750977, 2070.588867, 195.946396))
				
				if ply:GetPos() != Vector(8888.750977, 2070.588867, 195.946396) then
				
					print("FUCK")
					ply:SetPos(Vector(8888.750977, 2070.588867, 195.946396))
					
				end
				
			elseif team.GetName(ply:Team()) == Config["Team1PrettyName"] then
			
				ply:SetPos(Vector(-7397.078613, -1323.084473, 196.989029))
				
				if ply:GetPos() != Vector(-7397.078613, -1323.084473, 196.989029) then
				
					print("FUCK")
					ply:SetPos(Vector(-7397.078613, -1323.084473, 196.989029))
					
				end
				
			end
			
		end
		
	end
	
	local victory_for_freedom = 0
	local victory_for_imperialism = 0
	local who_won = "Tie"
	
	if GetGlobalString("GameTypeSelected") == GameType[1].name then
	
		victory_for_freedom = GetGlobalInt("AmericanKills")
		victory_for_imperialism = GetGlobalInt("BritishKills")
	elseif GetGlobalString("GameTypeSelected") == GameType[4].name then
		if GetGlobalInt("TeaCratesLeft") != 0 then
			victory_for_imperialism = 1
		else
			victory_for_freedom = 1
		end
	else
	
		for k,v in pairs(ents.GetAll()) do

			if string.find(v:GetClass(), "farm_objective") then
			
				if v:GetControlTeam() == Config["Team1PrettyName"] then
				
					victory_for_freedom = victory_for_freedom + 1
					
				elseif v:GetControlTeam() == Config["Team2PrettyName"] then
				
					victory_for_imperialism = victory_for_imperialism + 1
					
				end
				
			end
			
		end
		
	end
	
	if victory_for_freedom > victory_for_imperialism then

		who_won = Config["Team1Win"]
		
		for k,v in pairs(player.GetAll()) do
	
			if v:Team() == 2 then
			
				v:AddExp(Config["round-exp-reward"])
				v:AddMoney(Config["round-cash-reward"])
				v:AddTicket(1)
				v:SendLua("surface.PlaySound('soundtrack/victory.wav')")
				
			elseif v:Team() == 3 then
			
				v:SendLua("surface.PlaySound('soundtrack/lossnew.wav')")
				
			end

		end
		if Config["VoiceActing"] == true then
			local freedom_fighters = {}
			local the_empire = {}
			local chosen_rebel
			local chosen_brit
			for k,v in pairs(player.GetAll()) do
				if team.GetName(v:Team()) == Config["Team2PrettyName"] then
					table.insert(the_empire, v)
				elseif team.GetName(v:Team()) == Config["Team1PrettyName"] then
					table.insert(freedom_fighters, v)
				end
			end
			chosen_brit = table.Random(the_empire)
			chosen_rebel = table.Random(freedom_fighters)
			local sounds_b = {1,4}
			local sounds_r = {1,6}
			chosen_brit:EmitSound("voice/" .. Config["Team2Name"] .. "/jeers/" .. Config["Team2Name"] .. "-jeers-"..table.Random(sounds_b)..".wav")
			chosen_rebel:EmitSound("voice/" .. Config["Team1Name"] .. "/cheers/" .. Config["Team1Name"] .. "-cheers-"..table.Random(sounds_r)..".wav")
		end
	elseif victory_for_imperialism > victory_for_freedom then
	
		who_won = Config["Team2Win"]
		
		for k,v in pairs(player.GetAll()) do
	
			if v:Team() == 3 then
			
				v:AddExp(Config["round-exp-reward"])
				v:AddMoney(Config["round-cash-reward"])
				v:AddTicket(1)
				v:SendLua("surface.PlaySound('soundtrack/victory.wav')")
				
			elseif v:Team() == 2 then
				v:SendLua("surface.PlaySound('soundtrack/lossnew.wav')")
				
			end
			
		end

		if Config["VoiceActing"] == true then
			local freedom_fighters = {}
			local the_empire = {}
			local chosen_rebel
			local chosen_brit
			for k,v in pairs(player.GetAll()) do
				if team.GetName(v:Team()) == Config["Team2PrettyName"] then
					table.insert(the_empire, v)
				elseif team.GetName(v:Team()) == Config["Team1PrettyName"] then
					table.insert(freedom_fighters, v)
				end
			end
			chosen_brit = table.Random(the_empire)
			chosen_rebel = table.Random(freedom_fighters)
			local sounds_b = {1,2}
			local sounds_r = {1,8}
			chosen_brit:EmitSound("voice/" .. Config["Team2Name"] .. "/cheers/" .. Config["Team2Name"] .. "-cheers-"..table.Random(sounds_b)..".wav")
			chosen_rebel:EmitSound("voice/" .. Config["Team1Name"] .. "/jeers/" .. Config["Team1Name"] .. "-taunt-"..table.Random(sounds_r)..".wav")
		end
	elseif victory_for_freedom == victory_for_imperialism then
	
		who_won = Config["TieWin"]
		
		for k,v in pairs(player.GetAll()) do
			
			if v:Team() != 1 then
			
				v:AddExp(Config["round-exp-reward"] / 2)
				v:AddMoney(Config["round-cash-reward"])
				v:AddTicket(1)
				
				round.PlaySong("soundtrack/lossnew.wav") -- both sides lost
				
			end
			
		end
		if Config["VoiceActing"] == true then
			local freedom_fighters = {}
			local the_empire = {}
			local chosen_rebel
			local chosen_brit
			for k,v in pairs(player.GetAll()) do
				if team.GetName(v:Team()) == Config["Team2PrettyName"] then
					table.insert(the_empire, v)
				elseif team.GetName(v:Team()) == Config["Team1PrettyName"] then
					table.insert(freedom_fighters, v)
				end
			end
			chosen_brit = table.Random(the_empire)
			chosen_rebel = table.Random(freedom_fighters)
			local sounds_b = {1,4}
			local sounds_r = {1,8}
			chosen_brit:EmitSound("voice/" .. Config["Team2Name"] .. "/jeers/" .. Config["Team2Name"] .. "-jeers-"..table.Random(sounds_b)..".wav")
			chosen_rebel:EmitSound("voice/" .. Config["Team1Name"] .. "/jeers/" .. Config["Team1Name"] .. "-taunt-"..table.Random(sounds_r)..".wav")
		end
	end
	
	for k,v in pairs(ents.GetAll()) do
	
		if string.find(v:GetClass(), "farm_objective") or string.find(v:GetClass(), "barricade") or string.find(v:GetClass(), "tea_objective") then
		
			v:Remove()
			
		end
		
	end
	
	round.Broadcast("Round over, " .. who_won .. " Next round in " .. round.Rest .. " seconds!")
	
end

function round.Prep()

	SetGlobalInt( "GameState", 2 )
	SetGlobalInt( "StateStartTime", RealTime())
	SetGlobalInt( "StateEndTime", round.PrepTime)

	local Players = player.GetAll()
	
	for i = 1, table.Count(Players) do
		
		local ply = Players[i]
		if team.GetName( ply:Team() ) != "Undecieded" then
		
			round.LoadoutSpawning( ply )

			net.Start( "playsong" )
		
				net.WriteString("soundtrack/prep_phasenew2.wav") 
		
			net.Broadcast()
			
			if !ply:IsBot() then
				ply:ConCommand("loadout")
				
			end
			
			if team.GetName(ply:Team()) == Config["Team2PrettyName"] then
			
				ply:SetPos(Vector(4873.492188, -150.858917, 205.890381))
				
				if ply:GetPos() != Vector(4873.492188, -150.858917, 205.890381) then
				
					print("FUCK")
					ply:SetPos(Vector(4873.492188, -150.858917, 205.890381))
					
				end
				
			elseif team.GetName(ply:Team()) == Config["Team1PrettyName"] then
			
				ply:SetPos(Vector(-3930.692627, 525.278259, 193.856583))
				
				if ply:GetPos() != Vector(-3930.692627, 525.278259, 193.856583) then
				
					print("FUCK")
					ply:SetPos(Vector(-3930.692627, 525.278259, 193.856583))
					
				end
				
			end
			
		end
		
	end
	
	round.Broadcast("Get prepared! Round starts in " .. round.PrepTime .. " seconds!")
	
	--timer.Simple(round.PrepTime, round.CapturePoint)
	
end

-- note only if 4 players or more do objectives

-- Gamemode types --
function round.CapturePoint()

	SetGlobalInt( "GameState", 3 )
	SetGlobalInt( "StateStartTime", RealTime())
	SetGlobalInt( "StateEndTime", round.Time)
	SetGlobalString("GameTypeSelected", "Resting")
	local Players = player.GetAll()
	
	for i = 1, table.Count(Players) do
	
		local ply = Players[i]
		
		if team.GetName( ply:Team() ) != "Undecieded" then
		
			round.LoadoutSpawning( ply )
			
			if team.GetName(ply:Team()) == Config["Team2PrettyName"] then
			
				ply:SetPos(Vector(3045.126953, -146.878693, 284.796997))
				
				if ply:GetPos() != Vector(3045.126953, -146.878693, 284.796997) then
				
					print("FUCK")
					ply:SetPos(Vector(3045.126953, -146.878693, 284.796997))
					
				end
				
			elseif team.GetName(ply:Team()) == Config["Team1PrettyName"] then
			
				ply:SetPos(Vector(-3001.453369, 598.242676, 284.071167))
				
				if ply:GetPos() != Vector(-3001.453369, 598.242676, 284.071167) then
				
					print("FUCK")
					ply:SetPos(Vector(-3001.453369, 598.242676, 284.071167))
					
				end
				
			end
			
		end
		
	end
	if GetGlobalInt("GameType1votes") == 0 and GetGlobalInt("GameType2votes") == 0 and GetGlobalInt("GameType3votes") == 0 and GetGlobalInt("GameType4votes") == 0 and GetGlobalInt("GameType5votes") == 0 then
		SetGlobalString("GameTypeSelected", table.Random({GameType[1].name,GameType[2].name,GameType[3].name,GameType[4].name,GameType[5].name}))
	else
		local highest_value = 0
		highest_value = GetGlobalInt("GameType1votes")
		SetGlobalString("GameTypeSelected", GameType[1].name)
		if GetGlobalInt("GameType2votes") > highest_value then
			highest_value = GetGlobalInt("GameType2votes")
			SetGlobalString("GameTypeSelected", GameType[2].name)
		end
		if GetGlobalInt("GameType3votes") > highest_value then
			highest_value = GetGlobalInt("GameType3votes")
			SetGlobalString("GameTypeSelected", GameType[3].name)
		end
		if GetGlobalInt("GameType4votes") > highest_value then
			highest_value = GetGlobalInt("GameType4votes")
			SetGlobalString("GameTypeSelected", GameType[4].name)
		end
		if GetGlobalInt("GameType5votes") > highest_value then
			highest_value = GetGlobalInt("GameType5votes")
			SetGlobalString("GameTypeSelected", GameType[5].name)
		end
		if GetGlobalInt("GameType6votes") > highest_value then
			highest_value = GetGlobalInt("GameType6votes")
			SetGlobalString("GameTypeSelected", GameType[6].name)
		end
	end
	if GetGlobalString("GameTypeSelected") == GameType[6].name then
		SetGlobalString("GameTypeSelected", table.Random({GameType[1].name,GameType[2].name,GameType[3].name,GameType[4].name,GameType[5].name}))
	end
	round.Broadcast(GetGlobalString("GameTypeSelected"))
	SetGlobalInt("GameType1votes", 0)
	SetGlobalInt("GameType2votes", 0)
	SetGlobalInt("GameType3votes", 0)
	SetGlobalInt("GameType4votes", 0)
	SetGlobalInt("GameType5votes", 0)
	--SetGlobalInt("GameType6votes", 0)
	
	if GetGlobalString("GameTypeSelected") == GameType[2].name then
	
		for i=1, #Objectives do
		
			local objective = ents.Create( "farm_objective" )
			if ( !IsValid( objective ) ) then print("objective"..i.." spawning failed") return end 
			objective:SetPos( Objectives[i].pos )
			objective:Spawn()
			objective:DropToFloor()
			objective:SetLetter(Objectives[i].letter)
			print("objective"..i.." spawned")
			
		end

		local barricade = ents.Create( "barricade" )
	
		if ( !IsValid( barricade ) ) then print("barricade spawning failed") return end 
		barricade:SetPos( Location["Barricade"].pos )
		barricade:Spawn()
		barricade:DropToFloor()
		print("barricade spawned")
			
		for k,v in pairs(ents.GetAll()) do
			if string.find(v:GetClass(), "farm_objective") then
				v:SetControlTeam("Neutral")
			end
		end
		
		round.Broadcast("You have " .. round.Time .. " seconds to capture and hold all the objectives!")
		
	elseif GetGlobalString("GameTypeSelected") == GameType[3].name then
	
		local objective = ents.Create( "farm_objective" )
		
		if ( !IsValid( objective ) ) then print("koth spawning failed") return end 
		objective:SetPos( Location["KOTH"].pos )
		objective:Spawn()
		objective:DropToFloor()
		objective:SetLetter("A")
		objective:SetControlTeam("Neutral")
		
		round.Broadcast("Be the King of the Hill after " .. round.Time .. " seconds!")

	elseif GetGlobalString("GameTypeSelected") == GameType[4].name then
	
		for i=1, #TeaCrates do
		
			local crate = ents.Create( "tea_objective" )
			if ( !IsValid( crate ) ) then print("crate"..i.." spawning failed") return end 
			crate:SetPos( TeaCrates[i].pos )
			crate:Spawn()
			crate:SetModel(Config["TeaPartyCrateModel"])
			crate:DropToFloor()
			print("crate"..i.." spawned")
			
		end
		SetGlobalInt("TeaCratesLeft", 0)
		for k,v in pairs(ents.GetAll()) do
			if string.find(v:GetClass(), "tea_objective") then
				SetGlobalInt( "TeaCratesLeft", GetGlobalInt("TeaCratesLeft") + 1)
			end
		end
		
		round.Broadcast(Config["TeaPartyDescriptionStart"] .. round.Time .. Config["TeaPartyDescriptionFinish"])

	--[[elseif GetGlobalString("GameTypeSelected") == GameType[5].name then
	
		local objective = ents.Create( "paper_spawner" )
		
		if ( !IsValid( objective ) ) then print("paper spawning failed") return end 
		objective:SetPos( Location["Paper"].pos )
		objective:Spawn()
		objective:DropToFloor()
		SetGlobalInt("BritishPapers", 0)
		SetGlobalInt("AmericanPapers", 0)
		
		round.Broadcast("Grab copies of The Federalist Papers and take them back to your base for the next " .. round.Time .. " seconds!")]]--
		

	elseif GetGlobalString("GameTypeSelected") == GameType[5].name then
	
		for i=1, #Objectives do
		
			local objective = ents.Create( "farm_objective" )
			if ( !IsValid( objective ) ) then print("objective"..i.." spawning failed") return end 
			objective:SetPos( Objectives[i].pos )
			objective:Spawn()
			objective:DropToFloor()
			objective:SetLetter(Objectives[i].letter)
			print("objective"..i.." spawned")
			
		end
		local freedom_fighters = {}
		local the_empire = {}
		for k,v in pairs(player.GetAll()) do
			if team.GetName(v:Team()) == Config["Team2PrettyName"] then
				table.insert(the_empire, v)
			elseif team.GetName(v:Team()) == Config["Team1PrettyName"] then
				table.insert(freedom_fighters, v)
			end
		end
		SetGlobalEntity("Team2VIP", table.Random(the_empire))
		SetGlobalEntity("Team1VIP", table.Random(freedom_fighters))
		round.Broadcast(GetGlobalEntity("Team2VIP"):Name() .. " is the British Commander!")
		round.Broadcast(GetGlobalEntity("Team1VIP"):Name() .. " is the Rebel Commander!")
		round.Broadcast("Protect your marked Commander while he captures points for " .. round.Time .. " seconds!")
		

		
	elseif GetGlobalString("GameTypeSelected") == GameType[1].name then
	
		SetGlobalInt( "BritishKills", 0)
		SetGlobalInt( "AmericanKills", 0)
		round.Broadcast("Get the most kills for your team within " .. round.Time .. " seconds!")
		
	end
	
	for k,v in pairs(ents.GetAll()) do
	
		if string.find(v:GetClass(), "prop_ragdoll") then
		
			v:Remove()
			
		end
		
	end
	
	for i=1,#GameType do
		SetGlobalInt( "GameType"..i.."votes", 0 )
	end
	
end

function GM:Think()

	SetGlobalInt("CurrentServerRealTime", RealTime())

	if GetGlobalString("GameTypeSelected") == GameType[4].name then
		if GetGlobalInt("GameState") == 3 then
			local tea_crates = 0
			for k,v in pairs(ents.GetAll()) do
				if string.find(v:GetClass(), "tea_objective") then
					tea_crates = tea_crates + 1
				end
			end
			SetGlobalInt( "TeaCratesLeft", tea_crates)
			if tea_crates == 0 then
				if round.CantProgress() != true then
					round.RestTime()
					SetGlobalString("GameTypeSelected", "N/A")
					SetGlobalEntity("Team2VIP", nil)
					SetGlobalEntity("Team1VIP", nil)
				end
			end
		end
	elseif GetGlobalString("GameTypeSelected") == GameType[5].name then
		if GetGlobalEntity("Team2VIP"):IsValid() != true or GetGlobalEntity("Team1VIP"):IsValid() != true then
			local freedom_fighters = {}
			local the_empire = {}
			for k,v in pairs(player.GetAll()) do
				if team.GetName(v:Team()) == Config["Team2PrettyName"] then
					table.insert(the_empire, v)
				elseif team.GetName(v:Team()) == Config["Team1PrettyName"] then
					table.insert(freedom_fighters, v)
				end
			end
			if GetGlobalEntity("Team2VIP"):IsValid() != true then
				SetGlobalEntity("Team2VIP", table.Random(the_empire))
				if GetGlobalEntity("Team2VIP"):IsValid() == true then
					round.Broadcast(GetGlobalEntity("Team2VIP"):Name() .. " is the new British Commander!")
				end
			end
			if GetGlobalEntity("Team1VIP"):IsValid() != true then
				SetGlobalEntity("Team1VIP", table.Random(freedom_fighters))
				if GetGlobalEntity("Team1VIP"):IsValid() == true then
					round.Broadcast(GetGlobalEntity("Team1VIP"):Name() .. " is the new Rebel Commander!")
				end
			end
		end
	end
	if round.CantProgress() != true then
	
		round.CheckRound()
		
	end
	
end

function round.CantProgress()

	local players_in_britbong_land = 0
	local players_in_freedom_land = 0

	local Players = player.GetAll()
	
	for i = 1, table.Count(Players) do
	
		local ply = Players[i]
		
		if team.GetName( ply:Team() ) == Config["Team1PrettyName"] then
		
			players_in_freedom_land = players_in_freedom_land + 1
			
		elseif team.GetName( ply:Team() ) == Config["Team2PrettyName"] then
		
			players_in_britbong_land = players_in_britbong_land + 1
			
		end
		
	end
	
	if players_in_britbong_land >= 1 && players_in_freedom_land >= 1 then
	
		return false
		
	else
	
		return true
		
	end
	
end

function round.CheckRound()

	if GetGlobalInt("GameState") == 1 then
	
		if (RealTime() - GetGlobalInt("StateStartTime")) > round.Rest then
		
			round.Prep()
			
		end
		
	elseif GetGlobalInt("GameState") == 2 then
	
		if (RealTime() - GetGlobalInt("StateStartTime")) > round.PrepTime then
		
			round.CapturePoint()
			if Config["VoiceActing"] == true then
				round.PrepLines()
			end
			
		end
		
	elseif GetGlobalInt("GameState") == 3 then
	
		if (RealTime() - GetGlobalInt("StateStartTime")) > round.Time then
			round.RestTime()
			SetGlobalString("GameTypeSelected", "N/A")
			SetGlobalEntity("Team2VIP", nil)
			SetGlobalEntity("Team1VIP", nil)
			
		end
		
		if (RealTime() - GetGlobalInt("StateStartTime")) == (round.Time - 30) then
		
			round.PlaySong("soundtrack/last_30_secondsnew.wav")
			
		end
		
	end
	
end

function round.PlaySong(a)
	
	net.Start( "playsong" )
		
		net.WriteString( a ) 
		
	net.Broadcast()
	
end

function round.PrepLines()
	local freedom_fighters = {}
	local the_empire = {}
	local chosen_rebel
	local chosen_brit
	for k,v in pairs(player.GetAll()) do
		if team.GetName(v:Team()) == Config["Team2PrettyName"] then
			table.insert(the_empire, v)
		elseif team.GetName(v:Team()) == Config["Team1PrettyName"] then
			table.insert(freedom_fighters, v)
		end
	end
	chosen_brit = table.Random(the_empire)
	chosen_rebel = table.Random(freedom_fighters)
	if GetGlobalString("GameTypeSelected") == GameType[1].name then
		print("1 voice")
		local sounds_b = {7,8}
		local sounds_r = {9,10}
		chosen_brit:EmitSound("voice/" .. Config["Team2Name"] .. "/objective/" .. Config["Team2Name"] .. "-objective_specific-"..table.Random(sounds_b)..".wav")
		chosen_rebel:EmitSound("voice/" .. Config["Team1Name"] .. "/objective/" .. Config["Team1Name"] .. "-objectivespecific-"..table.Random(sounds_r)..".wav")
	elseif GetGlobalString("GameTypeSelected") == GameType[2].name then
		print("2 voice")
		local sounds_b = {10}
		local sounds_r = {11}
		chosen_brit:EmitSound("voice/" .. Config["Team2Name"] .. "/objective/" .. Config["Team2Name"] .. "-objective_specific-"..table.Random(sounds_b)..".wav")
		chosen_rebel:EmitSound("voice/" .. Config["Team1Name"] .. "/objective/" .. Config["Team1Name"] .. "-objectivespecific-"..table.Random(sounds_r)..".wav")
	elseif GetGlobalString("GameTypeSelected") == GameType[3].name then
		print("3 voice")
		local sounds_b = {5,6}
		local sounds_r = {3,6}
		chosen_brit:EmitSound("voice/" .. Config["Team2Name"] .. "/objective/" .. Config["Team2Name"] .. "-objective_specific-"..table.Random(sounds_b)..".wav")
		chosen_rebel:EmitSound("voice/" .. Config["Team1Name"] .. "/objective/" .. Config["Team1Name"] .. "-objectivespecific-"..table.Random(sounds_r)..".wav")
	elseif GetGlobalString("GameTypeSelected") == GameType[4].name then
		print("4 voice")
		local sounds_b = {3,4}
		local sounds_r = {1,4,8}
		chosen_brit:EmitSound("voice/" .. Config["Team2Name"] .. "/objective/" .. Config["Team2Name"] .. "-objective_specific-"..table.Random(sounds_b)..".wav")
		chosen_rebel:EmitSound("voice/" .. Config["Team1Name"] .. "/objective/" .. Config["Team1Name"] .. "-objectivespecific-"..table.Random(sounds_r)..".wav")
	elseif GetGlobalString("GameTypeSelected") == GameType[5].name then
		print("5 voice")
		local sounds_b = {9}
		local sounds_r = {12}
		chosen_brit:EmitSound("voice/" .. Config["Team2Name"] .. "/objective/" .. Config["Team2Name"] .. "-objective_specific-"..table.Random(sounds_b)..".wav")
		chosen_rebel:EmitSound("voice/" .. Config["Team1Name"] .. "/objective/" .. Config["Team1Name"] .. "-objectivespecific-"..table.Random(sounds_r)..".wav")
	end
end	

---------------------------------------------------------------------------------

function GM:ShowHelp( ply )

	net.Start( "open_teammenu" )
	net.Send( ply )
	
end


function GM:ShowTeam( ply )

	ply:ConCommand("motdpls")
end

net.Receive( "SetTeam", function( len, ply )
	
	local Team = net.ReadUInt( 8 ) 
	ply:SetTeam(Team)
	
	if GetGlobalInt("GameState") == 1 then
	
		ply:SetPos(Location[team.GetName( ply:Team() ).."-spawn"].pos)
		
	elseif GetGlobalInt("GameState") == 2 then
	
		ply:SetPos(Location[team.GetName( ply:Team() ).."-prep"].pos)
		
	elseif GetGlobalInt("GameState") == 3 then
	
		ply:SetPos(Location[team.GetName( ply:Team() ).."-Fight"].pos)
		
	end
	
	ply:SetModel(Rank[team.GetName( ply:Team() ).."-"..ply:GetRank()].model)
	
	round.LoadoutSpawning( ply )
	if GetGlobalInt("GameState") == 2 and round.CantProgress() != true then
		if !ply:IsBot() then
			ply:ConCommand("loadout")	
		end
	end
end )

function GM:PlayerDeath( victim, inflictor, attacker )
	
	if ( victim != attacker ) then
		
		if tonumber(victim:GetLevel()) > tonumber(attacker:GetLevel()) then -- attacker gets more exp for killing someone of a higher rank
		
			attacker:AddExp(Config["kill-reward"] * 2)
			
		else
		
			attacker:AddExp(Config["kill-reward"])
			
		end
		
		if victim:Team() == 2 then
			print("BRIT KILLS " .. GetGlobalInt("BritishKills"))
		
			SetGlobalInt( "BritishKills", GetGlobalInt("BritishKills") + 1)
		elseif victim:Team() == 3 then
			print("AMERICAN KILLS " .. GetGlobalInt("AmericanKills"))

			SetGlobalInt( "AmericanKills", GetGlobalInt("AmericanKills") + 1)
		end
		
		attacker:SendLua("surface.PlaySound('soundtrack/kill_enemy.wav')")
	end
	victim:AddDeaths(1)
	if Config["VoiceActing"] == true then
		local chance = math.random(1,10)
		if victim:Team() == 2 then
			victim:EmitSound("voice/" .. Config["Team1Name"] .. "/death/" .. Config["Team1Name"] .. "-death-"..math.random(1,7)..".wav")
			if chance == 1 then
				attacker:EmitSound("voice/" .. Config["Team2Name"] .. "/battle_cry/" .. Config["Team2Name"] .. "-battle_cry-"..math.random(1,2)..".wav")
			end
		elseif victim:Team() == 3 then
			victim:EmitSound("voice/" .. Config["Team2Name"] .. "/death/" .. Config["Team2Name"] .. "-deathcry-"..math.random(1,8)..".wav")
			if chance == 1 then
				attacker:EmitSound("voice/" .. Config["Team1Name"] .. "/battle_cry/" .. Config["Team1Name"] .. "-battlecry-"..math.random(1,2)..".wav")
			end
		end
	end
end


function GM:DoPlayerDeath(ply, attacker, dmginfo) -- shamelessly lifted from TTT

	local rag = ents.Create("prop_ragdoll")
	rag.player_ragdoll = true
	rag.myteam = ply:Team()
	rag.is_looted = false
	rag:SetPos(ply:GetPos())
	rag:SetModel(ply:GetModel())
	rag:SetAngles(ply:GetAngles())
	rag:SetColor(ply:GetColor())

	rag:Spawn()
	rag:Activate()

	rag:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
	
	timer.Simple( 1, function() if IsValid( rag ) then rag:CollisionRulesChanged() end end )
	
	local num = rag:GetPhysicsObjectCount()-1
	local v = ply:GetVelocity()
	
	if dmginfo:IsDamageType(DMG_BULLET) or dmginfo:IsDamageType(DMG_SLASH) then
	
		v = v / 5
		
	end

	for i=0, num do
		
		local bone = rag:GetPhysicsObjectNum(i)
		
		if IsValid(bone) then
			
			local bp, ba = ply:GetBonePosition(rag:TranslatePhysBoneToBone(i))
			
			if bp and ba then
				bone:SetPos(bp)
				bone:SetAngles(ba)
			end
			
			-- not sure if this will work:
			bone:SetVelocity(v)
			
		end
		
	end
	
end


-- Serverside only stuff goes here --
function GM:PlayerInitialSpawn( ply ) 
   
	ply:SetNWInt("thirdperson", 1 ) 
	ply:SetNWInt("music_volume", 0 ) 
	ply:SetTeam( 1 ) 
	ply:SetModel("models/player/gman_high.mdl")
	if ply:GetPData("Tutorial", 0) == 0 then
		net.Start("open_tutorial")
		net.Send( ply )
		ply:SetPData("Tutorial", 1)
	else
		net.Start( "open_teammenu" )
		net.Send( ply )
		ply:SetPData("Tutorial", 0)
	end	
	ply:ConCommand("motdpls")
end 

hook.Add( "PlayerSay", "OpenMOTD", function( ply, text, public )
	text = string.lower( text )
	if ( text == "!motd" ) then
		ply:ConCommand("motdpls")
		return ""
	end
end )


function GM:PlayerLoadout( ply )

	GAMEMODE:SetPlayerSpeed(ply, 100, 250)
	
	-- sends player to the right place when spawning
	if team.GetName( ply:Team() ) != "Undecieded" then
	
		if GetGlobalInt("GameState") == 1 then
		
			ply:SetPos(Location[team.GetName( ply:Team() ).."-spawn"].pos)
			
		elseif GetGlobalInt("GameState") == 2 then
		
			ply:SetPos(Location[team.GetName( ply:Team() ).."-prep"].pos)
			
		elseif GetGlobalInt("GameState") == 3 then
		
			ply:SetPos(Location[team.GetName( ply:Team() ).."-Fight"].pos)
			
		end
		
	end
	
	round.LoadoutSpawning(ply)
	
	ply:SetNoCollideWithTeammates(true)
	
end


function GM:PlayerShouldTakeDamage( ply, victim )

	if ply:IsPlayer() then
	
		if ply:Team() == victim:Team() then
		
			return false
			
		end
		
	end
	
	return true
end 

function round.LoadoutSpawning( ply )

	ply:StripWeapons()
	ply:StripAmmo()
	
	
	-- Primary -- 
	if ply:GetNWInt("primary") != 0 then
	
		ply:Give(ply:GetNWInt("primary"))
		
	else
	
		if ply:Team() == 2 then
	
			ply:Give(Config["Team1DefaultPrimary"])
			
		elseif ply:Team() == 3 then
		
			ply:Give("tfa_british_rifle_1")
			
		end
		
	end
	
	-- Secondary --
	if ply:GetNWInt("secondary") != 0 then
	
		ply:Give(ply:GetNWInt("secondary"))
		
	else
	
		if team.GetName( ply:Team() ) == Config["Team1PrettyName"] then
	
			ply:Give(Config["Team1DefaultSecondary"])
			
		elseif team.GetName( ply:Team() ) == Config["Team2PrettyName"] then
		
			ply:Give(Config["Team2DefaultSecondary"])
			
		end
		
	end
	
	-- Sword --
	if team.GetName( ply:Team() ) == Config["Team1PrettyName"] then
	
		ply:Give(Config["Team1DefaultMelee"])
		
	elseif team.GetName( ply:Team() ) == Config["Team2PrettyName"] then
	
		ply:Give(Config["Team2DefaultMelee"])
		
	end


	ply:SetHealth(ply:GetMaxHealth())
end


include("plugins.lua") --Load last
