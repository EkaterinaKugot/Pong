extends Sprite2D

var score := [0, 0]# Player, CPU
const PADDLE_SPEED : float = 500.0
const CPU_WIN: int = 1
const PLAYER_WIN: int = 1

var window_size

@export var color_dialog_border: Color = Color(1.0, 1.0, 1.0)
@export var color_dialog_rect: Color = Color(1.0, 1.0, 1.0)
@export var color_dialog_text: Color = Color(1.0, 1.0, 1.0)


@onready var ball = $Ball
@onready var ball_timer = $BallTimer
@onready var player = $Player
@onready var cpu = $CPU
@onready var timer = $Timer
@onready var hud = $Hud
@onready var dialog_win = preload("res://scenes/game_elements/dialog_win/win.tscn")
@onready var dialog_lose = preload("res://scenes/game_elements/dialog_lose/lose.tscn")
var dialog: Node = null
var can_accel_player1: bool = true
var can_accel_cpu1: bool = true

var can_accel_player2 = null

func _ready():
	window_size = get_viewport().size
	player.process_mode = PROCESS_MODE_DISABLED
	
func _on_ball_timer_timeout():
	print(1)
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
	
func _on_left_body_entered(_body) -> void:
	score[1] += 1
	hud.get_child(1).text = str(score[1])
	ball_timer.start()

func _on_right_body_entered(_body) -> void:
	score[0] += 1
	hud.get_child(0).text = str(score[0])
	ball_timer.start()
	
func stop_all(is_win: bool):
	ball.process_mode = PROCESS_MODE_DISABLED
	cpu.process_mode = PROCESS_MODE_DISABLED
	player.process_mode = PROCESS_MODE_DISABLED
	timer.process_mode = PROCESS_MODE_DISABLED
	if is_win:
		win()
	else:
		lose()
		
func show_dialog(dialog_window, is_win):
	if not dialog:
		dialog = dialog_window.instantiate()
		add_child(dialog) 
		dialog.level = 3
		
		dialog.position.x = (window_size.x - dialog.size.x) / 2
		dialog.position.y = (window_size.y - dialog.size.y) / 2
		
		var dialog_rect = dialog.get_node("ColorRect")
		dialog_rect.color = color_dialog_rect
		
		var border = dialog.get_node("Border")
		border.color = color_dialog_border
		
		var dialog_label = dialog_rect.get_node("Label")
		dialog_label.set("theme_override_colors/font_color", color_dialog_text)
		
		if is_win:
			var dialog_next = dialog_rect.get_node("Next")
			dialog_next.disabled = true
			dialog_next.set_default_cursor_shape(Input.CURSOR_ARROW)
		
	
func win():
	show_dialog(dialog_win, true)

func lose():
	show_dialog(dialog_lose, false)
