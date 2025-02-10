return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`contextual_audio_settings` encountered an error loading the Darktide Mod Framework.")

		new_mod("contextual_audio_settings", {
			mod_script       = "contextual_audio_settings/scripts/mods/contextual_audio_settings/contextual_audio_settings",
			mod_data         = "contextual_audio_settings/scripts/mods/contextual_audio_settings/contextual_audio_settings_data",
			mod_localization = "contextual_audio_settings/scripts/mods/contextual_audio_settings/contextual_audio_settings_localization",
		})
	end,
	packages = {},
}
