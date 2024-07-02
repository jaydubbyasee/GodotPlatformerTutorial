extends Node2D

var can_restart: bool = false
	
func _physics_process(delta):
	if can_restart && Input.is_action_pressed("jump"):
		get_tree().reload_current_scene()


func _on_flagpole_goal_reached():
	print("You reached the goal")
	$CanvasLayer/WinMessage.show()
	can_restart = true


func _on_fall_out_of_bounds(body: Node2D):
	$CanvasLayer/DiedMessage.show()
	can_restart = true
