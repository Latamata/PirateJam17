extends Node2D

@onready var camera_2d: Camera2D = $player/Camera2D
@onready var player: CharacterBody2D = $player
var player_dialogue_range = false
const DIALOGUE_MANAGER = preload("res://addons/dialogue/scenes/dialogue_manager.tscn")
const DIALOGUE = preload("res://addons/dialogue/scenes/dialogue.tscn")
const TEST_DIALOGUE = preload("res://scenes/test_dialogue.tscn")
const ENEMY_SPAWN = preload("res://scenes/enemy_zero.tscn")
const GDD_SPAWN = preload("res://scenes/quest_item.tscn")
@onready var enemy_spawn: Marker2D = $enemy_spawn

func _ready() -> void:
	GDD_respawn()

func _on_npc_player_pressed() -> void:
	player_dialogue_range = true

func _input(_event):
	if Input.is_action_just_pressed('player_action'):
		talk_to_npc()

var active_dialogue_manager: Node = null
func talk_to_npc():
	if active_dialogue_manager: 
		return
	$quest_giver_sound.play()
	var manager = TEST_DIALOGUE.instantiate()
	$dialogue_layer.add_child(manager)
	active_dialogue_manager = manager

func _on_world_boundry_body_entered(body: Node2D) -> void:
	if body.is_in_group('enemy'):
		body.queue_free()
	if body.is_in_group('player'):
		player.player_died_function()
		body.quest_item_obtained = false
	
func _on_npc_player_exited() -> void:
	player_dialogue_range = false
	if active_dialogue_manager:
		$quest_giver_sound.stop()
		active_dialogue_manager.queue_free()
		active_dialogue_manager = null

func _on_player_player_died() -> void:
	print(player.quest_item_obtained)
	call_deferred("GDD_respawn")
	player.global_position = $player_spawn.global_position

func _on_timer_timeout() -> void:
	var enemy_instance = ENEMY_SPAWN.instantiate()
	enemy_instance.global_position = enemy_spawn.global_position
	get_tree().current_scene.add_child(enemy_instance)

var gdd_instance: Node = null  # add this at the top of your script

func GDD_respawn():
	if is_instance_valid(gdd_instance):
		return  # already exists

	gdd_instance = GDD_SPAWN.instantiate()
	gdd_instance.global_position = $GDD_spawn.global_position
	get_tree().current_scene.add_child(gdd_instance)
