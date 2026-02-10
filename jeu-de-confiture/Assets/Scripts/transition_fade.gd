extends CanvasLayer

signal on_transition_finished

@onready var colorRect: ColorRect = $ColorRect
@onready var AnimPlayer: AnimationPlayer = $AnimationPlayer

func _ready():
	colorRect.visible = false
	AnimPlayer.animation_finished.connect(_on_animation_finished)
	
func _on_animation_finished(anim_name):
	if (anim_name == "fade_out"):
		on_transition_finished.emit()
		AnimPlayer.play("fade_in")
	elif anim_name == "fade_in":
		colorRect.visible = false

func transition():
	colorRect.visible = true
	AnimPlayer.play("fade_out")
