extends Node2D

@onready var level2 = $Level2
@onready var level3 = $Level3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not MenuMusic.playing:
		MenuMusic.play()
	level2.disabled = true
	level3.disabled = true
	
	if Global.is_condition_met_for_level2:
		level2.disabled = false
	if Global.is_condition_met_for_level3:
		level3.disabled = false
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
