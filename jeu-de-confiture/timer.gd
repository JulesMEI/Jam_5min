extends Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ChangeLabel.start()
	$".".start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_time(used: float):
	print_debug("IN UPDATE TIME")
	var time_left = $".".get_time_left()
	var total = time_left - used
	print_debug(total)
	$".".start(total)
	$TimerLabel.text = str(int($".".get_time_left()))


func _on_change_label_timeout() -> void:
	$TimerLabel.text = str(int($".".get_time_left()))
