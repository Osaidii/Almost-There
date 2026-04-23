extends CanvasLayer

@onready var transition_player: AnimationPlayer = $TransitionPlayer

func scene_in() -> void:
	visible = true
	transition_player.play("in")

func scene_out() -> void:
	visible = true
	transition_player.play("out")
