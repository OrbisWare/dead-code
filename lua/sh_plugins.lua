--[[
	 _____           _
	/  __ \         | |
	| /  \/_   _ ___| |_ ___  ___
	| |   | | | / __| __/ _ \/ __|
	| \__/\ |_| \__ \ || (_) \__ \
	 \____/\__,_|___/\__\___/|___/

	~https://github.com/BadWolfGames/custos

	Plugin System
]]
local HOOKS_CACHE = {}
local CMDS_CACHE = {}
local PERM_CACHE = {}
function cu.plugin.Load(id, path, gamemodes)
  local gamemodes = gamemodes or {}

  local PLUGIN = {
    folder = path,
    id = id,
    gamemodes = gamemodes,
    name = "Unknown",
    author = "Unknown",
    description = "None"
  }

  --Don't load plugins if they're for specific gamemode.
  if not table.HasValue(self.Gamemodes, gmod.GetGamemode().Name) then
    return
  end

  if cu.g.plugins[id] then
    PLUGIN = cu.g.plugins[id]
  end

  _G["PLUGIN"] = PLUGIN

  cu.LoadFile(path.."/sh_plugin.lua", false)

  PLUGIN.name = PLUGIN.name or "Unknown"
  PLUGIN.author = PLUGIN.author or "Unknown"
  PLUGIN.description = PLUGIN.description or "None"

  for k,v in pairs(PLUGIN) do
    if isfunction(v) then
      HOOKS_CACHE[k] = HOOKS_CACHE[k] or {}
      HOOKS_CACHE[k][PLUGIN] = v
    end
  end

  --Once the plugin is fully loaded destroy the global variable.
  cu.g.plugins[id] = PLUGIN
  _G["PLUGIN"] = nil

  utilx.PrintTableEx(HOOKS_CACHE)
end

function cu.plugin.LoadDir(dir)
  local files, folders = file.Find(dir.."/*", "LUA")

  for k,v in pairs(folders)
    cu.plugin.Load(v, directory.."/"..v, false)
  end

  for k,v in pairs(files) do
    cu.plugin.Load(string.StripExtension(v), dir.."/"..v, false)
  end
end

function cu.plugin.Unload(id)
  local plugin = cu.g.plugins[id]

  if plugin.OnUnload then
    plugin.OnUnload()
  end

  cu.g.plugins[id] = nil
end

function cu.plugin.Active()
  local pluginList = {}

  for k,v in pairs(cu.g.plugins) do
    pluginList[k] =
  end
end
