extends CharacterBody2D

# Modify this to adjust how quickly your character moves, this has also been exported to the editor
# so you can modify it on your scene instance as well
@export var speed = 300.0
@export var jump_velocity = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal player_died

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		$AnimatedSprite2D.play("jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		# If we were not walking before, start walk animation
		$AnimatedSprite2D.flip_h = direction > 0
		velocity.x = direction * speed
		$AnimatedSprite2D.play("walk")
		
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		$AnimatedSprite2D.play("default")

	move_and_slide()
	
func on_hit():
	player_died.emit()
