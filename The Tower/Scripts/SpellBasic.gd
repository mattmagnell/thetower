extends RigidBody2D

@export var max_distance = 100
var start_position

func _ready():
	start_position = global_position

func _physics_process(_delta):
	if global_position.distance_to(start_position) > max_distance:
		queue_free()
		print("deleted")

func _on_Spell_body_entered(body):
	queue_free()
	if body.is_in_group("Enemy"):
		body.queue_free()
