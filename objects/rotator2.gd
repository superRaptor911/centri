extends "res://objects/rotator.gd"

var time_elapsed = 0
var speed = 100.0
var dir = Vector2()


func _ready():
	dir = Vector2(rand_range(-100,100), rand_range(-100,100)).normalized()


func _process(delta):
	position += dir * speed * delta
	time_elapsed += delta
	if time_elapsed > 2.0:
		time_elapsed = 0
		dir *= -1

func _on_Area2D_body_exited(body):
	speed = 0
	._on_Area2D_body_exited(body)
