extends spellBase
class_name spellElemental

var debuff 

func _ready():
	pass
	
func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		body.debuff = null
	queue_free()
