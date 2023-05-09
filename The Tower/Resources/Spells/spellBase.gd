extends RigidBody2D
class_name spellBase

@export var max_distance = 200
@export var attack_power: int
@export var spell_speed = 500
var start_position = Vector2.ZERO

func maxThrowDistance():
	if global_position.distance_to(start_position) > max_distance:
		queue_free()

func _physics_process(_delta):
	maxThrowDistance()

func _on_body_entered(_body):
	queue_free()
