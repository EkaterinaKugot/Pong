extends CharacterBody2D

var win_height : int # высота окна
var p_height : int # высота ракетки

# Called when the node enters the scene tree for the first time.
func _ready():
	win_height = get_viewport_rect().size.y
	p_height = $Sprite2D.get_rect().size.y * $Sprite2D.scale.y

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		position.y -= get_parent().PADDLE_SPEED * delta
	elif Input.is_action_pressed("ui_down"):
		position.y += get_parent().PADDLE_SPEED * delta
	
	# проверяем верхнии и нижнии границы
	position.y = clamp(position.y, p_height / 2, win_height - p_height / 2)
	
func new_player():
	position.y = 324
	process_mode = PROCESS_MODE_INHERIT
	get_parent().can_accel_player = true
	
