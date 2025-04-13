extends Control

var sprite: AnimatedSprite2D
var hair: AnimatedSprite2D
@onready var face_page = $background/face_page/PageControl/FacePageControl
@onready var hair_page = $background/face_page/PageControl/HairPageControl
@onready var tops_page = $background/face_page/PageControl/TopsPageControl
@onready var all_pages = [$background/face_page/PageControl/FacePageControl, 
$background/face_page/PageControl/HairPageControl,
$background/face_page/PageControl/TopsPageControl]

func _ready():
	sprite = $background/player/CharacterBody2D/Body
	hair = $background/player/CharacterBody2D/Hair
	_show_page(face_page)
	
func _show_page(page: Control):
	for p in all_pages:
		p.visible = false
	page.visible = true

func _on_back_season_button_pressed():
	get_tree().change_scene_to_file("res://select_season_screen.tscn")

func _on_face_page_button_pressed():
	$background/face_page.color = Color("#f0b9df")
	_show_page(face_page)
	$background/face_page/PageLabel.text = "Main Features"

func _on_hair_page_button_pressed():
	$background/face_page.color = Color("#ceaaed")
	_show_page(hair_page)
	$background/face_page/PageLabel.text = "Hairstyles"

func _on_tops_page_button_pressed():
	$background/face_page.color = Color("#9c8bdb")
	_show_page(tops_page)
	$background/face_page/PageLabel.text = "Tops | Dresses"


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
