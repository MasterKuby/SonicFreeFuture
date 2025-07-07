extends Control
@onready var loadingBar = $"Loading Bar"
var bigstep = 0

func _ready():
	loadingBar.value = 0


func _process(delta):
	loadingBar.value += randf_range(0.1, 2.0)
	bigstep += 1
	if loadingBar.value > 1000: get_tree().change_scene_to_file("res://scenes/ui scenes/main menu/main_menu.tscn")
	if bigstep == 300:
		bigstep = 0
		var tween = create_tween()
		tween.tween_property(loadingBar, "value", loadingBar.value + 250, 1.5)  # Moves over 0.5 seconds


func _on_skip_pressed():
	get_tree().change_scene_to_file("res://scenes/ui scenes/main menu/main_menu.tscn")
