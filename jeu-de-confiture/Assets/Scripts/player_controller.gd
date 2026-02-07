extends CharacterBody2D

class_name PlayerController

@export var speed = 10.0
@export var jump_vel = 10.0

var speed_mul = 30.0
var slow_mul = 0.05
var jump_mul = -30.0
var direction = 0
var can_control : bool = true
var positionStart
var death : bool = false

# const SPEED = 300.0
# const JUMP_VELOCITY = -400.0

func _ready():
	positionStart = global_position
	jump_vel = 10.0
	speed = 10.0

func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	if not can_control:
		return
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_vel * jump_mul

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, direction * speed * speed_mul, \
				speed * 5)
		else :
			velocity.x = move_toward(velocity.x, direction * speed * speed_mul, \
				speed)
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, speed * speed_mul * slow_mul)

	move_and_slide()
func handle_danger():
	can_control = false
	reset_player()
	
func reset_player():
	death = true
	TransitionFade.transition()
	await TransitionFade.on_transition_finished
	can_control = true
	velocity.x = 0
	velocity.y = 0
	death = false
	global_position = positionStart
	
