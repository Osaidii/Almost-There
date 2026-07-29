extends CanvasLayer

@onready var shader_mesh: ColorRect = $"Shader Mesh"

const CRT_SHADER = preload("uid://dx840f7i02kei")

func _process(_delta: float) -> void:
	# Set Shader Values
	set_values()

func set_values() -> void:
	# Send Shader Parameters
	if !Shortcuts.disable_crt_shader:
		shader_mesh.material.shader = CRT_SHADER
		var shader_material = shader_mesh.material
		shader_material.set_shader_parameter("disable", Shortcuts.disable_crt_shader)
		shader_material.set_shader_parameter("curvature", Shortcuts.curvature)
		shader_material.set_shader_parameter("blur", Shortcuts.blur)
		shader_material.set_shader_parameter("line_alpha", Shortcuts.line_alpha)
		shader_material.set_shader_parameter("line_subtleness", Shortcuts.line_subtleness)
		shader_material.set_shader_parameter("vignette_multiplier", Shortcuts.vignette_multiplier)
		shader_material.set_shader_parameter("vignette_border", Shortcuts.vignette_border)
	else:
		shader_mesh.material.shader = null
	
	
