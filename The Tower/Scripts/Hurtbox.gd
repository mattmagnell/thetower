extends Area2D

@onready var parent = $".."

func _on_hurtbox_body_entered(body):
	if body.is_in_group("Spells") and parent.in_cover == false:
		body.queue_free()
		get_parent().queue_free()
		print("hit, deleted")
