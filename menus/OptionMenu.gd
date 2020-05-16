extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Admob.load_banner()
	$glow/glow.pressed = game_states.game_settings.glow



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
	game_states.saveEverything()
	get_tree().change_scene("res://menus/MainMenu.tscn")


func _on_music_toggled(button_pressed):
	pass # Replace with function body.
