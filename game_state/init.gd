extends State


func _enter_state() -> void:
	await get_tree().process_frame
	manager.change_state_to("LoadingScenario")
