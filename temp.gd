extends Area3D

const CREDITS = preload("uid://qh6rs5yu6q84") as PackedScene

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		Transition.scene_out()
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_packed(CREDITS)
