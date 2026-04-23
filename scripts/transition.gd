extends CanvasLayer

@onready var transition_player: AnimationPlayer = $TransitionPlayer

func scene_in() -> void:
	transition_player.play("in")
	visible = false

func scene_out() -> void:
	visible = true
	transition_player.play("out")
