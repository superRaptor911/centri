extends Node

var rotator_scn = preload("res://objects/rotator.tscn")
var game_scn = preload("res://objects/game.tscn")
var game_over_scn = preload("res://menus/GameOver.tscn")

export var max_rot = 2
export var min_dist = 600
export var max_dist = 1000

var score = 0

var camera = null
var game = null
var rott_id = 0
var rot_arr = Array()
var cur_rot_ref = null

func _ready():
	game_states.main_music.stop()
	rand_seed(OS.get_unix_time())
	randomize()
	if game_states.game_settings.glow:
		$WorldEnvironment.environment = load("res://objects/misc/world.tres")
	else:
		$WorldEnvironment.environment = load("res://default_env.tres")
	startGame()


func startGame():
	if game:
		print_debug("Error : game not freed")
		game.queue_free()
	
	game = game_scn.instance()
	add_child(game)
	camera = game.get_node("ball/Camera2D")
	game.get_node("ball").connect("game_over",self,"_on_game_over")
	genRotators()
	#yield(get_tree().create_timer(1), "timeout")
	$music.play()


func endGame():
	pass

func genRotators(val = 0):
	var new_pos
	if val == 0:
		val = max_rot
	for i in range(val):
		new_pos = camera.global_position - Vector2(640,360) + genRandom()
		var rot = rotator_scn.instance()
		rot.position = new_pos
		rot.angular_velocity = rand_range(2,5)
		game.add_child(rot)
		rot.connect("current_rotator",self,"_on_landed_on_rotator")


func genRandom() -> Vector2:
	var rtn = Vector2()
	rtn.x = (randf() * (1280 - min_dist) + min_dist)
	rtn.y = (randf() * (720 - min_dist) + min_dist)
	var rots = get_tree().get_nodes_in_group("Rotator")
	print(rots.size())
	for i in rots:
		if (i.position - rtn).length() < 250:
			print("close call fixing")
			rtn += (rtn - i.position).normalized() * 200
	return rtn


func _on_landed_on_rotator(rotator):
	genRotators(1)
	score += 1
	var label = $CanvasLayer/score/Label
	label.text = String(score)
	$Tween.stop_all()
	$Tween.interpolate_property(label,"rect_scale",Vector2(1,1),Vector2(1.5,1.5),1,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
	$Tween.interpolate_property(label,"rect_scale",Vector2(1.5,1.5),Vector2(1,1),0.6,Tween.TRANS_QUAD,Tween.EASE_OUT,1.1)
	$Tween.start()


func _on_TouchScreenButton_pressed():
	Input.action_press("ui_up")


func _on_game_over():
	$music.stop()
	yield(get_tree().create_timer(1.5), "timeout")
	$CanvasLayer/score.hide()
	game.queue_free()
	game = null
	var game_over = game_over_scn.instance()
	add_child(game_over)
	game_over.showScore(score)
	game_over.connect("restart",self,"restartGame")
	game_over.connect("main_menu",self,"go_to_mainMenu")
	score = 0


func restartGame():
	$CanvasLayer/score/Label.text = "0"
	$CanvasLayer/score.show()
	startGame()

func go_to_mainMenu():
	game_states.main_music.play()
	get_tree().change_scene("res://menus/MainMenu.tscn")
