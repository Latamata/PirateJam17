extends CharacterBody2D

#signal split_into_pages(book_position: Vector2)
# Variables
var direction = Vector2.RIGHT
var SPEED = 50.0
var target
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _process(_delta):
	if ray_cast_left.is_colliding():
		var collider = ray_cast_left.get_collider()
		if collider.is_in_group('player'):
			collider.player_died_function()
		direction *= -1

	if ray_cast_right.is_colliding():
		var collider = ray_cast_right.get_collider()
		if collider.is_in_group('player'):
			collider.player_died_function()
		direction *= -1

	velocity = direction * SPEED

	# Flip sprite based on direction
	#animated_sprite_2d.flip_h = direction < 0

	# Play walk animation
	animated_sprite_2d.play("run")

	move_and_slide()

func GDD_broken():
	emit_signal('split_into_pages', global_position)
	queue_free()

func _on_timer_timeout() -> void:
	GDD_broken()
