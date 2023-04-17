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
	
func _input(event):
	if event.is_action_pressed("cast_spell"):
		var spell_scene = preload("res://Scenes/Spells/Circle/CircleFilled.tscn")
		var spell = spell_scene.instantiate()
		spell.direction = get_global_mouse_position() - global_position
		spell.direction = spell.direction.normalized()
		spell.global_position = global_position
		get_parent().add_child(spell)
