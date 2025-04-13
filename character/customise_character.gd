extends Control

var sprite: AnimatedSprite2D
var hair: AnimatedSprite2D

func _ready():
	sprite = $background/player/CharacterBody2D/Body
	hair = $background/player/CharacterBody2D/Hair

func _on_back_season_button_pressed():
	get_tree().change_scene_to_file("res://select_season_screen.tscn")

func _on_face_page_button_pressed():
	$background/face_page.color = Color("#f0b9df")

func _on_hair_page_button_pressed():
	$background/face_page.color = Color("#ceaaed")

func _on_tops_page_button_pressed():
	$background/face_page.color = Color("#9c8bdb")


func _on_avatar_left_button_pressed() -> void:
	var current_frame = sprite.frame
	var new_frame = current_frame - 1

	# Wrap around if needed (optional)
	if new_frame < 0:
		new_frame = sprite.sprite_frames.get_frame_count("idle_default") - 1
		
	sprite.animation = "idle_default"
	sprite.frame = new_frame
	hair.frame = new_frame
	sprite.pause()  # Freeze on the frame instead of auto-playing
	if new_frame == 2:
		hair.z_index = 85
	else:
		hair.z_index = 50


func _on_avatar_right_button_pressed() -> void:
	var current_frame = sprite.frame
	var new_frame = current_frame + 1

	# Wrap around if needed (optional)
	if new_frame > 3:
		new_frame = 0
		
	sprite.animation = "idle_default"
	sprite.frame = new_frame
	hair.frame = new_frame
	sprite.pause()  # Freeze on the frame instead of auto-playing
	if new_frame == 2:
		$background/player/CharacterBody2D/Hair.z_index = 85
	else:
		$background/player/CharacterBody2D/Hair.z_index = 50
