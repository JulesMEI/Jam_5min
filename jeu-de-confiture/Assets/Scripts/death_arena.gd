extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		if !body.death:
			body.handle_danger()
