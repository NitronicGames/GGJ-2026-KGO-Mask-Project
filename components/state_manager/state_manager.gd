class_name StateManager
extends Node

signal state_changed(new_state: State)

const PROCESS_METHODS: Array[String] = [
	"set_process",
	"set_physics_process",
	"set_process_input",
	"set_process_unhandled_input",
	"set_process_shortcut_input",
	"set_process_unhandled_key_input",
]

@export var initial_state: State

var states: Dictionary[String, State] = {}
var current_state: State


func change_state_to(node_or_name: Variant) -> void:
	var new_state: State = _get_state(node_or_name)
	if not new_state or current_state == new_state:
		return
	prints(name, "changing state to", new_state.name)
	_set_process_for_state(current_state, false)
	current_state.on_exit_state()

	current_state = new_state
	current_state.on_enter_state()
	_set_process_for_state(current_state, true)
	state_changed.emit(current_state)


func _ready() -> void:
	# build state name lookup
	var nodes: Array[Node] = get_children()
	for node: Node in nodes:
		if node is State:
			states[node.name] = node
			_set_process_for_state(node, false)

	current_state = initial_state
	if is_instance_valid(current_state):
		_set_process_for_state(current_state, true)
		current_state.on_enter_state.call_deferred()


func _get_state(node_or_name: Variant) -> State:
	var state: State
	if node_or_name is State:
		state = node_or_name
	elif node_or_name is String and node_or_name in states:
		state = states[node_or_name]
	else:
		push_error("Unknown state '" + node_or_name + "'" + " for " + name)
	return state


func _set_process_for_state(state: State, enable: bool = true) -> void:
	for method: String in PROCESS_METHODS:
		state.call(method, enable)
	state.set_block_signals(!enable)
