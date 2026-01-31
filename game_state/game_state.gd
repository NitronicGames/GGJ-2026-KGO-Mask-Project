extends StateManager

@export var scenario: Variant

@onready var init: Node = $Init
@onready var loading_scenario: Node = $LoadingScenario
@onready var running_dialogue: Node = $RunningDialogue
@onready var player_choosing: Node = $PlayerChoosing
@onready var running_reaction: Node = $RunningReaction


func _ready() -> void:
	super()
	add_to_group("__GameState__")


func load_scenario(path_to_scenario: String) -> void:
	if current_state == init:
		change_state_to(loading_scenario)
		loading_scenario.load(path_to_scenario)
		return
