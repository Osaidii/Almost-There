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

func start_settings() -> void:
	settings_fade.play_backwards("fade")
	button.grab_focus()

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
		audio_second_button.value = 7.0
		audio_third_button.value = 7.0
		audio_fourth_button.value = 7.0
	elif controls.visible == true:
		pass
	elif graphics.visible == true:
		graphics_first_button.selected = 2
		graphics_second_button.selected = 3
		graphics_third_button.button_pressed = false
		graphics_fourth_button.button_pressed = false
		graphics_fifth_button.selected = 3
		graphics_sixth_button.selected = 2
	elif accesibility.visible == true:
		accesibility_first_button.button_pressed = false
		accesibility_second_button.button_pressed = false
		accesibility_third_button.selected = 0

# Audio Settings

func _on_master_value_changed(value: float) -> void:
	var decibels: int = give_db(value)
	AudioServer.set_bus_volume_db(0 ,decibels)

func _on_dialogue_value_changed(value: float) -> void:
	var decibels: int = give_db(value)
	AudioServer.set_bus_volume_db(1 ,decibels)

func _on_music_value_changed(value: float) -> void:
	var decibels: int = give_db(value)
	AudioServer.set_bus_volume_db(2 ,decibels)

func _on_effects_value_changed(value: float) -> void:
	var decibels: int = give_db(value)
	AudioServer.set_bus_volume_db(3 ,decibels)

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
