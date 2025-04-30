extends Node

const CHARACTER_SAVE_PATH = "res://data/character_season_data.json"
var character_data = {}

const SEASON_SAVE_PATH = "res://data/season_episodes.json"
var season_data = {}

func _ready():
	load_data()

func load_data():
	var file1 = FileAccess.open(CHARACTER_SAVE_PATH, FileAccess.READ)
	var file2 = FileAccess.open(SEASON_SAVE_PATH, FileAccess.READ)
	if file1:
		character_data = JSON.parse_string(file1.get_as_text())
	else:
		character_data = {}
	if file2:
		season_data = JSON.parse_string(file2.get_as_text())
	else:
		season_data = {}
	

func save_data():
	var file = FileAccess.open(CHARACTER_SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(character_data))

func has_character_for(season: String) -> bool:
	return character_data.has(season)

func save_character(season: String, data: Dictionary):
	character_data[season] = data
	save_data()

func get_character(season: String) -> Dictionary:
	return character_data.get(season, {})
	
func get_season_data(season: String) -> Dictionary:
	return season_data.get(season, {})
