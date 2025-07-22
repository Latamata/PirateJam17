extends CharacterBody2D

@export var move_speed: float = 200.0
@export var jump_velocity: float = -400.0
@export var gravity: float = 1000.0

func _process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if is_on_wall():
		velocity.y = 0.0
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
	var direction = 0.0
	if Input.is_action_pressed('ui_right'):
		direction += 1
	if Input.is_action_pressed('ui_left'):
		direction -= 1
	velocity.x = direction * move_speed
	move_and_slide()
