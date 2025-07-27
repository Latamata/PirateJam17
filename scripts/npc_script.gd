extends CharacterBody2D

signal player_pressed
signal player_exited
@onready var press_to_talk_text: RichTextLabel = $press_to_talk_text

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		if body.quest_item_obtained:
			get_tree().call_deferred("change_scene_to_file", "res://scenes/win_scene.tscn")

		else:
			emit_signal('player_pressed')

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group('player'):
		emit_signal('player_exited')
