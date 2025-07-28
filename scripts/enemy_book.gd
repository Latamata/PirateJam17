extends CharacterBody2D

const SPEED = 50
const GRAVITY = 400
var direction := -1  
var target
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta):
	velocity.y += GRAVITY * delta
	if ray_cast_left.is_colliding():
		var collider = ray_cast_left.get_collider()
		if collider.is_in_group('player'):
			collider.player_died_function()
		direction = 1
	if ray_cast_right.is_colliding():
		var collider = ray_cast_right.get_collider()
		if collider.is_in_group('player'):
			collider.player_died_function()
		direction = -1
	velocity.x = direction * SPEED
	animated_sprite_2d.flip_h = direction < 0
	animated_sprite_2d.play("run")
	move_and_slide()

func GDD_broken():
	emit_signal('split_into_pages', global_position)
	queue_free()

func _on_timer_timeout() -> void:
	GDD_broken()
