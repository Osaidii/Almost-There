extends Node3D

@onready var meshes: Node3D = $Meshes
@onready var collision: CollisionShape3D = $Static/Collision

var player_reached := false
var player_looking := true

func _on_area_body_entered(body: Node3D) -> void:
	if body is Player:
		player_reached = true
	if !player_looking:
		meshes.visible = false
		collision.disabled = true

func _on_screen() -> void:
	player_looking = true

func _not_on_screen() -> void:
	player_looking = false
	if player_reached:
		meshes.visible = false
		collision.disabled = true
