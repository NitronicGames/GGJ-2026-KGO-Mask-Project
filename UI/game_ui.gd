extends Control

@onready var dialogue_panel: Control = $DialoguePanel
@onready var choice_panel: Control = $ChoicePanel
@onready var feedback_panel: Control = $FeedbackPanel

var ScenarioData = preload("res://game_state/scenario_data.gd")
var scenario_data = ScenarioData.new()

func _ready() -> void:
	var s = scenario_data.get_scenario(0)
	$DialoguePanel/MarginContainer/DialogueVBox/SpeakerLabel.text = s["speaker"]
	$DialoguePanel/MarginContainer/DialogueVBox/LineLabel.text = s["line"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_continue_button_pressed() -> void:
	print("Continue clicked")
	dialogue_panel.visible = false
	choice_panel.visible = true
	feedback_panel.visible = false


func _on_casual_button_pressed() -> void:
	print("Mask: casual")
	choice_panel.visible = false
	feedback_panel.visible = true


func _on_polite_button_pressed() -> void:
	print("Mask: polite")
	choice_panel.visible = false
	feedback_panel.visible = true


func _on_formal_button_pressed() -> void:
	print("Mask: formal")
	choice_panel.visible = false
	feedback_panel.visible = true


func _on_next_button_pressed() -> void:
	print("Next clicked")
	dialogue_panel.visible = true
	choice_panel.visible = false
	feedback_panel.visible = false
