extends Node

var tw_val = [Vector2(1,1),Vector2(1.5,1.5)]

signal restart
signal main_menu

func _ready():
	pass


func showScore(score):
	$score.text = "SCORE  " + String(score)
	tweenStart()


func tweenStart():
	$Tween.interpolate_property($Label,"rect_scale",tw_val[0],tw_val[1],1,Tween.TRANS_QUAD,Tween.EASE_IN_OUT)
	$Tween.start()




func _on_Tween_tween_completed(object, key):
	tw_val.invert()
	tweenStart()


func _on_retry_pressed():
	emit_signal("restart")
	queue_free()


func _on_main_menu_pressed():
	emit_signal("main_menu")
	queue_free()
