extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_glow_toggled(button_pressed):
	if button_pressed:
		$WorldEnvironment.environment = load("res://objects/misc/world.tres")
	else:
		$WorldEnvironment.environment = load("res://default_env.tres")


func _on_back_pressed():
	get_tree().change_scene("res://menus/MainMenu.tscn")


func _on_music_toggled(button_pressed):
	pass # Replace with function body.
