extends spellBase

func _ready():
	pass

func _on_body_entered(body):
	queue_free()
