extends Node2D

@onready var crap_page = preload("res://scenes/enemy_pages.tscn")
@onready var one_page = preload("res://scenes/enemy_pages.tscn")
@onready var camera_2d: Camera2D = $player/Camera2D
@onready var player: CharacterBody2D = $player
@onready var dialogue_manager: Node2D = $dialogue_manager
var player_dialogue_range = false

func split_book_spawns(position_of_book):
	var musketman_instance = crap_page.instantiate()
	musketman_instance.global_position = position_of_book
	$enemy_group_node.add_child(musketman_instance)

func _on_enemy_book_split_into_pages(book_position: Vector2) -> void:
	split_book_spawns(book_position)

func _on_npc_player_pressed() -> void:
	player_dialogue_range = true

func _input(_event):
	if Input.is_action_pressed('player_action'):
		if player_dialogue_range:
			#print('in range of dialogeu')
			$dialogue_manager.start('dialogue')
			player_dialogue_range = false

func change_scene():
	get_tree().change_scene_to_file("res://scenes/mountain_scene.tscn")

func _on_level_door_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		call_deferred('change_scene')

func _on_world_boundry_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		body.global_position = $player_spawn.global_position
