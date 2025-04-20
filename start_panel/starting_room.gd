extends Control

var sprite: AnimatedSprite2D
var hair: AnimatedSprite2D
var bangs: AnimatedSprite2D

func _ready():
	sprite = $room_background/player/CharacterBody2D/Body
	hair = $room_background/player/CharacterBody2D/Hair
	bangs = $room_background/player/CharacterBody2D/Bangs
	
	var character_data = SaveManager.get_character("1")
	
	sprite.animation = character_data.get("body", "body_2")
	hair.animation = character_data.get("hair", "default")
	bangs.animation = character_data.get("bangs", "a_default")
	
	sprite.frame = 4


func _on_backto_seasons_button_pressed():
	get_tree().change_scene_to_file("res://select_season_screen.tscn")
