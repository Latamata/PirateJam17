extends Node2D

@onready var crap_page = preload("res://scenes/enemy_pages.tscn")

func _ready() -> void:
	$dialogue_manager.start('dialogue')

func split_book_spawns():
	var musketman_instance = crap_page.instantiate()

	add_child(musketman_instance)
	musketman_instance.global_position = Vector2(200,200)
	#print(musketman_instance.position)

func _on_enemy_book_split_into_pages() -> void:
	split_book_spawns()
