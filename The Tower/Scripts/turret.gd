extends CharacterBody2D

enum State {IDLE, ATTACK, DEAD}

var state = State.IDLE
@export var speed: float = 0
@export var health: int = 5
@onready var shot = preload("res://Scenes/Spells/Circle/EnemyBallFilled.tscn")
@onready var attack_timer = $AttackTimer
var DIRECTIONS = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]

var player = null
var debuff

func _physics_process(_delta):
	match state:
		State.IDLE:
			idle_behavior()
		State.ATTACK:
			attack_behavior()
		State.DEAD:
			dead()


func idle_behavior():
	death_check()
	
func death_check():
	if health <= 0:
		state = State.DEAD
		
func attack_behavior():
	death_check()
	if attack_timer.is_stopped():
		turret_attack()
		attack_timer.start()

func dead():
	health = 0
	queue_free()
	
func _on_agro_range_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		state = State.ATTACK
	
func _on_agro_range_body_exited(body):
	if body.is_in_group("Player"):
		state = State.IDLE
		attack_timer.stop()

		
func _on_hurtbox_body_entered(body):
	health -= body.attack_power
	
func _on_attack_timer_timeout():
	turret_attack()
	
func turret_attack():
	for direction in DIRECTIONS:
			var spell_instance = shot.instantiate()
			spell_instance.global_position = global_position
			spell_instance.start_position = global_position
			spell_instance.linear_velocity = direction * spell_instance.spell_speed
			get_parent().add_child(spell_instance)
