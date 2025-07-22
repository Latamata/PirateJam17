extends CharacterBody2D

@export var move_speed: float = 200.0
@export var jump_velocity: float = -200.0
@export var gravity: float = 1000.0
@export var can_jump: bool = true

func _process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if is_on_wall():
		velocity.y = velocity.y * 0.5
	if Input.is_action_pressed("ui_accept") and (is_on_floor() or is_on_wall()) && can_jump:
		velocity.y = jump_velocity
		can_jump = false
		$jump_timer.start()
	var direction = 0.0
	if Input.is_action_pressed('ui_right'):
		direction += 1
	if Input.is_action_pressed('ui_left'):
		direction -= 1
	velocity.x = direction * move_speed
	move_and_slide()


func _on_jump_timer_timeout() -> void:
	can_jump = true
	#print('rnianndf')
