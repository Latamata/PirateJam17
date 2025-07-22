extends CharacterBody2D

signal player_pressed
@onready var press_to_talk_text: RichTextLabel = $press_to_talk_text

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		#print('player in range')
		emit_signal('player_pressed')
