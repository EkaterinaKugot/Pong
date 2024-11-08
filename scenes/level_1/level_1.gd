extends Sprite2D

var score := [0, 0]# Player, CPU
const PADDLE_SPEED : float = 500.0
const CPU_WIN: int = 3
const PLAYER_WIN: int = 1

var window_size

@export var color_dialog_rect: Color = Color(1.0, 1.0, 1.0)
@export var color_dialog_text: Color = Color(1.0, 1.0, 1.0)

@onready var ball = $Ball
@onready var ball_timer = $BallTimer
@onready var player = $Player
@onready var cpu = $CPU
@onready var dialog_win = preload("res://scenes/dialog_win/win.tscn")
@onready var dialog_lose = preload("res://scenes/dialog_lose/lose.tscn")
var dialog: Node = null
var can_accel_player: bool = true
var can_accel_cpu: bool = true

func _ready():
	window_size = get_viewport().size
	player.process_mode = PROCESS_MODE_DISABLED
	
func _on_ball_timer_timeout():
	player.process_mode = PROCESS_MODE_DISABLED
	ball.new_ball()
	if score[1] == CPU_WIN:
		ball.start_moving()
		stop_all(false)
	elif score[0] == PLAYER_WIN:
		ball.start_moving()
		stop_all(true)
	else:
		cpu.new_cpu()
		player.new_player()
		await get_tree().create_timer(1.0).timeout 
		ball.start_moving()
	

func _on_score_left_body_entered(_body):
	score[1] += 1
	$Hud/CPUScore.text = str(score[1])
	ball_timer.start()
		

func _on_score_right_body_entered(_body):
	score[0] += 1
	$Hud/PlayerScore.text = str(score[0])
	ball_timer.start()
	
func stop_all(is_win: bool):
	ball.process_mode = PROCESS_MODE_DISABLED
	cpu.process_mode = PROCESS_MODE_DISABLED
	player.process_mode = PROCESS_MODE_DISABLED
	if is_win:
		win()
	else:
		lose()
		
func show_dialog(dialog_window):
	if not dialog:
		dialog = dialog_window.instantiate()
		add_child(dialog) 
		dialog.level = 1
		print(dialog.level)
		
		dialog.position.x = (window_size.x - dialog.size.x) / 2
		dialog.position.y = (window_size.y - dialog.size.y) / 2
		
		var dialog_rect = dialog.get_node("ColorRect")
		dialog_rect.color = color_dialog_rect
		var dialog_label = dialog_rect.get_node("Label")
		dialog_label.set("theme_override_colors/font_color", color_dialog_text)
		
	
func win():
	show_dialog(dialog_win)

func lose():
	show_dialog(dialog_lose)
