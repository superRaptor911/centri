extends Sprite

export var angular_velocity = 2.0
var speed = 0.0
var camera = null
signal current_rotator(rot)


func _ready():
	speed = angular_velocity * texture.get_height()
	

func _process(delta):
	rotation += angular_velocity * delta
	if camera and (camera.position - position).length() > 3000:
		queue_free()


func setOmega(w):
	angular_velocity = w
	speed = angular_velocity * texture.get_height()


func _on_Area2D_body_entered(body):
	if body.is_in_group("Ball"):
		var distance = (texture.get_height() * scale.x * 0.5 
			+ body.get_node("sprite").texture.get_height() * 0.5)
		var dir = (body.position - position).normalized()
		body.position = position + dir * distance
		
		body.setRevolving(position,angular_velocity)
		emit_signal("current_rotator",self)


func _on_Area2D_body_exited(body):
	if body.is_in_group("Ball"):
		self_modulate = Color(0,0,0,0)
		$CPUParticles2D.emitting = true
		$Area2D.queue_free()
		angular_velocity = 0
		yield(get_tree().create_timer(2.0), "timeout")
		queue_free()
