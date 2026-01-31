class_name State
extends Node

var manager: StateManager:
	get():
		if not is_instance_valid(manager):
			if not is_inside_tree():
				await ready
			manager = get_parent()
		return manager


func on_enter_state() -> void:
	print("on_enter_state ", name)


func on_exit_state() -> void:
	print("on_exit_state ", name)
