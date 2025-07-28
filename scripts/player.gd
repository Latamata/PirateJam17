extends CharacterBody2D

signal player_died
@export var move_speed: float = 200.0
@export var jump_velocity: float = -250.0
@export var gravity: float = 800.0
@export var can_jump: bool = true
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var quest_item_obtained = false

func _process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if is_on_wall() and not is_on_floor():
		velocity.y = velocity.y * 0.5

	if Input.is_action_pressed("ui_accept") and (is_on_floor() or is_on_wall()) and can_jump:
		velocity.y = jump_velocity
		can_jump = false
		$jump_timer.start()

	var direction = 0.0

	if Input.is_action_pressed('ui_right'):
		direction += 1
		$AnimatedSprite2D.flip_h = true
	elif Input.is_action_pressed('ui_left'):
		direction -= 1
		$AnimatedSprite2D.flip_h = false

	velocity.x = direction * move_speed

	# Set animation based on movement
	if direction != 0:
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")

	move_and_slide()


func player_died_function():
	print('player died')
	emit_signal('player_died')

func _on_jump_timer_timeout() -> void:
	can_jump = true
