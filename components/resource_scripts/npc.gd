class_name NPC
extends Resource

## Used for dialogue speaker string
@export var name: String
## Scene file with visuals & animations
@export_file("*.tscn") var scene_file: String
## List of reactions for this NPC, shown when the combination of expected and actual masks match
@export var reactions: Array[DialogueReaction]
