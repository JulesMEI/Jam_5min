extends Node2D

@export var controller : PlayerController
@export var animated_sprite : AnimatedSprite2D
@export var timer : Timer

func _process(_delta):
	if controller.direction == 1:
		animated_sprite.flip_h = false
	elif controller.direction == -1 :
		animated_sprite.flip_h = true

	if !controller.is_on_floor() :
		if controller.dashed:
			animated_sprite.play("Roll")
			return

		if controller.velocity.y < 0 :
			animated_sprite.play("Jump")
		else :
			animated_sprite.play("Fall")

	else :
		#if controller.rolling and not controller.direction:
			#animated_sprite.play("Roll")
			#return
		if abs(controller.velocity.x) > 0 :
			animated_sprite.play("Run")
		else :
			animated_sprite.play("Idle")
