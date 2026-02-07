extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("should die")
	if body is PlayerController:
		body.handle_danger()
