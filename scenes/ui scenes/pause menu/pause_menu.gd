extends Control

@onready var animationPlayer = $AnimationPlayer
@onready var hoverSFX = $hoverSFX

func _ready():
	hide()
	LimboConsole.enabled = true


func _process(delta):
	escPressed()

func resume():
	animationPlayer.play_backwards("blur and fade")
	get_tree().paused = false
	await(animationPlayer.animation_finished)
	hide()
	LimboConsole.enabled = true

func pause():
	show()
	animationPlayer.play("blur and fade")
	get_tree().paused = true
	LimboConsole.enabled = false

func escPressed():
	if Input.is_action_just_pressed("esc") and !get_tree().paused: pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused: resume()
	if get_tree().paused: show()

func _on_resume_pressed():
	if get_tree().paused:
		resume()

func _on_restart_pressed():
	if get_tree().paused:
		resume() 
		get_tree().reload_current_scene()

func _on_main_menu_pressed():
	if get_tree().paused:
		resume()
		get_tree().change_scene_to_file("res://scenes/ui scenes/main menu/main_menu.tscn")

func hovered():
	if hoverSFX.playing: pass
	else: hoverSFX.play()
