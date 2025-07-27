extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		body.quest_item_obtained = true
		print(body.quest_item_obtained)
		queue_free()
