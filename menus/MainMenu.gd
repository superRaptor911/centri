extends Node

var dots_scn = preload("res://objects/dot.tscn")
var scale_arr = [Vector2(1,1),Vector2(1.1,1.1)]

var tween : Tween
var b1 : Button
var b2 : Button
var b3 : Button

# Called when the node enters the scene tree for the first time.
func _ready():
	tween = $Tween
	b1 = $start
	b2 = $option
	b3 = $exit
	b1.rect_pivot_offset = b1.rect_size / 2
	b2.rect_pivot_offset = b2.rect_size / 2
	b3.rect_pivot_offset = b3.rect_size / 2
	$Admob.load_banner()
	$Admob.show_banner()
	if game_states.game_settings.glow:
		$WorldEnvironment.environment = load("res://objects/misc/world.tres")
	else:
		$WorldEnvironment.environment = load("res://default_env.tres")
	for i in range(20):
		var pos = Vector2(rand_range(0,1280),rand_range(0,720))
		var dot = dots_scn.instance()
		dot.position = pos
		add_child(dot)
	menuAnim()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_start_pressed():
	$Admob.hide_banner()
	get_tree().change_scene("res://objects/world.tscn")


func _on_option_pressed():
	get_tree().change_scene("res://menus/OptionMenu.tscn")


func _on_exit_pressed():
	get_tree().quit()


func _on_Timer_timeout():
	for i in range(20):
		var pos = Vector2(rand_range(0,1280),rand_range(0,720))
		var dot = dots_scn.instance()
		dot.position = pos
		add_child(dot)


func menuAnim():
	var mode = Tween.TRANS_SINE
	var time = 0.85
	tween.interpolate_property(b1,"rect_scale",scale_arr[0],scale_arr[1],
		time,mode,Tween.EASE_IN_OUT)
	tween.interpolate_property(b2,"rect_scale",scale_arr[0],scale_arr[1],
		time,mode,Tween.EASE_IN_OUT)
	tween.interpolate_property(b3,"rect_scale",scale_arr[0],scale_arr[1],
		time,mode,Tween.EASE_IN_OUT)
	tween.start()



func _on_Tween_tween_all_completed():
	scale_arr.invert()
	menuAnim()
