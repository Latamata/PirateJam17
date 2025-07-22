extends Node2D

@onready var crap_page = preload("res://scenes/enemy_pages.tscn")
@onready var one_page = preload("res://scenes/enemy_pages.tscn")
@onready var camera_2d: Camera2D = $player/Camera2D
@onready var player: CharacterBody2D = $player
@onready var dialogue_manager: Node2D = $dialogue_manager
#var dialogue_box: PackedScene = preload("res://addons/dialogue/scenes/dialogue.tscn")

#func _ready() -> void:
	#$dialogue_manager.start('dialogue')
#func _process(delta: float) -> void:
	#if $dialogue_manager != null:
		#$dialogue_manager.global_position = player.global_position

func split_book_spawns(position_of_book):
	var musketman_instance = crap_page.instantiate()
	musketman_instance.global_position = position_of_book
	$enemy_group_node.add_child(musketman_instance)

func _on_enemy_book_split_into_pages(book_position: Vector2) -> void:
	split_book_spawns(book_position)

func _on_npc_player_pressed() -> void:
	#var new_dialogue = dialogue_box.instantiate()
	#$player/dialogue_node.add_child(new_dialogue)
	#new_dialogue.start('dialogue')
	$dialogue_manager.start('dialogue')
