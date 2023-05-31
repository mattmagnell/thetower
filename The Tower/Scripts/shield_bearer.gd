extends CharacterBody2D

enum State {IDLE, CHASE, DEAD}

var state = State.IDLE
@export var speed: float = 25.0
@export var health: int = 10
var player
var debuff

func _physics_process(_delta):

	match state:
		State.IDLE:
			idle_behavior()
		State.CHASE:
			chase_behavior()
		State.DEAD:
			dead()


func idle_behavior():
	death_check()
	
func death_check():
	if health <= 0:
		state = State.DEAD
		
func chase_behavior():
	death_check()
	velocity = (player.global_position - global_position).normalized() * speed
	move_and_slide()
	
func dead():
	health = 0
	queue_free()
	
func _on_agro_range_body_entered(body):
	if body.is_in_group("Player"):
		print("Player Entered")
		player = body
		state = State.CHASE
		return player
	
func _on_agro_range_body_exited(body):
	if body.is_in_group("Player"):
		state = State.IDLE
		
func _on_hurtbox_body_entered(body):
	health -= body.attack_power
	
