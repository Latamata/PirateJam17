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

func massive_expectations():
	print("Welcome to the jam, pirate!")
	await get_tree().create_timer(1).timeout
	print("Now go make your dream game...")
	await get_tree().create_timer(1).timeout
	print("Also submit a 10-page GDD.")
	await get_tree().create_timer(1).timeout
	print("It must be a Google Drive link.")
	await get_tree().create_timer(1).timeout
	print("PDFs? Unacceptable.")
	await get_tree().create_timer(1).timeout
	print("Fun is optional. Structure is mandatory.")
