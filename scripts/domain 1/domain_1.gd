extends Node3D

@onready var part_1: Node3D = $"Part 1"
@onready var part_1_delete_area: Area3D = $"Part 2/Hallway 1/Delete Part 1"

const DOMAIN_2 = preload("uid://djt532ybso6uq") as PackedScene

var finished: bool = false

func _process(delta: float) -> void:
	if finished:
		get_tree().change_scene_to_packed(DOMAIN_2)

func _part_1_exited(body: Node3D) -> void:
	if body is Player:
		part_1.queue_free()
		part_1_delete_area.get_child(0).disabled = true
		part_1_delete_area.queue_free()
