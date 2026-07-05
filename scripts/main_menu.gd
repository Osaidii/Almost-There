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
	print("here")
	settings_fade.play("fade")

func _on_exit_game_pressed() -> void:
	Transition.scene_out()
	var tween = get_tree().create_tween()
	tween.tween_property(song, "volume_db", -10, 0.0)
	tween.tween_property(song, "volume_db", -80, 3.0)
	await get_tree().create_timer(2.0).timeout
	get_tree().quit()



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
