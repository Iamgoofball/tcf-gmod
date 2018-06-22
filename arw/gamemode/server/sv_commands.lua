local function Admin_GiveMoney(ply, txt)
	local command = string.Explode(" ", txt)
	if command[1] == "!givemoney" then
		if ply:IsAdmin() then
			local target_player = FindPlayer(ply, command[2])
			local target_amount = command[3]
			local commandname = command[1]
			if CheckInput(ply, target_amount, commandname) then
				if IsValid(target_player) then	
					target_player:AddMoney(command[3])
					ply:ChatPrint("You gave "..target_player:Nick().." $"..target_amount..".")
				else
					ply:ChatPrint("Target player could not be found.")
				end
			end
		else
			ply:ChatPrint("You don't have permission to use this command.")
		end
	end
end
hook.Add("PlayerSay", "Admin_GiveMoney", Admin_GiveMoney)

local function Admin_SetMoney(ply, txt)
	local command = string.Explode(" ", txt)
	if command[1] == "!setmoney" then
		if ply:IsAdmin() then
			local target_player = FindPlayer(ply, command[2])
			local target_amount = command[3]
			local commandname = command[1]
			if CheckInput(ply, target_amount, commandname) then
				if IsValid(target_player) then	
					target_player:SetMoney(command[3])
					ply:ChatPrint("You set "..target_player:Nick().."'s money to $"..target_amount..".")
				else
					ply:ChatPrint("Target player could not be found.")
				end
			end
		else
			ply:ChatPrint("You don't have permission to use this command.")
		end
	end
end
hook.Add("PlayerSay", "Admin_SetMoney", Admin_SetMoney)

-- Returns string
function FindPlayer(ply, target)
	name = string.lower(target)
	for _,v in ipairs(player.GetHumans()) do
		if(string.find(string.lower(v:Name()), name, 1, true) != nil) then 
			return v
		end
	end
end

-- Returns boolean
function CheckInput(ply, num, commandname)
	local numeric_num = tonumber(num)
	local string_num = tostring(num)
	local commandname = tostring(commandname)

	if numeric_num or string_num then
		if string_num == "nan" or string_num == "inf" then 
			ply:ChatPrint("Attempted to pass illegal characters as command argument.")
			return false
		elseif numeric_num == nil or string_num == nil then 
			ply:ChatPrint("Invalid parameters specified.")
			return false
		elseif numeric_num < 0 then
			ply:ChatPrint("Invalid number specified. Negatives not allowed.")
			return false
		else 
			return true
		end
	elseif commandname then
		ply:ChatPrint("Invalid number specified.\nCommand: "..commandname)
		return false
	else
		ply:ChatPrint("Invalid number specified.")
		return false
	end
end