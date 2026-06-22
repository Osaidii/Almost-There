extends Control

const INTRO = preload("res://scenes/intro.scn") as PackedScene

const DOMAIN_1 = preload("res://scenes/domain_1.tscn") as PackedScene

const DOMAIN_2 = preload("res://scenes/domain_2.tscn") as PackedScene

const DOMAIN_3 = preload("res://scenes/domain_3.tscn") as PackedScene

const CREDITS = preload("res://ui/credits.tscn") as PackedScene

@onready var song: AudioStreamPlayer = $Song

func _ready() -> void:
	Transition.reset()

# For Debugging, Buttons to go all scenes, hehe boi! work smart not hard!

func _on_intro_pressed() -> void:
	Transition.scene_out()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_packed(INTRO)

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

func _on_play_pressed() -> void:
	Transition.scene_out()
	var tween = get_tree().create_tween()
	tween.tween_property(song, "volume_db", -10, 0.0)
	tween.tween_property(song, "volume_db", -80, 3.0)
	await get_tree().create_timer(3.5).timeout
	get_tree().change_scene_to_packed(INTRO)
