extends Button


func _on_pressed() -> void:
	$"ButtonsMusic".play()
	get_tree().quit()
