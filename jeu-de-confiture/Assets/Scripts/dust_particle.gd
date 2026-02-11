extends GPUParticles2D

class_name Dust

var times_to_emit : int = 0

func emit(number : int = 1):
	if (number <= 0):
		return
	times_to_emit = number

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (times_to_emit > 0):
		if (!emitting):
			emitting = true
		times_to_emit -= 1
	else:
		if (emitting):
			emitting = false
