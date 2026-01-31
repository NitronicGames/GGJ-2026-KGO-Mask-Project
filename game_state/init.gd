extends State


func _process(_delta: float) -> void:
	if get_tree().current_scene.ready:
		manager.change_state_to("LoadingScenario")
