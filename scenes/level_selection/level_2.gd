extends Button


func _on_pressed() -> void:
	$"ButtonsMusic".play()
	get_tree().change_scene_to_file("res://scenes/level_2/level_2.tscn")
