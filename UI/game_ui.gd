extends Control

@onready var dialogue_panel: Control = $DialoguePanel
@onready var choice_panel: Control = $ChoicePanel
@onready var feedback_panel: Control = $FeedbackPanel

# Top name row labels
@onready var you_label: Label = $DialoguePanel/MarginContainer/DialogueVBox/NameRow/YouLabel
@onready var npc_label: Label = $DialoguePanel/MarginContainer/DialogueVBox/NameRow/SpeakerLabel

# Main dialogue text
@onready var line_label: Label = $DialoguePanel/MarginContainer/DialogueVBox/LineLabel

var scenario_index: int = 0
var current_scenario: Dictionary = {}

var ScenarioData = preload("res://game_state/scenario_data.gd")
var scenario_data = ScenarioData.new()

# Cache the current scene as Game (no recursive getter)
var game: Game = null


func _ready() -> void:
	AudioManager.play_gameplay()

	# Grab the current scene as Game (works if current scene script/class is Game)
	game = get_tree().current_scene as Game

	feedback_panel.visible = false
	choice_panel.visible = false
	dialogue_panel.visible = false

	scenario_index = 0
	load_scenario.call_deferred(scenario_index)


func load_scenario(i: int) -> void:
	# hide everything while we swap NPCs / interstitial
	dialogue_panel.visible = false
	choice_panel.visible = false
	feedback_panel.visible = false

	# clear NPCs from last scenario
	if game:
		if game.has_method("remove_left_npc"):
			game.remove_left_npc()
		if game.has_method("remove_right_npc"):
			game.remove_right_npc()

	# end condition
	if i >= scenario_data.scenarios.size():
		print("All scenarios done")
		return

	current_scenario = scenario_data.get_scenario(i)

	# optional interstitial (only if your Game has it)
	if game and game.has_method("show_k_go"):
		await game.show_k_go()

	# spawn NPCs for this scenario
	add_npcs(current_scenario)

	# update UI text
	you_label.text = "You"
	npc_label.text = str(current_scenario.get("speaker", ""))
	line_label.text = str(current_scenario.get("line", ""))

	# show dialogue panel for this scenario
	dialogue_panel.visible = true


func show_reaction(mask: String) -> void:
	var reactions: Dictionary = current_scenario.get("reactions", {})
	var r: Dictionary = reactions.get(mask, {})

	$FeedbackPanel/MarginContainer/FeedbackVBox/ReactionLabel.text = str(r.get("text", ""))
	$FeedbackPanel/MarginContainer/FeedbackVBox/ReflectionLabel.text = str(r.get("why", ""))


func add_npcs(scenario: Dictionary) -> void:
	if not game:
		return

	# right npc
	if scenario.has("right_npc") and game.has_method("add_right_npc"):
		game.call_deferred("add_right_npc", load(scenario["right_npc"]))
		# optional: mark who is speaking (only if your Game has it)
		if game.has_method("right_npc_speaking"):
			game.call_deferred("right_npc_speaking")

	# left npc
	if scenario.has("left_npc") and game.has_method("add_left_npc"):
		game.call_deferred("add_left_npc", load(scenario["left_npc"]))


func _on_continue_button_pressed() -> void:
	dialogue_panel.visible = false
	choice_panel.visible = true
	feedback_panel.visible = false

	if game and game.has_method("left_npc_speaking"):
		game.left_npc_speaking()


func _on_casual_button_pressed() -> void:
	show_reaction("casual")
	choice_panel.visible = false
	feedback_panel.visible = true

	if game and game.has_method("no_npc_speaking"):
		game.no_npc_speaking()


func _on_polite_button_pressed() -> void:
	show_reaction("polite")
	choice_panel.visible = false
	feedback_panel.visible = true

	if game and game.has_method("no_npc_speaking"):
		game.no_npc_speaking()


func _on_formal_button_pressed() -> void:
	show_reaction("formal")
	choice_panel.visible = false
	feedback_panel.visible = true

	if game and game.has_method("no_npc_speaking"):
		game.no_npc_speaking()


func _on_next_button_pressed() -> void:
	scenario_index += 1
	load_scenario(scenario_index)
