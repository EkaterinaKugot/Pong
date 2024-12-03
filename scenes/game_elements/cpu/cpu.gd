extends CharacterBody2D

@export var reaction_speed: float = 0.3
var ball_pos: Vector2
var dist_y: int # расстояние по вертикале от ракетки
var dist_x: int
var move_by: int # как далеко перемещяется ракетка
var win_height: int # выоста окна
var p_height: int # высота ракетки


func _ready():
	win_height = get_viewport_rect().size.y
	p_height = $Sprite2D.get_rect().size.y * $Sprite2D.scale.y

func _physics_process(delta: float) -> void:
	ball_pos = $"../Ball".position
	dist_y = position.y - ball_pos.y
	dist_x = position.x - ball_pos.x
	
	if dist_x <= 40 and dist_y < 50:
		move_by = 0
	else:
		move_by = dist_y * reaction_speed

	position.y -= move_by
	
	position.y = clamp(position.y, p_height / 2, win_height - p_height / 2)
	
func new_cpu():
	position.y = win_height / 2
	get_parent().can_accel_cpu1 = true
	
