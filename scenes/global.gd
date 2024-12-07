extends Node

var is_condition_met_for_level2: bool = false
var is_condition_met_for_level3: bool = false
var window_size
const MAX_Y_VECTOR: float = 0.6

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	window_size = get_viewport().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func new_direction(collider, dir, position):
	var ball_y = position.y
	var pad_y = collider.position.y
	var dist = ball_y - pad_y
	var new_dir := Vector2()
	
	if dir.x > 0:
		new_dir.x = -1
	else:
		new_dir.x = 1
	new_dir.y = (dist / (collider.p_height / 2)) * MAX_Y_VECTOR
	return new_dir.normalized()
