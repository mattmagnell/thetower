extends CharacterBody2D

class_name Slime

# States
enum {
	PATROL,
	SPLIT,
}

var state = PATROL

# Patrol
var patrol_points = []
var current_patrol_point = 0
var speed = 100

# Signal to hurt player
signal slime_hit_player

func _ready():
	# Define patrol points
	patrol_points = [global_position + Vector2(-100, 0), global_position + Vector2(100, 0)]
	set_state(PATROL)

func _physics_process(delta):
	match state:
		PATROL:
			patrol(delta)
		SPLIT:
			pass

func set_state(new_state):
	state = new_state

func patrol(_delta):
	var target = patrol_points[current_patrol_point]
	var direction = (target - global_position).normalized()
	var distance_to_target = global_position.distance_to(target)
	
	if distance_to_target > 5:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
		current_patrol_point = (current_patrol_point + 1) % patrol_points.size()

func _on_MovementTimer_timeout():
	current_patrol_point = (current_patrol_point + 1) % patrol_points.size()

func _on_Slime_body_entered(body):
	if body.is_in_group("Player"):
		body.health -= 1
		emit_signal("slime_hit_player")
	elif body.is_in_group("Projectile"):
		set_state(SPLIT)

