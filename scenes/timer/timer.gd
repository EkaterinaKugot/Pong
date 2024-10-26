extends Node2D

@export var timer: float = 5*60 + 1
var timer_t: bool = true
@export var color_text: Color = Color(1.0, 1.0, 1.0)

func _ready() -> void:
	$Label.set("theme_override_colors/font_color", color_text)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer <= 0:
		timer_t = false
		get_parent().stop_all(true)
		
	if timer_t:
		timer -= delta
		
	var sec = fmod(timer, 60)
	var min = fmod(timer, 60*60) /60
	
	var timer_passed = "%02d:%02d" % [min, sec]
	
	$Label.text = str(timer_passed)
