extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Admob.load_banner()
	$Admob.show_banner()
	$glow/glow.pressed = game_states.game_settings.glow
	$music/music.pressed = game_states.game_settings.music
	$fps/fps.pressed = game_states.game_settings.fps



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_glow_toggled(button_pressed):
	print("called")
	if button_pressed:
		$WorldEnvironment.environment = load("res://objects/misc/world.tres")
	else:
		$WorldEnvironment.environment = load("res://default_env.tres")
	game_states.game_settings.glow = button_pressed


func _on_back_pressed():
	$Admob.hide_banner()
	game_states.saveEverything()
	get_tree().change_scene("res://menus/MainMenu.tscn")


func _on_music_toggled(button_pressed):
	if button_pressed and not game_states.game_settings.music:
		game_states.main_music.play()
	else:
		game_states.main_music.stop()
	game_states.game_settings.music = button_pressed


func _on_fps_toggled(button_pressed):
	game_states.game_settings.fps = button_pressed
