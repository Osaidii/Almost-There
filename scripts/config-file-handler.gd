extends Node

var config_file := ConfigFile.new()
var default_file := ConfigFile.new()
const FILE_PATH := "user://settings.ini"
const DEFAULT_FILE_PATH := "user://default_settings.ini"

func _ready() -> void:
	if !FileAccess.file_exists(FILE_PATH):
		config_file.set_value("graphics", "mode", 2)
		config_file.set_value("graphics", "resolution", 3)
		config_file.set_value("graphics", "vsync", true)
		config_file.set_value("graphics", "fpscap", false)
		config_file.set_value("graphics", "fpslimit", 3)
		config_file.set_value("graphics", "mode", 2)
		config_file.set_value("graphics", "quality", 1)
		config_file.set_value("accesibility", "subtitles", true)
		config_file.set_value("accesibility", "tutorials", true)
		config_file.set_value("accesibility", "languages", 0)
		config_file.set_value("controls", "forward", true)
		config_file.set_value("controls", "backward", true)
		config_file.set_value("controls", "left", 0)
		config_file.set_value("controls", "right", true)
		config_file.set_value("controls", "flashlight", true)
		config_file.set_value("controls", "crouch", 0)
		config_file.set_value("audio", "master", 7)
		config_file.set_value("audio", "dialogue", 7)
		config_file.set_value("audio", "music", 7)
		config_file.set_value("audio", "effects", 7)
		config_file.save(FILE_PATH)
	else:
		config_file.load(FILE_PATH)
	if !FileAccess.file_exists(DEFAULT_FILE_PATH):
		default_file.set_value("graphics", "mode", 2)
		default_file.set_value("graphics", "resolution", 3)
		default_file.set_value("graphics", "vsync", true)
		default_file.set_value("graphics", "fpscap", false)
		default_file.set_value("graphics", "fpslimit", 3)
		default_file.set_value("graphics", "mode", 2)
		default_file.set_value("graphics", "quality", 1)
		default_file.set_value("accesibility", "subtitles", true)
		default_file.set_value("accesibility", "tutorials", true)
		default_file.set_value("accesibility", "languages", 0)
		config_file.set_value("controls", "forward", true)
		config_file.set_value("controls", "backward", true)
		config_file.set_value("controls", "left", 0)
		config_file.set_value("controls", "right", true)
		config_file.set_value("controls", "flashlight", true)
		config_file.set_value("controls", "crouch", 0)
		default_file.set_value("audio", "master", 7)
		default_file.set_value("audio", "dialogue", 7)
		default_file.set_value("audio", "music", 7)
		default_file.set_value("audio", "effects", 7)
		default_file.save(DEFAULT_FILE_PATH)

func files_are_equal() -> bool:
	if not FileAccess.file_exists(FILE_PATH) or not FileAccess.file_exists(DEFAULT_FILE_PATH):
		return false
	var file1 = FileAccess.open(FILE_PATH, FileAccess.READ)
	var file2 = FileAccess.open(DEFAULT_FILE_PATH, FileAccess.READ)
	return file1.get_as_text() == file2.get_as_text()

func setting_changed(category: String, option: String, value) -> void:
	config_file.set_value(category, option, value)
	config_file.save(FILE_PATH)

func load_settings() -> void:
	pass
