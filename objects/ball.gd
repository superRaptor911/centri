extends KinematicBody2D


var angular_velocity = 0
export var velocity = 400
var is_revolving = false
var radius = 100.0
var pivot = Vector2()

var angle = 0.0
var mov_dir = Vector2()
var rot_ref = null

var time_elaped = 0

signal game_over

func _ready():
	#setRevolving(Vector2(640,360),0.1,null)
	pass

func _physics_process(delta):
	if is_revolving:
		angle += angular_velocity * delta
		if rot_ref:
			position += rot_ref.position - pivot
			pivot = rot_ref.position
		position = pivot +  Vector2(cos(angle),sin(angle)) * radius
		time_elaped = 0
	else:
		position += mov_dir * velocity * delta
		time_elaped += delta

func setRevolving(pos,w,ref):
	is_revolving = true
	pivot = pos
	rot_ref = ref
	angular_velocity = w
	radius = (position - pos).length()
	angle = position.angle_to_point(pos)
	$jump.play()
	

func detach():
	if is_revolving:
		rot_ref = null
		is_revolving = false
		mov_dir = Vector2(cos(angle + PI /2),sin(angle + PI / 2))
		$die.play()


func _process(_delta):
	if Input.is_action_just_pressed("ui_up"):
		detach()
	if time_elaped > 2.0:
		time_elaped = 0
		$sprite.hide()
		$CPUParticles2D.emitting = false
		$explode.emitting = true
		velocity = 0
		$die.play()
		emit_signal("game_over")
