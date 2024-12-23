extends Button

func _on_pressed() -> void:
	$"ButtonsMusic".play()
	var level = 0
	var root_node = $"../.."
	if root_node.has_method("get_level"): 
		level =  root_node.get_level()
	var path = "res://scenes/level_{level}/level_{level}.tscn".format({"level": str(level)})
	get_tree().change_scene_to_file(path)
