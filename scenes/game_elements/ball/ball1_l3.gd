extends CharacterBody2D

const START_SPEED: int = 500
const MAX_Y_VECTOR: float = 0.6
const ACCEL: int = 3 # ускорение
var win_size: Vector2
var speed: int
var dir: Vector2
var racket_pos: Vector2

@onready var player = $"../Player"
@onready var cpu = $"../CPU"

# Called when the node enters the scene tree for the first time.
func _ready():
	win_size = get_viewport_rect().size
	$".".visible = false

func new_ball():
	# выбирает случайную позицию и направление для старта
	process_mode = PROCESS_MODE_DISABLED
	position.x = win_size.x / 2 + 30
	position.y = win_size.y / 2
	dir = right_direction()
	visible = true
	
func start_moving():
	process_mode = PROCESS_MODE_INHERIT
	speed = START_SPEED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision = move_and_collide(dir * speed * delta)
	var collider
	if collision:
		collider = collision.get_collider()
		if collider == player or collider == cpu:
			if collider == player and get_parent().can_accel_player1:
				get_parent().can_accel_cpu1 = true
				speed += ACCEL
				get_parent().can_accel_player1 = false
			elif collider == cpu and get_parent().can_accel_cpu1:
				get_parent().can_accel_player1 = true
				speed += ACCEL
				get_parent().can_accel_cpu1 = false
			dir = new_direction(collider)
		else:
			dir = dir.bounce(collision.get_normal())
			get_parent().can_accel_player1 = true
			get_parent().can_accel_cpu1 = true

func right_direction():
	var new_dir := Vector2()
	new_dir.x = 1
	new_dir.y = randf_range(-0.8, 0.8)
	return new_dir.normalized()

func new_direction(collider):
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
