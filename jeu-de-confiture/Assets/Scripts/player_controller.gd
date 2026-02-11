extends CharacterBody2D

class_name PlayerController
@export var timer: Timer
@export var animated_sprite : AnimatedSprite2D
@export var splash_dust : Dust

@export var speed = 10.0
@export var jump_vel = 15.0

var speed_mul = 30.0
var slow_mul = 0.1
var jump_mul = -30.0

var dashed = false
var double_jumped = false
var was_airborne = false
#var rolling = 0

@export var jump_cost = 50
@export var db_jump_cost = 25
@export var dash_cost = 50

var direction = 0
var can_control : bool = true
var can_move : bool = true
var positionStart
var death : bool = false
var looking_at = 1
var nbr_jump = 2

var last_time_decrement = 0

# const SPEED = 300.0
# const JUMP_VELOCITY = -400.0

func _ready():
	positionStart = global_position
	jump_vel = 10.0
	speed = 10.0

func normalize_scale(delta):
	animated_sprite.scale.x = move_toward(animated_sprite.scale.x, 1, 6  *  delta)
	animated_sprite.scale.y = move_toward(animated_sprite.scale.y, 1, 3 * delta)

func jump():
	var remaining_time = timer.get_time_left()

	if jump_cost < remaining_time and Input.is_action_just_pressed("jump") and is_on_floor():
		last_time_decrement = jump_cost
		timer.update_time(jump_cost)
		animated_sprite.scale = Vector2(0.6, 1.3)
		splash_dust.emit(5)
		velocity.y = jump_vel * jump_mul
		$Audio/Jump.pitch_scale = 1.0
		$Audio/Jump.play()
		nbr_jump -= 1

	if db_jump_cost < remaining_time and Input.is_action_just_pressed("jump") and not is_on_floor() and nbr_jump > 0:
		last_time_decrement = db_jump_cost
		timer.update_time(db_jump_cost)
		animated_sprite.scale = Vector2(0.6, 1.3)
		splash_dust.emit(3)
		$Audio/Jump.pitch_scale = 1.3
		$Audio/Jump.play()
		velocity.y = jump_vel * jump_mul
		nbr_jump -= 1

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
	animated_sprite.scale = Vector2(1.5, 0.7)
	dashed = true
	splash_dust.emit(5)
	last_time_decrement = dash_cost
	$Timer.update_time(dash_cost)
	velocity.x += speed * speed_mul * looking_at
	velocity.y = jump_vel * jump_mul / 2
	$Audio/Dash.play()


func landing():
	animated_sprite.scale = Vector2(1.5, 0.7)
	splash_dust.emit(3)

# Physics process
func _physics_process(delta: float) -> void:

	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
		was_airborne = true
	else:
		if was_airborne:
			# Landing
			was_airborne = false
			animated_sprite.scale = Vector2(1.5, 0.7)
			$Camera2D.screen_shake(2, 0.8)
			nbr_jump = 2
			landing()

		# rolling = false
		dashed = 0

#	RESTART HANDLING (TBR)
	if not can_control:
		if can_move:
			move_and_slide()
		normalize_scale(delta)
		return

	if direction: looking_at = direction

	jump()

	direction = Input.get_axis("move_left", "move_right")

	move()
	dash()

	if can_move:
		move_and_slide()

	normalize_scale(delta)

#	 RESTART HANDLING (TO BE REWORKED)
	restart()
	if timer.is_terminated():
		handle_danger()


func handle_danger():
	can_control = false
	reset_player()
	timer.reset()

func reset_player():
	death = true
	TransitionFade.transition()
	velocity.x += 200 * -looking_at
	velocity.y = jump_vel * jump_mul

	animated_sprite.flip_h = true if velocity.x > 0 else false
	splash_dust.emit(50) 
	await TransitionFade.on_transition_finished
	velocity = Vector2(0.0, 0.0)
	global_position = positionStart
	can_control = true
	death = false

func restart():
	if Input.is_action_just_pressed("restart_level"):
		handle_danger()
