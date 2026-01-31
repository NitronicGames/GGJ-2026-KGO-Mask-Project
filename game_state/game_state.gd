class_name GameState
extends StateManager

@export var scenario: Variant

var current_dialogue: Variant
var player_choice: Variant

@onready var init: Node = $Init
@onready var loading_scenario: Node = $LoadingScenario
@onready var running_dialogue: Node = $RunningDialogue
@onready var player_choosing: Node = $PlayerChoosing
@onready var running_reaction: Node = $RunningReaction


static func get_game_state() -> GameState:
	return Engine.get_main_loop().current_scene.get_first_node_in_group("__GameState__")


func _ready() -> void:
	super()
	add_to_group("__GameState__")


func load_scenario(path_to_scenario: String) -> void:
	if current_state == init:
		change_state_to(loading_scenario)
		loading_scenario.load(path_to_scenario)
		return


func run_dialogue() -> void:
	if current_state == loading_scenario:
		running_dialogue.dialogue = scenario.dialogue  ## FIXME: once scenario object defined
		change_state_to(running_dialogue)


func run_reaction() -> void:
	if current_state == player_choosing:
		running_reaction.dialogue = scenario.reaction  ## FIXME: once scenario object defined
		change_state_to(running_dialogue)


func show_dialogue_line(dialogue_line: Variant) -> void:
	print(dialogue_line)
