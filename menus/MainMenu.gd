extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if game_states.game_settings.glow:
		$WorldEnvironment.environment = load("res://objects/misc/world.tres")
	else:
		$WorldEnvironment.environment = load("res://default_env.tres")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_start_pressed():
	get_tree().change_scene("res://objects/world.tscn")


func _on_option_pressed():
	get_tree().change_scene("res://menus/OptionMenu.tscn")


func _on_exit_pressed():
	get_tree().quit()
