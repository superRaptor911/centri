extends CanvasLayer

var fps = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	fps += 1


func _on_Timer_timeout():
	$Label.text = "Fps : " + String(fps)
	fps = 0
