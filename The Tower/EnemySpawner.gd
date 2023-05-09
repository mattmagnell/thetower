extends Node2D

@export var EnemyScene: PackedScene 
@export var respawn_delay: float = 3.0

func _ready():
	# Spawn the enemy for the first time
	spawn_enemy()

func spawn_enemy():
	var enemy = EnemyScene.instance()
	enemy.connect("enemy_killed", self, "_on_enemy_killed")
	add_child(enemy)

func _on_enemy_killed(position):
	await get_tree().create_timer(respawn_delay).
	var new_enemy = EnemyScene.instance()
	new_enemy.global_position = position
	new_enemy.connect("enemy_killed", self, "_on_enemy_killed")
	add_child(new_enemy)
