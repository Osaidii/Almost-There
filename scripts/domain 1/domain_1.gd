extends Node3D

@onready var part_1: Node3D = $"Part 1"
@onready var part_1_delete_area: Area3D = $"Part 2/Hallway 1/Delete Part 1"
@onready var cutscene: AnimationPlayer = $Cutscene
@onready var player: Player = $Player
@onready var walk_tutorial: Label = $Cinematics/Tutorials/Walk
@onready var look_around_tutorial: Label = $"Cinematics/Tutorials/Look Around"

@export var WALK_PAUSE := false
@export var LOOK_PAUSE := false

const DOMAIN_2 = preload("uid://djt532ybso6uq") as PackedScene

var finished: bool = false

func _process(_delta: float) -> void:
	if finished:
		get_tree().change_scene_to_packed(DOMAIN_2)
	if !cutscene.is_playing() and WALK_PAUSE and player.CAN_CONTROL:
		if player.position != Vector3(-3.193, 1.168, 0.393):
			cutscene.play("tutpart2")
			await get_tree().create_timer(1.5).timeout
			cutscene.play("tutpart3")
	if !cutscene.is_playing() and LOOK_PAUSE and player.camera.rotation != Vector3(0, 0, 0) and player.CAN_CONTROL:
		cutscene.play("tutpart4")

func _part_1_exited(body: Node3D) -> void:
	if body is Player:
		part_1.queue_free()
		part_1_delete_area.get_child(0).disabled = true
		part_1_delete_area.queue_free()

func _on_cutscene_animation_finished(anim_name: StringName) -> void:
	if anim_name == "intro":
		cutscene.play("tutpart1")
