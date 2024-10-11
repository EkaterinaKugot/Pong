extends CharacterBody2D


var win_size: Vector2
const START_SPEED = 500.0
const ACCEL: int = 50 # ускорение
var speed: int
var dir: Vector2

func _ready() -> void:
	win_size = get_viewport_rect().size
	
func new_ball():
	# выбирает случайную позицию и направление для старта
	position.x = win_size.x / 2
	position.y = randi_range(200, win_size.y - 200)
	speed = START_SPEED
	dir = random_direction()

func random_direction():
	var new_dir := Vector2()
	new_dir.x = [1, -1].pick_random()
	new_dir.y = randf_range(-1, 1)
	return new_dir.normalized()

func _physics_process(delta: float) -> void:
	move_and_collide(dir * speed * delta)
