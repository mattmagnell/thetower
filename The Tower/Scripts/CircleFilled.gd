extends Node2D

@export var speed = 400.0
var direction = Vector2.ZERO

func _physics_process(delta):
	global_position += direction * speed * delta

	var screen_size = get_viewport().size
	if global_position.x < 0 or global_position.x > screen_size.x or global_position.y < 0 or global_position.y > screen_size.y:
		queue_free()

func _on_area_entered(area):
	queue_free()

