extends spellBase

func _ready():
	pass

func _on_body_entered(_body):
	queue_free()
