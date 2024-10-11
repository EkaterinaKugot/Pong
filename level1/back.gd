extends Button



func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://level_selection/level_selection.tscn")
