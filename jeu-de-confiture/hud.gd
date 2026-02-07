extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$UpdateLabel.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_update_label_timeout() -> void:
	$TimerLabel.text = str(int($"../Player/Timer".get_time_left()))
