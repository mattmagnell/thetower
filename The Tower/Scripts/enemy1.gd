extends CharacterBody2D


var go = false
const speed = 80
var motion = Vector2(0,0)
@onready var p = $"../Player"

func _physics_process(_delta):
	if go == true:
		
		motion = position.direction_to(p.position)*speed

	motion = move_and_slide()








