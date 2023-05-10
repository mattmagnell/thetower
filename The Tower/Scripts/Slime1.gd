extends CharacterBody2D

enum State {PATROL, CHASE, DEAD}
var state = State.PATROL

@export var speed = 100
@export var patrol_points = [Vector2(-50, 0), Vector2(50, 0)]
var current_patrol_point = 0

var player_detection_radius = 200

@export var health = 5
var debuff 

func _ready():
	patrol_points = [global_position + patrol_points[0], global_position + patrol_points[1]]

func _physics_process(_delta):
	match state:
		State.PATROL:
			death_check()
			patrol()
		State.CHASE:
			death_check()
			chase()
		State.DEAD:
			dead()
			

func patrol():
	var target = patrol_points[current_patrol_point]
	var direction = (target - global_position).normalized()
	var distance_to_target = global_position.distance_to(target)
	
	if distance_to_target > 5:
		velocity = direction * speed
		move_and_slide()
	else:
		current_patrol_point = (current_patrol_point + 1) % patrol_points.size()

func chase():
	pass
	
func death_check():
	if health <= 0:
		state = State.DEAD
		
func dead():
	health = 0
	queue_free()
	
func _on_hurtbox_body_entered(body):
	health -= body.attack_power
	
		
