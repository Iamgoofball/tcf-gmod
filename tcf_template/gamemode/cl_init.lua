include( 'shared.lua' )

MsgN("Loading Clientside Files")
for _, file in pairs(file.Find(Config["FolderName"] .. "/gamemode/client/*.lua", "LUA")) do
	MsgN("-> "..file)
	include(Config["FolderName"] .. "/gamemode/client/"..file)
end

MsgN("Loading Shared Files")
for _, file in pairs(file.Find(Config["FolderName"] .. "/gamemode/shared/*.lua", "LUA")) do
	MsgN("-> "..file)
	include(Config["FolderName"] .. "/gamemode/shared/"..file)
end
