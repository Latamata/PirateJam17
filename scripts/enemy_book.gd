extends CharacterBody2D

signal split_into_pages(book_position: Vector2)
# Variables
var direction = Vector2.RIGHT
var SPEED = 50.0
var target

func _process(_delta):
		velocity = direction * SPEED
		move_and_slide()

func GDD_broken():
	emit_signal('split_into_pages', global_position)
	queue_free()

func _on_timer_timeout() -> void:
	GDD_broken()
