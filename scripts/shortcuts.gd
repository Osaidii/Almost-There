extends Node

# Levels
var intro_complete: bool
var domain_1_complete: bool
var domain_2_complete: bool
var domain_3_complete: bool

# Settings
var subtiles := true
var show_tutorials := true
var language := "en"
var graphic_quality := "high"
var display_res_x := 1280
var display_res_y := 720

# Shortcut using Variables (Signal Substitute)
var increase_flashlight_battery: int
var flash_light_unlocked: bool
var disable_crt_shader: bool
var curvature: float
var blur: float
var line_alpha: float
var line_subtleness: float
var vignette_multiplier: float
var vignette_border: float

func read_from_translations_csv(passed_language: String, line: int) -> String:
	var answer: String
	var file = FileAccess.open("res://storage/translations.csv", FileAccess.READ)
	var language_number: int
	match passed_language:
		"en":
			language_number = 1
		"es":
			language_number = 2
		"zh":
			language_number = 3
		"fr":
			language_number = 4
		"ur":
			language_number = 5
		"ar":
			language_number = 6
	var line_data = []
	var line_count = 1
	while not file.eof_reached():
		var temp_line = file.get_csv_line(";")
		line_count += 1
		if (line_count - 1) == line:
			line_data = temp_line
			break
	answer = line_data[language_number]
	return answer
