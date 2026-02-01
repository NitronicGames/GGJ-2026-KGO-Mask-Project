extends State

var dialogue: Variant
var line_index: int
var awaiting_input: bool = false


func on_enter_state() -> void:
	print("on_enter_state ", name)
	line_index = 0


func on_exit_state() -> void:
	print("on_exit_state ", name)
