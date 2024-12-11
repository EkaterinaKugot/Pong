extends Button


func _on_pressed() -> void:
	$"ButtonsMusic".play()
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
