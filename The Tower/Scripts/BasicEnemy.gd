extends CharacterBody2D
class_name BasicEnemy

# Common enemy variables
var speed = 100
var health = 3
var detection_radius = 300
var attack_radius = 50
var attack_damage = 1
var attack_cooldown = 1.0

# Internal variables
var player = null
var is_attacking = false
var last_attack_time = 0

enum State {
	IDLE,
	CHASE,
	ATTACK
}

var state = State.IDLE

func _ready():
	set_physics_process(false)
	
	# Check if the player instance is valid before accessing its properties
	if is_instance_valid(player):
		player.connect("player_died", self, "_on_player_died")
		set_physics_process(true)
	else:
		print("Player not found in the scene tree.")


func _physics_process(delta):
	match state:
		State.IDLE:
			idle_behavior(delta)
		State.CHASE:
			chase_behavior(delta)
		State.ATTACK:
			attack_behavior(delta)

func idle_behavior(_delta):
	var distance_to_player = global_position.distance_to(player.global_position)
	if distance_to_player <= detection_radius:
		state = State.CHASE

func chase_behavior(_delta):
	if is_instance_valid(player):
		var distance_to_player = global_position.distance_to(player.global_position)
		
		if distance_to_player < detection_radius:
			velocity = (player.global_position - global_position).normalized() * speed
		else:
			velocity = Vector2.ZERO
	else:
		velocity = Vector2.ZERO

func attack_behavior(_delta):
	if not is_attacking:
		is_attacking = true
		last_attack_time = Time.get_ticks_msec()
		attack()
		state = State.CHASE
	else:
		if Time.get_ticks_msec() - last_attack_time > attack_cooldown * 1000:
			is_attacking = false

func attack():
	player.take_damage(attack_damage)

func take_damage(damage):
	health -= damage
	if health <= 0:
		die()

func die():
	# Common death behavior for all enemies
	queue_free()

# Call this function in the player script to apply damage to the enemy
func _on_Player_attack_area_entered(area):
	if area.is_in_group("PlayerAttack"):
		take_damage(area.damage)
