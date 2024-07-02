extends Area2D

func _ready():
	$AudioStreamPlayer2D.finished.connect(_on_pickup_audio_finished)

# This gets called when a node enters this Area2D
func _on_body_entered(body: Node2D):
	# Call add_coins on the body that has entered the coin's collision shape
	# Enqueues removal from scene tree and deallocation of this object from memory
	if "add_coins" in body:
		body.add_coins(1)
		$AudioStreamPlayer2D.play()
		# Hide this scene
		hide()
		
func _on_pickup_audio_finished():
	queue_free()
