class_name NPC
extends Resource

## Should match dialogue speaker string
@export var name: String
## List of reactions for this NPC, shown when the combination of expected and actual masks match
@export var reactions: Array[DialogueReaction]
