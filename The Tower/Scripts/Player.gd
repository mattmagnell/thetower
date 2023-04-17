extends CharacterBody2D

const SPEED = 150.0

func _physics_process(delta):
	var direction_x = Input.get_axis("move_left", "move_right")
	var direction_y = Input.get_axis("move_up", "move_down")
	var direction = Vector2(direction_x, direction_y)

	if direction.length() > 0:
		direction = direction.normalized() * SPEED
		velocity = direction
	else:
		velocity = Vector2.ZERO

	move_and_slide()
