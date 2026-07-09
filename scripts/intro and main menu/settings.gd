extends Control

@onready var settings_fade: AnimationPlayer = $"Settings Fade"
@onready var button: OptionButton = $"../Settings/Graphics/Display Mode/Button"
@onready var graphics: Control = $"../Settings/Graphics"
@onready var accesibility: Control = $"../Settings/Accesibility"
@onready var controls: Control = $"../Settings/Controls"
@onready var audio: Control = $"../Settings/Audio"
@onready var graphics_button: Button = $"../Settings/Categories/Graphics Button"
@onready var accesibility_button: Button = $"../Settings/Categories/Accesibility Button"
@onready var controls_button: Button = $"../Settings/Categories/Controls Button"
@onready var audio_button: Button = $"../Settings/Categories/Audio Button"
@onready var graphics_first_button: OptionButton = $"../Settings/Graphics/Display Mode/Button"
@onready var graphics_second_button: OptionButton =  $"../Settings/Graphics/Display Resolution/Button"
@onready var graphics_third_button: CheckButton = $"../Settings/Graphics/VSync/CheckBox"
@onready var graphics_fourth_button: CheckButton = $"../Settings/Graphics/FPS Cap/CheckBox"
@onready var graphics_fifth_button: OptionButton = $"../Settings/Graphics/FPS Limit/Button"
@onready var graphics_sixth_button: OptionButton = $"../Settings/Graphics/Graphics Quality/Button"
@onready var accesibility_first_button: CheckButton = $"../Settings/Accesibility/Subtitles/CheckBox"
@onready var accesibility_second_button: CheckButton = $"../Settings/Accesibility/Show Tutorials/CheckBox"
@onready var accesibility_third_button: OptionButton = $"../Settings/Accesibility/Language/Button"
@onready var controls_first_button: Button = $"../Settings/Controls/Button"
@onready var audio_first_button: HSlider = $"../Settings/Audio/Master Volume/SliderBox"
@onready var audio_second_button: HSlider = $"../Settings/Audio/Dialogue Volume/SliderBox"
@onready var audio_third_button: HSlider = $"../Settings/Audio/Music Volume/SliderBox"
@onready var audio_fourth_button: HSlider = $"../Settings/Audio/SFX Volume/SliderBox"
@onready var new_game: Button = $"Buttons/New Game"

var fps_cap_enabled := false
var settings_loaded := false

func start_settings() -> void:
	settings_fade.play_backwards("fade")
	button.grab_focus()

func _process(delta: float) -> void:
	if Shortcuts.load_settings_needed:
		load_settings()

func load_settings() -> void:
	_on_display_mode_item_selected(ConfigFileHandler.get_value("graphics", "mode"))

func _on_close_settings_pressed() -> void:
	settings_fade.play("fade")
	await get_tree().create_timer(1.0).timeout

func _on_graphics_pressed() -> void:
	audio.visible = false
	controls.visible = false
	accesibility.visible = false
	graphics.visible = true

func _on_accesibility_pressed() -> void:
	audio.visible = false
	controls.visible = false
	accesibility.visible = true
	graphics.visible = false

func _on_controls_pressed() -> void:
	audio.visible = false
	controls.visible = true
	accesibility.visible = false
	graphics.visible = false

func _on_audio_pressed() -> void:
	audio.visible = true
	controls.visible = false
	accesibility.visible = false
	graphics.visible = false

func _on_default_pressed() -> void:
	if audio.visible == true:
		audio_first_button.value = 7.0
		ConfigFileHandler.setting_changed("audio", "master", 7.0)
		audio_second_button.value = 7.0
		ConfigFileHandler.setting_changed("audio", "dialogue", 7.0)
		audio_third_button.value = 7.0
		ConfigFileHandler.setting_changed("audio", "music", 7.0)
		audio_fourth_button.value = 7.0
		ConfigFileHandler.setting_changed("audio", "sfx", 7.0)
		
	elif controls.visible == true:
		pass
	elif graphics.visible == true:
		graphics_first_button.selected = 2
		ConfigFileHandler.setting_changed("graphics", "mode", 2)
		graphics_second_button.selected = 3
		ConfigFileHandler.setting_changed("graphics", "resolution", 3)
		graphics_third_button.button_pressed = false
		ConfigFileHandler.setting_changed("graphics", "vsync", false)
		graphics_fourth_button.button_pressed = false
		ConfigFileHandler.setting_changed("graphics", "fpscap", false)
		graphics_fifth_button.selected = 3
		ConfigFileHandler.setting_changed("graphics", "fpslimit", 3)
		graphics_sixth_button.selected = 2
		ConfigFileHandler.setting_changed("graphics", "quality", 2)
	elif accesibility.visible == true:
		accesibility_first_button.button_pressed = false
		ConfigFileHandler.setting_changed("accesibility", "subtitles", false)
		accesibility_second_button.button_pressed = false
		ConfigFileHandler.setting_changed("accesibility", "tutorials", false)
		accesibility_third_button.selected = 0
		ConfigFileHandler.setting_changed("accesibility", "language", "english")

# Graphics Settings
func _on_display_mode_item_selected(index: int) -> void:
	if index == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	elif index == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	elif index == 2:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	elif index == 3:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	ConfigFileHandler.setting_changed("graphics", "mode", index)

func _on_display_reso_item_selected(index: int) -> void:
	match index:
		0:
			Shortcuts.display_res_x = 3840
			Shortcuts.display_res_y = 2160
		1:
			Shortcuts.display_res_x = 2560
			Shortcuts.display_res_y = 1440
		2:
			Shortcuts.display_res_x = 1920
			Shortcuts.display_res_y = 1080
		3:
			Shortcuts.display_res_x = 1280
			Shortcuts.display_res_y = 720
	ConfigFileHandler.setting_changed("graphics", "resolution", index)

func _on_vsync_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.VSYNC_ENABLED
		graphics_fourth_button.disabled = true
		graphics_fifth_button.disabled = true
	if !toggled_on:
		DisplayServer.VSYNC_DISABLED
		graphics_fourth_button.disabled = false
		if fps_cap_enabled:
			graphics_fifth_button.disabled = false
		else:
			graphics_fifth_button.disabled = true
	ConfigFileHandler.setting_changed("graphics", "vsync", toggled_on)

func _on_fps_cap_toggled(toggled_on: bool) -> void:
	if toggled_on:
		graphics_fifth_button.disabled = false
		fps_cap_enabled = true
	if !toggled_on:
		graphics_fifth_button.disabled = true
		fps_cap_enabled = false
	ConfigFileHandler.setting_changed("graphics", "fpscap", toggled_on)

func _on_fps_limit_item_selected(index: int) -> void:
	if index == 0:
		Engine.max_fps = 180
	elif index == 1:
		Engine.max_fps = 144
	elif index == 2:
		Engine.max_fps = 120
	elif index == 3:
		Engine.max_fps = 60
	elif index == 4:
		Engine.max_fps = 30
	ConfigFileHandler.setting_changed("graphics", "fpslimit", index)

func _on_graphics_quality_item_selected(index: int) -> void:
	match index:
		0:
			Shortcuts.graphic_quality = "ultrahigh"
		1:
			Shortcuts.graphic_quality = "high"
		2:
			Shortcuts.graphic_quality = "balanced"
		3:
			Shortcuts.graphic_quality = "low"
		4:
			Shortcuts.graphic_quality = "ultralow"
	ConfigFileHandler.setting_changed("graphics", "quality", index)

# Accesibility Settings
func _on_subtitles_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Shortcuts.subtiles = true
	if !toggled_on:
		Shortcuts.subtiles = false
	ConfigFileHandler.setting_changed("accesibility", "subtitles", toggled_on)

func _on_tutorials_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Shortcuts.show_tutorials = true
	if !toggled_on:
		Shortcuts.show_tutorials = false
	ConfigFileHandler.setting_changed("accesibility", "tutorials", toggled_on)

func _on_language_item_selected(index: int) -> void:
	match index:
		0:
			Shortcuts.language = "english"
		1:
			Shortcuts.language = "urdu"
		2:
			Shortcuts.language = "spanish"
		3:
			Shortcuts.language = "chinese"
		4:
			Shortcuts.language = "japanese"
		5:
			Shortcuts.language = "french"
	ConfigFileHandler.setting_changed("accesibility", "languages", index)

# Audio Settings
func _on_master_value_changed(value: float) -> void:
	var decibels: int = give_db(value)
	AudioServer.set_bus_volume_db(0 ,decibels)
	ConfigFileHandler.setting_changed("audio", "master", value)

func _on_dialogue_value_changed(value: float) -> void:
	var decibels: int = give_db(value)
	AudioServer.set_bus_volume_db(1 ,decibels)
	ConfigFileHandler.setting_changed("audio", "dialogue", value)

func _on_music_value_changed(value: float) -> void:
	var decibels: int = give_db(value)
	AudioServer.set_bus_volume_db(2 ,decibels)
	ConfigFileHandler.setting_changed("audio", "music", value)

func _on_effects_value_changed(value: float) -> void:
	var decibels: int = give_db(value)
	AudioServer.set_bus_volume_db(3 ,decibels)
	ConfigFileHandler.setting_changed("audio", "sfx", value)

func give_db(level: int) -> int:
	match level:
		0:
			return -80
		1:
			return -18
		2:
			return -15
		3:
			return -12
		4:
			return -9
		5:
			return -6
		6:
			return -3
		7:
			return 0
		8:
			return 3
		9:
			return 6
		10:
			return 9
	return 0
