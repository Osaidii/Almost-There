extends Node

# Levels
var intro_complete: bool
var domain_1_complete: bool
var domain_2_complete: bool
var domain_3_complete: bool

# Settings
var subtiles := true
var show_tutorials := true
var language := "english"
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
var load_settings_needed := false
var settings_check_done := false
