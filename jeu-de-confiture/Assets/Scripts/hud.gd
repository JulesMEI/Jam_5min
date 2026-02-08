extends CanvasLayer
@onready var player : PlayerController = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$UpdateLabel.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.last_time_decrement != 0 :
		$TimerMinus.text = str("-", player.last_time_decrement)
		player.last_time_decrement = 0
		$TimerMinus/AnimationPlayer.stop(true)
		$TimerMinus/AnimationPlayer.play("MinusFade")
		


func _on_update_label_timeout() -> void:
	$TimerLabel.text = str(int(player.timer.get_time_left()))
