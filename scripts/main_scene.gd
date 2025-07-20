extends Node2D

@onready var crap_page = preload("res://scenes/enemy_pages.tscn")
@onready var one_page = preload("res://scenes/enemy_pages.tscn")

func _ready() -> void:
	$dialogue_manager.start('dialogue')

func split_book_spawns(position_of_book):
	var musketman_instance = crap_page.instantiate()
	musketman_instance.global_position = position_of_book
	$enemy_group_node.add_child(musketman_instance)

func _on_enemy_book_split_into_pages(book_position: Vector2) -> void:
	split_book_spawns(book_position)
