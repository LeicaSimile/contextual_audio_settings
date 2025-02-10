local mod = get_mod("contextual_audio_settings")
local options = mod:io_dofile("contextual_audio_settings/scripts/mods/contextual_audio_settings/options")
local context_templates = mod:io_dofile("contextual_audio_settings/scripts/mods/contextual_audio_settings/context_templates")
local VERSION = mod:io_dofile("contextual_audio_settings/scripts/mods/contextual_audio_settings/version")

local locs = {
	mod_name = {
		["en"] = "Contextual Audio Settings",
	},
	mod_description = {
		["en"] = "Automatically adjust audio settings for different contexts. Version: " .. VERSION,
	},
	a_default_group = {
		["en"] = "Default",
	},
	character_select_group = {
		["en"] = "Character Select",
	},
	hub_group = {
		["en"] = "Mourningstar Hub",
	},
	loading_group = {
		["en"] = "Loading Screen / Mission Lobby",
	},
	mission_group = {
		["en"] = "Missions",
	},
	psykhanium_group = {
		["en"] = "Psykhanium",
	}
}

for name, v in pairs(options.option_map) do
	locs[name] = {
		["en"] = Localize(v.loc)
	}
	if v.group ~= context_templates.default.key then
		locs[v.group .. "_enabled"] = {
			["en"] = "Customize audio settings",
		}
	end
end

return locs
