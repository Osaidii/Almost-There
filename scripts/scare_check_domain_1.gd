extends Node3D

var looking := false
var in_range := false
var played := false

@onready var wall_23: Node3D = $"Wall 23"
@onready var wall_24: Node3D = $"Wall 24"
@onready var wall_25: Node3D = $"Wall 25"
@onready var wall_26: Node3D = $"Wall 26"
@onready var entity: Sprite3D = $Entity
@onready var animation: AnimationPlayer = $Animation

func _process(delta: float) -> void:
	if in_range and looking and !played:
		played = true
		animation.play("hide")
		wall_23.visible = false
		wall_24.visible = false
		wall_25.visible = false
		wall_26.visible = false

func _on_scare_check_body_entered(body: Node3D) -> void:
	if body is Player:
		in_range = true

func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	looking = true

func _on_near_range(body: Node3D) -> void:
	if body is Player:
		visible = true

func _on_animation_not_triggered_destroy(body: Node3D) -> void:
	if body is Player and !played and visible:
		in_range = true
