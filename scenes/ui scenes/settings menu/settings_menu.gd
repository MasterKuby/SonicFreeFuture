extends Control

@export var pauseSubMenu: Control
@export var animationPlayer: Node
@export var mainMenu: Control

func _ready():
	hide()

func _process(delta):
	pass

func center_window():
	DisplayServer.window_set_position(Vector2i((DisplayServer.screen_get_size().x - DisplayServer.window_get_size().x)/2,(DisplayServer.screen_get_size().y - DisplayServer.window_get_size().y)/2))


func changeResolution(x, y):
	get_viewport().size = Vector2(x, y)
	center_window()


func _on_resolution_option_button_item_selected(index):
	if index == 0:
		changeResolution(1920, 1080)
	if index == 1:
		changeResolution(1280, 720)
	if index == 2:
		changeResolution(1152, 648)


func _on_cpugpu_particles_option_button_item_selected(index):
	if index == 0:
		GlobalSettings.particlesType = "CPU"
	else:
		GlobalSettings.particlesType = "GPU"


func _on_back_pressed():
	if pauseSubMenu:
		pauseSubMenu.resume()
	if mainMenu:
		mainMenu.menuButtons.show()

func disappear():
	animationPlayer.play_backwards("blur and fade")
	hide()

func appear():
	show()
	animationPlayer.play("blur and fade")
