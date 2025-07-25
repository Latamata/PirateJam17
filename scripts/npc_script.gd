extends CharacterBody2D

signal player_pressed
signal player_exited
@onready var press_to_talk_text: RichTextLabel = $press_to_talk_text

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		emit_signal('player_pressed')

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group('player'):
		emit_signal('player_exited')
