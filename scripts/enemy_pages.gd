extends CharacterBody2D

# Variables
var direction = Vector2.RIGHT
var SPEED = 50.0
var target

func _process(_delta):
	velocity = direction * SPEED
	move_and_slide()
