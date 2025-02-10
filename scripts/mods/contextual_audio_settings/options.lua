local mod = get_mod("contextual_audio_settings")
local context_templates = mod:io_dofile("contextual_audio_settings/scripts/mods/contextual_audio_settings/context_templates")
local sound_settings = require("scripts/settings/options/sound_settings")

local DELIMITER = "__"
local groups = {}
local option_map = {}

local function get_option_name(key, setting_name)
	return key .. DELIMITER .. setting_name
end

local function add_option(key, options)
	groups[key] = {}
	for _, o in ipairs(options) do
		local option_name = get_option_name(key, o)
		option_map[option_name] = {
			group = key,
			loc = sound_settings.settings_by_id[o].display_name,
			setting_name = o,
		}
		table.insert(groups[key], option_name)
	end
end

for _, entries in pairs(context_templates) do
	if entries.key and not groups[entries.key] then
		add_option(entries.key, entries.options)
	else
		for _, k in pairs(entries.modes) do
			if not groups[k] then
				add_option(k, entries.options)
			end
		end
	end
end

return {
	get_option_name = get_option_name,
	option_map = option_map,
	options_by_context = groups,
}
