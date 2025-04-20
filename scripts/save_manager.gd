extends Node

const SAVE_PATH = "res://data/character_season_data.json"
var character_data = {}

func _ready():
	load_data()

func load_data():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		character_data = JSON.parse_string(file.get_as_text())
	else:
		character_data = {}

func save_data():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(character_data))

func has_character_for(season: String) -> bool:
	return character_data.has(season)

func save_character(season: String, data: Dictionary):
	character_data[season] = data
	save_data()

func get_character(season: String) -> Dictionary:
	return character_data.get(season, {})
