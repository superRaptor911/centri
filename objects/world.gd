extends Node

var rotator_scn = preload("res://objects/rotator.tscn")

export var max_rot = 2
export var min_dist = 600
export var max_dist = 1000

var score = 0

var camera
var rott_id = 0
var rot_arr = Array()
var cur_rot_ref = null

func _ready():
	rand_seed(OS.get_unix_time())
	randomize()
	camera = $ball/Camera2D
	genRotators()


func genRotators(val = 0):
	var new_pos
	if val == 0:
		val = max_rot
	for i in range(val):
		new_pos = camera.global_position - Vector2(640,360) + genRandom()
		var rot = rotator_scn.instance()
		rot.position = new_pos
		rot.angular_velocity = rand_range(2,5)
		add_child(rot)
		rot.connect("current_rotator",self,"_on_landed_on_rotator")


func genRandom() -> Vector2:
	var rtn = Vector2()
	rtn.x = (randf() * (1280 - min_dist) + min_dist)
	rtn.y = (randf() * (720 - min_dist) + min_dist)
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
