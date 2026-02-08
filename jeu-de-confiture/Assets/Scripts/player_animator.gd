extends Node2D

@export var controller : PlayerController
@export var animated_sprite : AnimatedSprite2D
@export var landing_dust : Dust
@export var skid_dust : Dust
#@export var timer : Timer

func _process(_delta):
	if controller.direction == 1:
		animated_sprite.flip_h = false
	elif controller.direction == -1 :
		animated_sprite.flip_h = true

	if controller.death:
		animated_sprite.play("Dead")
		return

	if not controller.can_control:
		animated_sprite.play("Roll")
		return

	if !controller.is_on_floor() :
		if controller.dashed:
			animated_sprite.play("Roll")
			return

		if controller.velocity.y < 0 :
			animated_sprite.play("Jump")
		elif animated_sprite.get_animation() != "Fall" :
			animated_sprite.play("Fall")

	else :
		#if controller.rolling and not controller.direction:
			#animated_sprite.play("Roll")
			#return
		if abs(controller.velocity.x) > 0 :
			if (!controller.direction) :
				animated_sprite.play("Skid")
				if abs(controller.velocity.x) > 10 :
					skid_dust.play()
				return

			animated_sprite.play("Run")
		else :
			animated_sprite.play("Idle")
