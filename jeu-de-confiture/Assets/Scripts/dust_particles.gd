extends GPUParticles2D

class_name Dust

@export var timer :  Timer

var particles : Array[Dust]

func play():
	if !timer.is_stopped():
		return

	timer.start()
	var new_particle = duplicate()

	add_child(new_particle)
	new_particle.emitting = true
	new_particle.finished.connect(func():
		remove_child(new_particle)
		new_particle.queue_free())
