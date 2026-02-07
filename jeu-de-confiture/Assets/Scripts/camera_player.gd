extends Camera2D
@onready var player: CharacterBody2D = $".."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = lerp(position, player.get_position_delta(), delta * 0.5)
	pass
