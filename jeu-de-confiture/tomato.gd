extends Node2D

@export var move_speed: float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (move_hand(delta) == true):
		move_tomato(delta)
	
func move_tomato(delta: float) -> bool:
	$TomatoPath/TomatoPathFollow.progress_ratio += move_speed * delta
	$HandSprite.set_position($TomatoPath/TomatoPathFollow.position)
	$TomatoSprite.set_position($TomatoPath/TomatoPathFollow.position)
	if ($TomatoPath/TomatoPathFollow.progress_ratio == 1.0):
		return true
	return false

func move_hand(delta: float) -> bool:
	$HandPath/HandPathFollow.progress_ratio += move_speed * delta
	$HandSprite.set_position($HandPath/HandPathFollow.position)
	return close_hand()

func close_hand() -> bool:
	if ($HandPath/HandPathFollow.progress_ratio == 1.0):
		$HandSprite.region_rect = Rect2(50.0, 40.0, 450.0, 180.0)
		$TomatoSprite.hide()
		return true
	return false
