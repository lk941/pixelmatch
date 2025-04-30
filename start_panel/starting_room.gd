extends Control

var sprite: AnimatedSprite2D
var hair: AnimatedSprite2D
var bangs: AnimatedSprite2D

@onready var episode_list = $room_background/screen/HBoxContainer/ScrollContainer/EpisodeListContainer
@onready var info_title = $room_background/screen/HBoxContainer/PanelContainer/FeatureEpisodeContainer/EpisodeTitle
@onready var info_desc = $room_background/screen/HBoxContainer/PanelContainer/FeatureEpisodeContainer/EpisodeDesc
@onready var info_image = $room_background/screen/HBoxContainer/PanelContainer/FeatureEpisodeContainer/EpisodeImage

func _ready():
	sprite = $room_background/player/CharacterBody2D/Body
	hair = $room_background/player/CharacterBody2D/Hair
	bangs = $room_background/player/CharacterBody2D/Bangs
	
	var character_data = SaveManager.get_character("1")
	var season_data = SaveManager.get_season_data("1")
	
	sprite.animation = character_data.get("body", "body_2")
	hair.animation = character_data.get("hair", "default")
	bangs.animation = character_data.get("bangs", "a_default")
	
	sprite.frame = 4
	
	if season_data:
		populate_episodes(season_data)
	
func populate_episodes(season_data: Dictionary):
	for ep_key in season_data.keys():
		var episode = season_data[ep_key]
		var button = Button.new()
		button.text = episode["title"]
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.custom_minimum_size.y = 160

		button.connect("pressed", _on_episode_pressed.bind(episode))
		episode_list.add_child(button)


func _on_episode_pressed(episode: Dictionary):
	info_title.text = episode["title"]
	info_desc.text = episode["description"]
	info_image.texture = load(episode["image"])


func _on_backto_seasons_button_pressed():
	get_tree().change_scene_to_file("res://select_season_screen.tscn")
