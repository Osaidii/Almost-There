extends Control

const INTRO = preload("res://scenes/intro.scn") as PackedScene
const DOMAIN_1 = preload("res://scenes/domain_1.tscn") as PackedScene
const DOMAIN_2 = preload("res://scenes/domain_2.tscn") as PackedScene
const DOMAIN_3 = preload("res://scenes/domain_3.tscn") as PackedScene
const CREDITS = preload("res://ui/credits.tscn") as PackedScene

@onready var song: AudioStreamPlayer = $Song
@onready var light: OmniLight3D = $"../Level/Street Light/Light"
@onready var hand: Sprite3D = $"../Level/Joint/Hand"
@onready var new_game: Button = $"Buttons/New Game"
@onready var settings_fade: AnimationPlayer = $"../Settings Fade"
@onready var settings: Control = $"../Settings"
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
@onready var graphics_second_button: OptionButton = $"../Settings/Graphics/Display Mode/Button"
@onready var graphics_third_button: OptionButton = $"../Settings/Graphics/Display Resolution/Button"
@onready var graphics_fourth_button: CheckButton = $"../Settings/Graphics/VSync/CheckBox"
@onready var graphics_fifth_button: CheckButton = $"../Settings/Graphics/FPS Cap/CheckBox"
@onready var graphics_sixth_button: OptionButton = $"../Settings/Graphics/FPS Limit/Button"
@onready var graphics_seventh_button: OptionButton = $"../Settings/Graphics/Graphics Quality/Button"
@onready var accesibility_first_button: CheckButton = $"../Settings/Accesibility/Subtitles/CheckBox"
@onready var accesibility_second_button: CheckButton = $"../Settings/Accesibility/Show Tutorials/CheckBox"
@onready var accesibility_third_button: OptionButton = $"../Settings/Accesibility/Language/Button"
@onready var controls_first_button: Button = $"../Settings/Controls/Button"
@onready var audio_first_button: HSlider = $"../Settings/Audio/Master Volume/SliderBox"
@onready var audio_second_button: HSlider = $"../Settings/Audio/Dialogue Volume/SliderBox"
@onready var audio_third_button: HSlider = $"../Settings/Audio/Music Volume/SliderBox"
@onready var audio_fourth_button: HSlider = $"../Settings/Audio/SFX Volume/SliderBox"

# For Debugging, Buttons to go all scenes, hehe boi! work smart not hard!

func _on_domain_1_pressed() -> void:
	Transition.scene_out()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_packed(DOMAIN_1)

func _on_domain_2_pressed() -> void:
	Transition.scene_out()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_packed(DOMAIN_2)

func _on_domain_3_pressed() -> void:
	Transition.scene_out()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_packed(DOMAIN_3)

func _on_credits_pressed() -> void:
	Transition.scene_out()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_packed(CREDITS)

# # # # # # # # 

func _ready() -> void:
	Transition.reset()
	new_game.grab_focus()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta: float) -> void:
	if light.light_energy >= 0.9:
		hand.visible = false
	else:
		hand.visible = true

func _on_new_game_pressed() -> void:
	Transition.scene_out()
	var tween = get_tree().create_tween()
	tween.tween_property(song, "volume_db", -10, 0.0)
	tween.tween_property(song, "volume_db", -80, 3.0)
	await get_tree().create_timer(3.5).timeout
	get_tree().change_scene_to_packed(INTRO)

func _on_continue_game_pressed() -> void:
	pass # Replace with function body.

func _on_settings_pressed() -> void:
	settings_fade.play("fade")
	button.grab_focus()

func _on_exit_game_pressed() -> void:
	Transition.scene_out()
	var tween = get_tree().create_tween()
	tween.tween_property(song, "volume_db", -10, 0.0)
	tween.tween_property(song, "volume_db", -80, 3.0)
	await get_tree().create_timer(2.0).timeout
	get_tree().quit()

func _on_close_settings_pressed() -> void:
	settings_fade.play_backwards("fade")
	await get_tree().create_timer(1.0).timeout
	new_game.grab_focus()

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
		graphics_first_button
		graphics_second_button
		graphics_third_button
		graphics_fourth_button
		graphics_fifth_button
		graphics_sixth_button
		graphics_seventh_button
	elif accesibility.visible == true:
		pass
