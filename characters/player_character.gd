class_name PlayerCharacter

extends CharacterBody2D

# Modify this to adjust how quickly your character moves, this has also been exported to the editor
# so you can modify it on your scene instance as well
@export var speed: float = 300.0
@export var jump_velocity: float = -400.0
@export var max_jumps: int = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_counter: int = 0

var coins_collected: int = 0

signal player_died

signal coins_update

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		jump_counter = 0

	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_counter < max_jumps:
		# Reset jump counter
		jump_counter += 1
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


func add_coins(value: int = 1):
	coins_collected += value
	coins_update.emit(coins_collected)


func _on_fall_out_of_bounds(body):
	set_physics_process(false)
	$CPUParticles2D.emitting = true
	$CPUParticles2D.restart()
	$AnimatedSprite2D.hide()
	player_died.emit()
