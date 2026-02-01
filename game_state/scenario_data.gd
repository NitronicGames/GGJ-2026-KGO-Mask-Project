extends Node

var scenarios = [
	{
		"id": 1,
		"speaker": "Boss",
		"line": "Please read this report today.",

		"reactions": {
			"casual": {
				"text": "That sounded too casual.",
				"why": "Boss expects formality."
			},
			"polite": {
				"text": "Acceptable, but distant.",
				"why": "Polite but not humble."
			},
			"formal": {
				"text": "Very appropriate.",
				"why": "Formal keigo fits boss context."
			}
		}
	}
]

func get_scenario(n: int) -> Dictionary:
	return scenarios[n]
