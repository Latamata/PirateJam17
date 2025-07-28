extends Node2D

@onready var camera_2d: Camera2D = $player/Camera2D
@onready var player: CharacterBody2D = $player
var player_dialogue_range = false
const DIALOGUE_MANAGER = preload("res://addons/dialogue/scenes/dialogue_manager.tscn")
const DIALOGUE = preload("res://addons/dialogue/scenes/dialogue.tscn")
const TEST_DIALOGUE = preload("res://scenes/test_dialogue.tscn")
const ENEMY_SPAWN = preload("res://scenes/enemy_zero.tscn")
@onready var enemy_spawn: Marker2D = $enemy_spawn

func _on_npc_player_pressed() -> void:
	player_dialogue_range = true

func _input(_event):
	if Input.is_action_just_pressed('player_action'):
		talk_to_npc()

var active_dialogue_manager: Node = null
func talk_to_npc():
	if active_dialogue_manager: 
		return
	var manager = TEST_DIALOGUE.instantiate()

	$dialogue_layer.add_child(manager)
	active_dialogue_manager = manager

func _on_world_boundry_body_entered(body: Node2D) -> void:
	if body.is_in_group('enemy'):
		body.queue_free()
	if body.is_in_group('player'):
		body.global_position = $player_spawn.global_position
	
func _on_npc_player_exited() -> void:
	player_dialogue_range = false
	if active_dialogue_manager:
		active_dialogue_manager.queue_free()
		active_dialogue_manager = null

func _on_player_player_died() -> void:
	player.global_position = $player_spawn.global_position

func _on_timer_timeout() -> void:
	var enemy_instance = ENEMY_SPAWN.instantiate()
	enemy_instance.global_position = enemy_spawn.global_position
	get_tree().current_scene.add_child(enemy_instance)
