extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = rand_range(3,6)
	$Timer.start()



func _on_Timer_timeout():
	queue_free()
