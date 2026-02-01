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


func _ready() -> void:
	feedback_panel.visible = false
	choice_panel.visible = false
	scenario_index = 0
	load_scenario(scenario_index)


func load_scenario(i: int) -> void:
	if i >= scenario_data.scenarios.size():
		print("All scenarios done")
		feedback_panel.visible = false
		choice_panel.visible = false
		dialogue_panel.visible = false
		return

	current_scenario = scenario_data.get_scenario(i)

	speaker_label.text = current_scenario["speaker"]
	line_label.text = current_scenario["line"]
	
	# reset panels for a fresh scenario
	dialogue_panel.visible = true
	choice_panel.visible = false
	feedback_panel.visible = false


func show_reaction(mask: String) -> void:
	var r = current_scenario["reactions"][mask]
	$FeedbackPanel/MarginContainer/FeedbackVBox/ReactionLabel.text = r["text"]
	$FeedbackPanel/MarginContainer/FeedbackVBox/ReflectionLabel.text = r["why"]


func _on_continue_button_pressed() -> void:
	dialogue_panel.visible = false
	choice_panel.visible = true
	feedback_panel.visible = false


func _on_casual_button_pressed() -> void:
	show_reaction("casual")
	choice_panel.visible = false
	feedback_panel.visible = true


func _on_polite_button_pressed() -> void:
	show_reaction("polite")
	choice_panel.visible = false
	feedback_panel.visible = true


func _on_formal_button_pressed() -> void:
	show_reaction("formal")
	choice_panel.visible = false
	feedback_panel.visible = true


func _on_next_button_pressed() -> void:
	scenario_index += 1
	load_scenario(scenario_index)


	if scenario_index >= scenario_data.scenarios.size():
		print("All scenarios done")
		feedback_panel.visible = false
		choice_panel.visible = false
		dialogue_panel.visible = false
		return

	load_scenario(scenario_index)
