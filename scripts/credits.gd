extends Control

const MAIN = preload("uid://cgf5utxk38gyd") as PackedScene

func _ready() -> void:
	Transition.scene_in()

func _on_credits_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "roll down":
		get_tree().change_scene_to_packed(MAIN)
