extends Control
@onready var hoverSFX = $hoverSFX
@onready var settingsMenu = $"Settings Menu"
@onready var menuButtons = $"Menu Buttons"

func _physics_process(_delta):
	escPressed()

func center_window():
	DisplayServer.window_set_position(Vector2i((DisplayServer.screen_get_size().x - DisplayServer.window_get_size().x)/2,(DisplayServer.screen_get_size().y - DisplayServer.window_get_size().y)/2))

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/world scenes/world_1.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_ten_eighty_p_pressed():
	get_viewport().size = Vector2(1920, 1080)
	center_window()

func _on_seven_twenty_p_pressed():
	get_viewport().size = Vector2(1280, 720)
	center_window()

func _on_eleven_fifty_two_six_forty_eight_pressed():
	get_viewport().size = Vector2(1152, 648)
	center_window()

func _on_settings_pressed():
	menuButtons.hide()
	settingsMenu.appear()

func hovered():
	if hoverSFX.playing: pass
	else: hoverSFX.play()

func escPressed():
	if Input.is_action_just_pressed("esc"):
		if settingsMenu.visible:
			settingsMenu.disappear()
			settingsMenu.hide()
			menuButtons.show()
