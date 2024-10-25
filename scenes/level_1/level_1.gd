extends Sprite2D

var score := [0, 0]# Player, CPU
const PADDLE_SPEED : float = 500.0

func _on_ball_timer_timeout():
	$CPU.new_cpu()
	$Player.new_player()
	
	$Ball.new_ball()
	await get_tree().create_timer(1.0).timeout 
	$Ball.start_moving()

func _on_score_left_body_entered(body):
	score[1] += 1
	$Hud/CPUScore.text = str(score[1])
	$BallTimer.start()

func _on_score_right_body_entered(body):
	score[0] += 1
	$Hud/PlayerScore.text = str(score[0])
	$BallTimer.start()
