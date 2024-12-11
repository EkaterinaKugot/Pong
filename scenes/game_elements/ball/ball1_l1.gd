extends CharacterBody2D

const START_SPEED: int = 500
@export var ACCEL: int = 5 # ускорение
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
	position.x = win_size.x / 2
	position.y = win_size.y / 2
	dir = random_direction()
	visible = true
	process_mode = PROCESS_MODE_DISABLED
	
func start_moving():
	process_mode = PROCESS_MODE_INHERIT
	speed = START_SPEED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision = move_and_collide(dir * speed * delta)
	var collider
	if collision:
		collider = collision.get_collider()
		if not $"Sound".playing:
			$"Sound".play()
		if collider == player or collider == cpu:
			if collider == player and get_parent().can_accel_player1:
				get_parent().can_accel_cpu1 = true
				speed += ACCEL
				get_parent().can_accel_player1 = false
			elif collider == cpu and get_parent().can_accel_cpu1:
				get_parent().can_accel_player1 = true
				speed += ACCEL
				get_parent().can_accel_cpu1 = false
			dir = Global.new_direction(collider, dir, position)
		else:
			dir = dir.bounce(collision.get_normal())
			get_parent().can_accel_player1 = true
			get_parent().can_accel_cpu1 = true

func random_direction():
	var new_dir := Vector2()
	new_dir.x = [1, -1].pick_random()
	new_dir.y = randf_range(-1, 1)
	return new_dir.normalized()
	
