-- Author: LeicaSimile
local mod = get_mod("contextual_audio_settings")
local context_templates = mod:io_dofile("contextual_audio_settings/scripts/mods/contextual_audio_settings/context_templates")
local options = mod:io_dofile("contextual_audio_settings/scripts/mods/contextual_audio_settings/options")

local function change_volume_setting(setting_name, value)
    Wwise.set_parameter(setting_name, value)
	Application.set_user_setting("sound_settings", setting_name, value)
	Application.save_user_settings()
end

local function default_value(setting_name)
	return mod:get(options.get_option_name(context_templates.default.key, setting_name))
end

local function set_context_volume(context)
	local context_options = options.options_by_context[context]
	for _, option_name in pairs(context_options) do
		local option_props = options.option_map[option_name]
		local setting_enabled = context == context_templates.default.key or mod:get(option_props.group .. "_enabled")
		local setting_name = option_props.setting_name
		local setting_value
		if setting_enabled then
			setting_value = mod:get(option_name)
		else
			setting_value = default_value(setting_name)
		end
		
		change_volume_setting(setting_name, setting_value)
	end
end

local function check_context(state_name, game_mode_name)
	if not state_name then
		state_name = Managers.presence and Managers.presence._current_game_state_name
	end
	
	local context_key
	if context_templates[state_name] then
		if context_templates[state_name].modes then
			if not game_mode_name then
				game_mode_name = Managers.state.game_mode and Managers.state.game_mode:game_mode_name()
			end
			if game_mode_name then
				context_key = context_templates[state_name].modes[game_mode_name]
			end
		else
			context_key = context_templates[state_name].key
		end
	end
	if context_key then
		set_context_volume(context_key)
	end
end

mod.on_game_state_changed = function(status, state_name)
	if mod:is_enabled() and status == "enter" then
		check_context(state_name)
	end
end

mod.on_setting_changed = function()
	if mod:is_enabled() then
		check_context()
	end
end

mod.on_enabled = function()
	check_context()
end
