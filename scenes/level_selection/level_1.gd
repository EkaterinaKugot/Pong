extends Button

func _on_pressed() -> void:
	$"ButtonsMusic".play()
	get_tree().change_scene_to_file("res://scenes/level_1/level_1.tscn")
