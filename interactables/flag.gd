extends Area2D

@export var character : CharacterBody2D

signal goal_reached

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body == character:
		goal_reached.emit()
