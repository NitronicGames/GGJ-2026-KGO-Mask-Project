extends Node

var scenarios = [
	{
		"id": 1,
		"speaker": "Boss",
		"right_npc": "res://game_data/npcs/man.tres",
		"line": "Please read this report today.",
		"reactions": {
			"casual": {"text": "That sounded too casual.", "why": "Your boss expects a more formal tone."},
			"polite": {"text": "Okay, but a bit distant.", "why": "Polite, but not quite the best fit here."},
			"formal": {"text": "Perfect.", "why": "Formal speech matches a boss relationship."}
		}
	},

	{
		"id": 2,
		"speaker": "Friend",
		"right_npc": "res://game_data/npcs/girl.tres",
		"line": "Hey—can you check this for me?",
		"reactions": {
			"casual": {"text": "Natural and friendly.", "why": "With close friends, casual feels warm and normal."},
			"polite": {"text": "A little stiff.", "why": "Polite speech can add distance with close friends."},
			"formal": {"text": "Whoa… why so serious?", "why": "Formal speech can feel cold or awkward here."}
		}
	},

	{
		"id": 3,
		"speaker": "Teacher",
		"right_npc": "res://game_data/npcs/woman.tres",
		"line": "Can you hand in your homework today?",
		"reactions": {
			"casual": {"text": "Too relaxed.", "why": "A teacher expects respectful language."},
			"polite": {"text": "Good.", "why": "Polite speech fits a teacher-student context well."},
			"formal": {"text": "Respectful, maybe overdoing it.", "why": "Formal can work, but might feel overly distant."}
		}
	},

	{
		"id": 4,
		"speaker": "Classmate",
		"right_npc": "res://game_data/npcs/boy.tres",
		"line": "Can you send me your notes later?",
		"reactions": {
			"casual": {"text": "Friendly and natural.", "why": "Casual tone fits classmates well."},
			"polite": {"text": "Still good.", "why": "Polite works, but adds a bit of distance."},
			"formal": {"text": "Too formal.", "why": "Formal speech feels stiff between classmates."}
		}
	}
]

func get_scenario(n: int) -> Dictionary:
	return scenarios[n]
