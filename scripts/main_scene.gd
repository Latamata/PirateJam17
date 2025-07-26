extends Node2D

@onready var camera_2d: Camera2D = $player/Camera2D
@onready var player: CharacterBody2D = $player
var player_dialogue_range = false
const DIALOGUE_MANAGER = preload("res://addons/dialogue/scenes/dialogue_manager.tscn")
const DIALOGUE = preload("res://addons/dialogue/scenes/dialogue.tscn")

func _on_npc_player_pressed() -> void:
	player_dialogue_range = true

func _input(_event):
	if Input.is_action_just_pressed('player_action'):
		print('running')
		if player_dialogue_range:
			player_dialogue_range = false
		talk_to_npc()

var active_dialogue_manager: Node = null
func talk_to_npc():
	if active_dialogue_manager: 
		return
	var manager = DIALOGUE_MANAGER.instantiate()
	var dialogue_ui = DIALOGUE.instantiate()
	manager.position = Vector2(329, 341)
	manager.add_child(dialogue_ui)
	$dialogue_layer.add_child(manager)
	active_dialogue_manager = manager
	manager.start("dialogue")

func _on_world_boundry_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		body.global_position = $player_spawn.global_position

func _on_npc_player_exited() -> void:
	player_dialogue_range = false
	if active_dialogue_manager:
		active_dialogue_manager.queue_free()
		active_dialogue_manager = null
