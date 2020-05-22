extends Node

var tw_val = [Vector2(1,1),Vector2(1.5,1.5)]

signal restart
signal main_menu

func _ready():
	game_states.retry_count += 1	
	if game_states.retry_count % 9 == 0:
		game_states.admob.show_rewarded_video()
		game_states.admob.connect("rewarded_video_closed",self,"on_rewarded_video_closed")
	
	elif game_states.retry_count % 3 == 0:
		game_states.admob.show_interstitial()
		game_states.admob.connect("interstitial_closed",self,"on_interstitial_closed")


func on_rewarded_video_closed():
	game_states.admob.load_rewarded_video()

func on_interstitial_closed():
	game_states.admob.load_interstitial()


func showScore(score):
	$score2.text = "HIGH SCORE  " + String(game_states.player_info.high_score)
	$score.text = "SCORE  " + String(score)
	$new_high.hide()
	if score > game_states.player_info.high_score:
		$new_high.show()
		$score2.text = "HIGH SCORE  " + String(score)
		game_states.player_info.high_score = score
		game_states.saveEverything()
		tweenStart()


func tweenStart():
	$Tween.interpolate_property($new_high,"rect_scale",tw_val[0],tw_val[1],1,Tween.TRANS_QUAD,Tween.EASE_IN_OUT)
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
