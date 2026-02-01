extends Control

@onready var dialogue_panel: Control = $DialoguePanel
@onready var choice_panel: Control = $ChoicePanel
@onready var feedback_panel: Control = $FeedbackPanel

@onready var speaker_label: Label = $DialoguePanel/MarginContainer/DialogueVBox/SpeakerLabel
@onready var line_label: Label = $DialoguePanel/MarginContainer/DialogueVBox/LineLabel

var scenario_index: int = 0
var current_scenario: Dictionary = {}
var ScenarioData = preload("res://game_state/scenario_data.gd")
var scenario_data = ScenarioData.new()
var game: Game:
	get():
		if not is_instance_valid(game):
			var _game = get_tree().current_scene
			print(_game)
			if _game is Game:
				game = _game
		return game


func _ready() -> void:
	AudioManager.play_gameplay()
	
	feedback_panel.visible = false
	choice_panel.visible = false
	scenario_index = 0
	load_scenario.call_deferred(scenario_index)


func load_scenario(i: int) -> void:
	dialogue_panel.visible = false
	choice_panel.visible = false
	feedback_panel.visible = false
	if game:
		game.remove_left_npc()
		game.remove_right_npc()

	if i >= scenario_data.scenarios.size():
		print("All scenarios done")
		return

	current_scenario = scenario_data.get_scenario(i)
	if game:
		await game.show_k_go()

	add_npcs(current_scenario)

	speaker_label.text = current_scenario["speaker"]
	line_label.text = current_scenario["line"]

	dialogue_panel.visible = true
	choice_panel.visible = false
	feedback_panel.visible = false


func show_reaction(mask: String) -> void:
	var r = current_scenario["reactions"][mask]
	$FeedbackPanel/MarginContainer/FeedbackVBox/ReactionLabel.text = r["text"]
	$FeedbackPanel/MarginContainer/FeedbackVBox/ReflectionLabel.text = r["why"]


func add_npcs(scenario: Dictionary) -> void:
	if scenario.has("right_npc") and game:
		game.call_deferred("add_right_npc", load(scenario["right_npc"]))
		game.right_npc_speaking.call_deferred()
	if scenario.has("left_npc") and game:
		game.call_deferred("add_left_npc", load(scenario["left_npc"]))


func _on_continue_button_pressed() -> void:
	dialogue_panel.visible = false
	choice_panel.visible = true
	feedback_panel.visible = false

	if game:
		game.left_npc_speaking()


func _on_casual_button_pressed() -> void:
	show_reaction("casual")
	choice_panel.visible = false
	feedback_panel.visible = true

	if game:
		game.no_npc_speaking()


func _on_polite_button_pressed() -> void:
	show_reaction("polite")
	choice_panel.visible = false
	feedback_panel.visible = true

	if game:
		game.no_npc_speaking()


func _on_formal_button_pressed() -> void:
	show_reaction("formal")
	choice_panel.visible = false
	feedback_panel.visible = true

	if game:
		game.no_npc_speaking()


func _on_next_button_pressed() -> void:
	scenario_index += 1
	load_scenario(scenario_index)
