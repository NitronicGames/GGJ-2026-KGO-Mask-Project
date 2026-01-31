class_name StateManager
extends Node

@export var initial_state: State

var states: Dictionary[String, State] = {}
var current_state: State


func _ready() -> void:
	# build state name lookup
	var nodes: Array[Node] = get_children()
	for node: Node in nodes:
		if node is State:
			states[node.name] = node

	current_state = initial_state
	if is_instance_valid(current_state):
		current_state.on_enter_state.call_deferred()
