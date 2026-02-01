extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_continue_button_pressed() -> void:
	print("Continue clicked")


func _on_casual_button_pressed() -> void:
	print("Mask: casual")


func _on_polite_button_pressed() -> void:
	print("Mask: polite")


func _on_formal_button_pressed() -> void:
	print("Mask: formal")


func _on_next_button_pressed() -> void:
	pass # Replace with function body.
