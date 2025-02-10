local mod = get_mod("contextual_audio_settings")
local options = mod:io_dofile("contextual_audio_settings/scripts/mods/contextual_audio_settings/options")
local context_templates = mod:io_dofile("contextual_audio_settings/scripts/mods/contextual_audio_settings/context_templates")

local widget_groups = {}
local sorted_group_keys = {}
local cvs_widgets = {}

local function create_sound_widget(name)
	local option_range = {0, 100}
	return {
		setting_id = name,
		type = "numeric",
		default_value = 100,
		range = option_range,
	}
end

local function get_group(key)
	if not widget_groups[key] then
		widget_groups[key] = {
			setting_id = key .. "_group",
			type = "group",
			sub_widgets = {},
		}
		if key ~= "a_default" then
			table.insert(widget_groups[key].sub_widgets, {
				setting_id = key .. "_enabled",
				type = "checkbox",
				default_value = false,
				sub_widgets = {},
			})
		end
	end
	return widget_groups[key]
end

for _, option_names in pairs(options.options_by_context) do
	-- Add sub-widgets in a consistent order
	for _, name in ipairs(option_names) do
		local o = options.option_map[name]
		local widget = create_sound_widget(name)
		if o.group == context_templates.default.key then
			table.insert(get_group(o.group).sub_widgets, widget)
		else
			table.insert(get_group(o.group).sub_widgets[1].sub_widgets, widget)
		end
	end
end

-- Add widgets in alphabetical order
for key, _ in pairs(widget_groups) do
	table.insert(sorted_group_keys, key)
end
table.sort(sorted_group_keys)
for _, key in ipairs(sorted_group_keys) do
	table.insert(cvs_widgets, widget_groups[key])
end

return {
	name = mod:localize("mod_name"),
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = cvs_widgets,
	}
}
