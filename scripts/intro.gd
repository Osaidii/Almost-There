extends Node3D

const DOMAIN_1 = preload("res://scenes/domain_1.tscn") as PackedScene
@onready var cutscene: AnimationPlayer = $Cutscene

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	cutscene.play("cutscene")

func _on_cutscene_animation_finished(anim_name: StringName) -> void:
	if anim_name == "cutscene":
		get_tree().change_scene_to_packed(DOMAIN_1)
