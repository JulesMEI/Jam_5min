extends Area2D

const VAR_PATH = "res://Assets/Scenes/levels/level_" 
@export var controller : PlayerController


func _on_body_entered(body: Node2D) -> void:
	if body == controller and !controller.death:
		var current_scene_file = get_tree().current_scene.scene_file_path
		var next_level = current_scene_file.to_int() + 1

		var next_level_path = VAR_PATH + str(next_level) + ".tscn" \
			if !get_meta("SceneToLoad") else \
			"Assets/Scenes/levels/" + get_meta("SceneToLoad") + ".tscn"


		TransitionFade.transition()
		controller.can_control = false
		controller.can_move = false
		controller.velocity = Vector2(0, 0)
		await TransitionFade.on_transition_finished
		controller.can_control = true
		controller.can_move = true
		get_tree().change_scene_to_file(next_level_path)
	else :
		return
