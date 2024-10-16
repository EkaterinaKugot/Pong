extends StaticBody2D

var ball_pos : Vector2
var dist : int # расстояние по вертикале от ракетки
var move_by : int # как далеко перемещяется ракетка
var win_height : int # выоста окна
var p_height : int # высота ракетки

# Called when the node enters the scene tree for the first time.
func _ready():
	win_height = get_viewport_rect().size.y
	p_height = $ColorRect.get_size().y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ball_pos = $"../Ball".position
	dist = position.y - ball_pos.y
	
	if abs(dist) > get_parent().PADDLE_SPEED * delta:
		move_by = get_parent().PADDLE_SPEED * 3 * delta * (dist / abs(dist))
	else:
		move_by = dist

	position.y -= move_by
	
	position.y = clamp(position.y, p_height / 2, win_height - p_height / 2)
