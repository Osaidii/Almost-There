extends Node3D

const DOMAIN_1 = preload("res://scenes/domain_1.tscn") as PackedScene
@onready var cutscene: AnimationPlayer = $Cutscene
@onready var subtitles: AnimationPlayer = $Subtitles
@onready var foreshadowing: Label = $Cinematics/Foreshadowing
@onready var foreshadowing_other_half: Label = $"Cinematics/Foreshadowing Other Half"
@onready var _1: Label = $"Cinematics/Subtitles/1"
@onready var _2: Label = $"Cinematics/Subtitles/2"
@onready var _3: Label = $"Cinematics/Subtitles/3"
@onready var _4: Label = $"Cinematics/Subtitles/4"
@onready var _5: Label = $"Cinematics/Subtitles/5"
@onready var _6: Label = $"Cinematics/Subtitles/6"
@onready var _7: Label = $"Cinematics/Subtitles/7"
@onready var _8: Label = $"Cinematics/Subtitles/8"
@onready var _9: Label = $"Cinematics/Subtitles/9"
@onready var _10: Label = $"Cinematics/Subtitles/10"

func _ready() -> void:
	#language_changed()
	Transition.reset()
	await get_tree().create_timer(1.0).timeout
	cutscene.play("foreshadowing")
	await get_tree().create_timer(7.0).timeout
	cutscene.play("cutscene")
	if Shortcuts.subtiles:
		subtitles.play("subtitles")

func _on_cutscene_animation_finished(anim_name: StringName) -> void:
	if anim_name == "cutscene":
		get_tree().change_scene_to_packed(DOMAIN_1)

func language_changed() -> void:
	_1.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 2)
	_2.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 3)
	_3.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 4)
	_4.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 5)
	_5.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 6)
	_6.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 7)
	_7.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 8)
	_8.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 9)
	_9.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 10)
	_10.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 11)
	print(Shortcuts.language)
	foreshadowing.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 42)
	foreshadowing_other_half.text = Shortcuts.read_from_translations_csv(Shortcuts.language, 43)
