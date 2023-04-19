extends Area2D



func _on_body_entered(body):
	if body.wname == "Player":
		get_parent().go = true
		


