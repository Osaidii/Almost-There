extends Node3D

@onready var part_1: Node3D = $"Part 1"
@onready var part_1_delete_area: Area3D = $"Part 2/Hallway 1/Delete Part 1"


func _part_1_exited(body: Node3D) -> void:
	if body is Player:
		part_1.queue_free()
		part_1_delete_area.get_child(0).disabled = true
		part_1_delete_area.queue_free()
