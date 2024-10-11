extends Node2D

var score := [0, 0] #Player, CPU
const PADDLE_SPEED: int = 500


func _on_ball_timer_timeout() -> void:
	$Ball.new_ball()
