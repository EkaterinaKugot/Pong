extends CharacterBody2D

@export var reaction_speed: float = 0.3
var cur_ball_pos: Vector2

var start_pos: int
var dist_y: int # расстояние по вертикале от ракетки
var dist_x: int
var move_by: int # как далеко перемещяется ракетка
var win_height: int # выоста окна
var p_height: int # высота ракетки
var lst_pos_ball1 = 0
var lst_pos_ball2 = 0

var diff_pos_ball1 = 0
var diff_pos_ball2 = 0

var is_ball1 = true

@onready var ball1 = $"../Ball1"
@onready var ball2 = $"../Ball2"

func _ready():
	start_pos = get_viewport_rect().size.x / 2
	lst_pos_ball1 = start_pos
	lst_pos_ball2 = start_pos
	win_height = get_viewport_rect().size.y
	p_height = $Sprite2D.get_rect().size.y * $Sprite2D.scale.y

func _physics_process(delta: float) -> void:
	diff_pos_ball1 = lst_pos_ball1 - ball1.position.x
	diff_pos_ball2 = lst_pos_ball2 - ball2.position.x
	
	if diff_pos_ball1 < 0 and is_ball1:
		cur_ball_pos = ball1.position
	elif diff_pos_ball2 < 0:
		cur_ball_pos = ball2.position
		is_ball1 = false
	else:
		is_ball1 = true
		
	lst_pos_ball1 = ball1.position.x
	lst_pos_ball2 = ball2.position.x
	
	dist_y = position.y - cur_ball_pos.y
	dist_x = position.x - cur_ball_pos.x
	
	if dist_x <= 40 and dist_y < 50:
		move_by = 0
	else:
		move_by = dist_y * reaction_speed
	
	if abs(move_by) >= 10:
		move_by = 8 * (abs(move_by)/move_by)
		
	position.y -= move_by
	
	position.y = clamp(position.y, p_height / 2, win_height - p_height / 2)
	
func new_cpu():
	position.y = win_height / 2
	process_mode = PROCESS_MODE_INHERIT
	get_parent().can_accel_cpu1 = true
	get_parent().can_accel_cpu2 = true
	lst_pos_ball1 = start_pos
	lst_pos_ball2 = start_pos
	
