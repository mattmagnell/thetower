extends spellBase

func _ready():
	pass

func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		body.health -= attack_power
	queue_free()
