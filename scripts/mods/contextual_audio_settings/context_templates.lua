return {
    default = {
        key = "a_default",
        options = {
            "option_master_slider",
            "options_music_slider",
            "options_sfx_slider",
        },
    },
    GameplayStateRun = {
        options = {
            "option_master_slider",
            "options_music_slider",
            "options_sfx_slider",
        },
        modes = {
            coop_complete_objective = "mission",
            hub = "hub",
            prologue_hub = "hub",
            prologue = "mission",
            shooting_range = "psykhanium",
            training_grounds = "psykhanium",
        },
    },
    StateLoading = {
        key = "loading",
        options = {
            "option_master_slider",
            "options_music_slider",
            "options_sfx_slider",
        },
    },
    StateMainMenu = {
        key = "character_select",
        options = {
            "option_master_slider",
            "options_music_slider",
            "options_sfx_slider",
        },
    }
}
