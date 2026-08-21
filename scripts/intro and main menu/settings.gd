extends Control

@onready var settings_fade: AnimationPlayer = $"Settings Fade"
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
@onready var audio_first_button: HSlider = $"../Settings/Audio/Master Volume/SliderBox"
@onready var audio_second_button: HSlider = $"../Settings/Audio/Dialogue Volume/SliderBox"
@onready var audio_third_button: HSlider = $"../Settings/Audio/Music Volume/SliderBox"
@onready var audio_fourth_button: HSlider = $"../Settings/Audio/SFX Volume/SliderBox"
@onready var default: Button = $Default
@onready var settings: Label = $Settings
@onready var label1: Label = $"Graphics/Display Mode/Label"
@onready var label2: Label = $"Graphics/Display Resolution/Label"
@onready var label3: Label = $Graphics/VSync/Label
@onready var label4: Label = $"Graphics/FPS Cap/Label"
@onready var label5: Label = $"Graphics/FPS Limit/Label"
@onready var label6: Label = $"Graphics/Graphics Quality/Label"
@onready var label7: Label = $Accesibility/Subtitles/Label
@onready var label8: Label = $"Accesibility/Show Tutorials/Label"
@onready var label9: Label = $Accesibility/Language/Label
@onready var label10: Label = $"Audio/Master Volume/Label"
@onready var label11: Label = $"Audio/Dialogue Volume/Label"
@onready var label12: Label = $"Audio/Music Volume/Label"
@onready var label13: Label = $"Audio/SFX Volume/Label"

var config := ConfigFile.new()
var default_config := ConfigFile.new()
var fps_cap_enabled := false
var load_settings_needed := false
enum ACTIONS {Forward, Backward, Left, Right, Flashlight, Crouch}
var max_fps: int

func _ready() -> void:
	var path = config.load("user://settings.ini")
	var default_path = default_config.load("user://default_settings.ini")
	load_settings_needed = !ConfigFileHandler.files_are_equal()
	if load_settings_needed:
		load_settings()
		load_settings_needed = false
	language_changed()

func start_settings() -> void:
	settings_fade.play_backwards("fade")
	graphics_button.grab_focus()

func load_settings() -> void:
	_on_display_mode_item_selected(config.get_value("graphics", "mode"))
	_on_display_reso_item_selected(config.get_value("graphics", "resolution"))
	_on_vsync_toggled(config.get_value("graphics", "vsync"))
	if graphics_fourth_button.disabled == false:
		_on_fps_cap_toggled(config.get_value("graphics", "fpscap"))
	if graphics_fifth_button.disabled == false:
		_on_fps_limit_item_selected(config.get_value("graphics", "fpslimit"))
	_on_graphics_quality_item_selected(config.get_value("graphics", "quality"))
	_on_subtitles_toggled(config.get_value("accesibility", "subtitles"))
	_on_tutorials_toggled(config.get_value("accesibility", "tutorials"))
	_on_language_item_selected(config.get_value("accesibility", "language"))
	_on_master_value_changed(config.get_value("audio", "master"))
	_on_dialogue_value_changed(config.get_value("audio", "dialogue"))
	_on_music_value_changed(config.get_value("audio", "music"))
	_on_effects_value_changed(config.get_value("audio", "sfx"))

func _on_close_settings_pressed() -> void:
	settings_fade.play("fade")
	await get_tree().create_timer(1.0).timeout
	get_tree().current_scene.get_child(1).focus_grabbed = false

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
	default.visible = false

func _on_audio_pressed() -> void:
	audio.visible = true
	controls.visible = false
	accesibility.visible = false
	graphics.visible = false

func _on_default_pressed() -> void:
	if audio.visible == true:
		_on_master_value_changed(default_config.get_value("audio", "master"))
		_on_dialogue_value_changed(default_config.get_value("audio", "dialogue"))
		_on_music_value_changed(default_config.get_value("audio", "music"))
		_on_effects_value_changed(default_config.get_value("audio", "sfx"))
	elif graphics.visible == true:
		_on_display_mode_item_selected(default_config.get_value("graphics", "mode"))
		_on_display_reso_item_selected(default_config.get_value("graphics", "resolution"))
		_on_vsync_toggled(default_config.get_value("graphics", "vsync"))
		_on_fps_cap_toggled(default_config.get_value("graphics", "fpscap"))
		_on_fps_limit_item_selected(default_config.get_value("graphics", "fpslimit"))
		graphics_fourth_button.disabled = true
		graphics_fifth_button.disabled = true
		_on_graphics_quality_item_selected(default_config.get_value("graphics", "quality"))
	elif accesibility.visible == true:
		_on_subtitles_toggled(default_config.get_value("accesibility", "subtitles"))
		_on_tutorials_toggled(default_config.get_value("accesibility", "tutorials"))
		_on_language_item_selected(default_config.get_value("accesibility", "language"))

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
	graphics_first_button.selected = index
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
	graphics_second_button.selected = index
	ConfigFileHandler.setting_changed("graphics", "resolution", index)

func _on_vsync_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		graphics_fourth_button.disabled = true
		graphics_fifth_button.disabled = true
	if !toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		graphics_fourth_button.disabled = false
		if fps_cap_enabled:
			graphics_fifth_button.disabled = false
		else:
			graphics_fifth_button.disabled = true
	graphics_third_button.button_pressed = toggled_on
	ConfigFileHandler.setting_changed("graphics", "vsync", toggled_on)

func _on_fps_cap_toggled(toggled_on: bool) -> void:
	if toggled_on:
		graphics_fifth_button.disabled = false
		fps_cap_enabled = true
		Engine.max_fps = max_fps
	if !toggled_on:
		graphics_fifth_button.disabled = true
		fps_cap_enabled = false
		Engine.max_fps = 0
	graphics_fourth_button.button_pressed = toggled_on
	ConfigFileHandler.setting_changed("graphics", "fpscap", toggled_on)

func _on_fps_limit_item_selected(index: int) -> void:
	if index == 0:
		max_fps = 180
	elif index == 1:
		max_fps = 144
	elif index == 2:
		max_fps = 120
	elif index == 3:
		max_fps = 60
	elif index == 4:
		max_fps = 30
	Engine.max_fps = max_fps
	graphics_fifth_button.selected = index
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
	graphics_sixth_button.selected = index
	ConfigFileHandler.setting_changed("graphics", "quality", index)

# Accesibility Settings
func _on_subtitles_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Shortcuts.subtiles = true
	if !toggled_on:
		Shortcuts.subtiles = false
	accesibility_first_button.button_pressed = toggled_on
	ConfigFileHandler.setting_changed("accesibility", "subtitles", toggled_on)

func _on_tutorials_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Shortcuts.show_tutorials = true
	if !toggled_on:
		Shortcuts.show_tutorials = false
	accesibility_second_button.button_pressed = toggled_on
	ConfigFileHandler.setting_changed("accesibility", "tutorials", toggled_on)

func _on_language_item_selected(index: int) -> void:
	match index:
		0:
			Shortcuts.language = "en"
			
		1:
			Shortcuts.language = "es"
		2:
			Shortcuts.language = "zh"
		3:
			Shortcuts.language = "ar"
		4:
			Shortcuts.language = "fr"
		5:
			Shortcuts.language = "ur"
	accesibility_third_button.selected = index
	ConfigFileHandler.setting_changed("accesibility", "language", index)
	language_changed()
	if get_tree().current_scene.scene_file_path == "res://ui/main_menu.scn":
		$"../UI".language_changed()
	elif get_tree().current_scene.scene_file_path == "res://ui/domain_1.scn":
		pass
	elif get_tree().current_scene.scene_file_path == "res://ui/domain_2.scn":
		pass
	elif get_tree().current_scene.scene_file_path == "res://ui/domain_3.scn":
		pass

func get_action_key_name(action: String) -> String:
	var events = InputMap.action_get_events(action)
	var event := events[0] as InputEventKey
	return OS.get_keycode_string(event.keycode)

# Audio Settings
func _on_master_value_changed(value: float) -> void:
	var decibels: int = give_db(value)
	AudioServer.set_bus_volume_db(0 ,decibels)
	audio_first_button.value = value
	ConfigFileHandler.setting_changed("audio", "master", value)

func _on_dialogue_value_changed(value: float) -> void:
	var decibels: int = give_db(value)
	AudioServer.set_bus_volume_db(1 ,decibels)
	audio_second_button.value = value
	ConfigFileHandler.setting_changed("audio", "dialogue", value)

func _on_music_value_changed(value: float) -> void:
	var decibels: int = give_db(value)
	AudioServer.set_bus_volume_db(2 ,decibels)
	audio_third_button.value = value
	ConfigFileHandler.setting_changed("audio", "music", value)

func _on_effects_value_changed(value: float) -> void:
	var decibels: int = give_db(value)
	AudioServer.set_bus_volume_db(3 ,decibels)
	audio_fourth_button.value = value
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

func language_changed() -> void:
	label1.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 36)
	label2.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 37)
	label3.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 38)
	label4.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 39)
	label5.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 40)
	label6.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 41)
	label7.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 33)
	label8.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 34)
	label9.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 35)
	label10.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 29)
	label11.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 30)
	label12.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 31)
	label13.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 32)
	audio_button.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 20)
	graphics_button.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 17)
	accesibility_button.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 18)
	controls_button.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 19)
	default.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 28)
	settings.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 15)
