extends Node2D


@onready var camera_2d: Camera2D = $player/Camera2D
@onready var player: CharacterBody2D = $player
var player_dialogue_range = false
#@onready var dialogue_manager: Node2D = $CanvasLayer/dialogue_manager
const DIALOGUE_MANAGER = preload("res://addons/dialogue/scenes/dialogue_manager.tscn")
const DIALOGUE = preload("res://addons/dialogue/scenes/dialogue.tscn")
#func _ready() -> void:
	#$CanvasLayer/dialogue_manager.start('dialogue')
func _on_enemy_book_split_into_pages(book_position: Vector2) -> void:
	var starting_position = Vector2(-200, -90)
	var row_offset = Vector2(50, 0)
	var column_offset = Vector2(50, 50)
	var column_height = 2

	for i in range(8):
		var row = i % column_height
		var column = floori(float(i) / float(column_height))
		var spawn_pos = starting_position + column * column_offset + row * row_offset
		#split_book_spawns(spawn_pos)

func _on_npc_player_pressed() -> void:
	player_dialogue_range = true

func _input(_event):
	if Input.is_action_just_pressed('player_action'):
		if player_dialogue_range:
			player_dialogue_range = false
			talk_to_npc()

#const DIALOGUE_MANAGER = preload("res://addons/dialogue/scenes/dialogue_manager.tscn")
#const DIALOGUE = preload("res://addons/dialogue/scenes/dialogue.tscn")

func talk_to_npc():
	var manager = DIALOGUE_MANAGER.instantiate()
	var dialogue_ui = DIALOGUE.instantiate()
	
	manager.position = Vector2(329,341)
	manager.add_child(dialogue_ui) # dialogue_ui becomes a child of the manager
	$CanvasLayer.add_child(manager) # manager goes into the scene
	
	manager.start("dialogue") # replace with your actual dialogue resource name

func _on_level_door_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		call_deferred('change_scene')

func _on_world_boundry_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		body.global_position = $player_spawn.global_position
