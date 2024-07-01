extends Area2D


func _on_body_entered(body: Node2D):
	if "add_coins" in body:
		body.add_coins(1)
	queue_free()
