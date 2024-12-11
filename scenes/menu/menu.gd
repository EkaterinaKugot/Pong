extends Node2D

func _ready() -> void:
	if not MenuMusic.playing:
		MenuMusic.play()
