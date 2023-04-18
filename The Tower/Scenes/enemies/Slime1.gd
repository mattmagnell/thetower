extends CharacterBody2D

enum EnemyState {
	IDLE,
	PATROL,
	CHASE,
	ATTACK
}

var state = EnemyState.PATROL
@onready var initial_position = position
@onready var player = get_tree().get_nodes_in_group("Player")[0] if get_tree().get_nodes_in_group("Player").size() > 0 else null
@onready var raycast = $PlayerCast
@onready var wall_raycast = $WallCast

const SPEED = 100
const ACCELERATION = 10
const PATROL_DISTANCE = 200
const CHASE_DISTANCE = 200
const ATTACK_DISTANCE = 20
const STOP_CHASE_DISTANCE = 200

@onready var patrol_target = position + Vector2(PATROL_DISTANCE, 0)

func _physics_process(delta):
	if player != null:
		match state:
			EnemyState.IDLE:
				idle_logic(delta)
			EnemyState.PATROL:
				patrol_logic(delta)
			EnemyState.CHASE:
				chase_logic(delta)
			EnemyState.ATTACK:
				attack_logic(delta)

func idle_logic(_delta):
	var distance_to_player = position.distance_to(player.position)
	if distance_to_player <= CHASE_DISTANCE:
		state = EnemyState.CHASE

var returning_to_initial_position = false

func patrol_logic(delta):
	var target_direction
	if returning_to_initial_position:
		target_direction = (initial_position - position).normalized()
		if target_direction == initial_position:
			returning_to_initial_position = false
			patrol_target = position + Vector2(randf_range(-PATROL_DISTANCE, PATROL_DISTANCE), 0)
	else:
		target_direction = (patrol_target - position).normalized()
		if position.distance_to(patrol_target) < 10 or wall_raycast.is_colliding():
			patrol_target = position + Vector2(randf_range(-PATROL_DISTANCE, PATROL_DISTANCE), 0)

	velocity = velocity.lerp(target_direction * SPEED, ACCELERATION * delta)
	move_and_slide()

	var distance_to_player = position.distance_to(player.position)
	if distance_to_player <= CHASE_DISTANCE:
		state = EnemyState.CHASE


func chase_logic(delta):
	# Rotate the raycast towards the player
	raycast.rotation = (player.position - position).angle()

	# Check if the raycast is colliding with the player
	var sees_player = raycast.is_colliding() and raycast.get_collider() == player

	if sees_player:
		var target_direction = (player.position - position).normalized()
		velocity = velocity.lerp(target_direction * SPEED, ACCELERATION * delta)
		move_and_slide()
	else:
		state = EnemyState.PATROL
		returning_to_initial_position = true

	var distance_to_player = position.distance_to(player.position)
	if distance_to_player <= ATTACK_DISTANCE:
		state = EnemyState.ATTACK
	elif distance_to_player > STOP_CHASE_DISTANCE:
		state = EnemyState.PATROL

func attack_logic(_delta):
	# Implement attack behavior
	# (add your attack logic here)
	var distance_to_player = position.distance_to(player.position)
	if distance_to_player > ATTACK_DISTANCE:
		state = EnemyState.CHASE



