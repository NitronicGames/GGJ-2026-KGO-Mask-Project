extends State


func _process(delta: float) -> void:
	if get_tree().current_scene.ready:
		manager.change_state_to("LoadingScenario")
