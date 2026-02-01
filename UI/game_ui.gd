extends Control

@onready var dialogue_panel: Control = $DialoguePanel
@onready var choice_panel: Control = $ChoicePanel
@onready var feedback_panel: Control = $FeedbackPanel


var ScenarioData = preload("res://game_state/scenario_data.gd")
var scenario_data = ScenarioData.new()
var scenario_index := 0
var current_s := {}


func _ready() -> void:
	scenario_index = 0
	load_scenario(scenario_index)
	feedback_panel.visible = false
	choice_panel.visible = false
	dialogue_panel.visible = true


func load_scenario(i: int) -> void:
	if i >= scenario_data.scenarios.size():
		print("All scenarios done")
		feedback_panel.visible = false
		choice_panel.visible = false
		dialogue_panel.visible = false
		return

	current_s = scenario_data.get_scenario(i)

	$DialoguePanel/MarginContainer/DialogueVBox/SpeakerLabel.text = current_s["speaker"]
	$DialoguePanel/MarginContainer/DialogueVBox/LineLabel.text = current_s["line"]


func show_reaction(mask: String) -> void:
	var r = current_s["reactions"][mask]
	$FeedbackPanel/MarginContainer/FeedbackVBox/ReactionLabel.text = r["text"]
	$FeedbackPanel/MarginContainer/FeedbackVBox/ReflectionLabel.text = r["why"]


func _on_continue_button_pressed() -> void:
	print("Continue clicked")
	dialogue_panel.visible = false
	choice_panel.visible = true
	feedback_panel.visible = false


func _on_casual_button_pressed() -> void:
	print("Mask: casual")
	show_reaction("casual")
	choice_panel.visible = false
	feedback_panel.visible = true


func _on_polite_button_pressed() -> void:
	print("Mask: polite")
	show_reaction("polite")
	choice_panel.visible = false
	feedback_panel.visible = true


func _on_formal_button_pressed() -> void:
	print("Mask: formal")
	show_reaction("formal")
	choice_panel.visible = false
	feedback_panel.visible = true


func _on_next_button_pressed() -> void:
	print("Next clicked")
	scenario_index += 1

	if scenario_index >= scenario_data.scenarios.size():
		print("All scenarios done")
		feedback_panel.visible = false
		choice_panel.visible = false
		dialogue_panel.visible = false
		return

	load_scenario(scenario_index)
