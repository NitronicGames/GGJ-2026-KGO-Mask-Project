class_name DialogueReaction
extends Resource

@export_enum("casual", "polite", "formal") var expected: String
@export_enum("casual", "polite", "formal") var actual: String
@export_multiline var feedback: String
