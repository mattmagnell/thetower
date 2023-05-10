extends Area2D

@onready var parent = $".."

func _on_hurtbox_body_entered(body):
	if body.is_in_group("Spells"):
		parent.health -= body.attack_power
		parent.debuff = body.debuff
		print(parent.health)
