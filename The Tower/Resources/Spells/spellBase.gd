extends RigidBody2D
class_name spellBase

@export var max_distance = 200
var start_position

func maxThrowDistance():
	if global_position.distance_to(start_position) > max_distance:
		queue_free()

func _ready():
	start_position = global_position

func _physics_process(_delta):
	maxThrowDistance()

func _on_Spell_body_entered(body):
	queue_free()


