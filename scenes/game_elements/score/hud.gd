extends CanvasLayer

@export var color_player: Color = Color(1.0, 1.0, 1.0)
@export var color_cpu: Color = Color(1.0, 1.0, 1.0)

func _ready() -> void:
	$PlayerScore.set("theme_override_colors/font_color", color_player)
	$CPUScore.set("theme_override_colors/font_color", color_cpu)
