extends CharacterBody2D

class_name PlayerController

@export var animated_sprite : AnimatedSprite2D

@export var speed = 10.0
@export var jump_vel = 10.0

var speed_mul = 30.0
var slow_mul = 0.05
var jump_mul = -30.0

var dashed = 0
#var rolling = 0

@export var jump_cost = 50
@export var dash_cost = 50

var direction = 0
var looking_at = 1

# const SPEED = 300.0
# const JUMP_VELOCITY = -400.0

func jump():
	var remaining_time = $Timer.get_time_left()
	if jump_cost < remaining_time and Input.is_action_just_pressed("jump") and is_on_floor():
		$Timer.update_time(jump_cost)
		velocity.y = jump_vel * jump_mul
#
#func roll(remaining_time : float = 100.0) -> bool :
	#if not Input.is_action_pressed("roll"):
		#return false
	#rolling = true
	#return true

# Makes the player move and allows him to roll to 
func move():
	if direction:
		# quicker movement on the ground
		if is_on_floor():
			velocity.x = move_toward(velocity.x, direction * speed * speed_mul, \
				speed * 5)
			return

		# slower turn in the air
		velocity.x = move_toward(velocity.x, direction * speed * speed_mul, \
			speed)

	elif is_on_floor():
		# rolling preserves momentum
		#if roll():
			#return
		# staying on the ground loses it
		velocity.x = move_toward(velocity.x, 0, speed * speed_mul * slow_mul)

# Makes the player dash and gives him some upward velocity and more angular momentum
func dash():
	var remaining_time = $Timer.get_time_left()
	if !Input.is_action_just_pressed("dash") or dashed or dash_cost > remaining_time:
		return
	dashed = true
	$Timer.update_time(dash_cost)
	velocity.x += speed * speed_mul * looking_at 
	velocity.y = jump_vel * jump_mul / 2

# Physics process
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		# rolling = false
		dashed = 0

	if direction: looking_at = direction

	jump()

	direction = Input.get_axis("move_left", "move_right")
	move()

	dash()

	move_and_slide()
