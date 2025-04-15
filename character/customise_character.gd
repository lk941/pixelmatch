extends Control

var sprite: AnimatedSprite2D
var hair: AnimatedSprite2D
var tops: AnimatedSprite2D
var selected_container: Panel = null
@onready var face_page = $background/face_page/PageControl/FacePageControl
@onready var hair_page = $background/face_page/PageControl/HairPageControl
@onready var tops_page = $background/face_page/PageControl/TopsPageControl
@onready var bottoms_page = $background/face_page/PageControl/BottomsPageControl
@onready var shoes_page = $background/face_page/PageControl/ShoesPageControl
@onready var all_pages = [$background/face_page/PageControl/FacePageControl, 
$background/face_page/PageControl/HairPageControl,
$background/face_page/PageControl/TopsPageControl,
$background/face_page/PageControl/BottomsPageControl,
$background/face_page/PageControl/ShoesPageControl]

@onready var tops_grid = $background/face_page/PageControl/TopsPageControl/TopsGrid
@onready var hair_grid = $background/face_page/PageControl/HairPageControl/HairGrid
var tops_sprite_frames = preload("res://character/female/tops/female_tops.tres")
var tops_list = tops_sprite_frames.get_animation_names()

var hair_sprite_frames = preload("res://character/female/hair/female_hair.tres")
var hair_list = hair_sprite_frames.get_animation_names()

func _ready():
	sprite = $background/player/CharacterBody2D/Body
	hair = $background/player/CharacterBody2D/Hair
	tops = $background/player/CharacterBody2D/Tops
	tops.animation = tops_list.get(0)
	_populate_grid(tops_grid, "top")
	_populate_grid(hair_grid, "hair")
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
	
func _on_bottoms_page_button_pressed():
	$background/face_page.color = Color("#9052bc")
	_show_page(bottoms_page)
	$background/face_page/PageLabel.text = "Bottoms"
	
func _on_shoes_page_button_pressed():
	$background/face_page.color = Color("#494182")
	_show_page(shoes_page)
	$background/face_page/PageLabel.text = "Shoes"


func _on_avatar_left_button_pressed() -> void:
	var current_frame = sprite.frame
	var new_frame = current_frame - 1

	# Wrap around if needed (optional)
	if new_frame < 0:
		new_frame = sprite.sprite_frames.get_frame_count("idle_default") - 1
		
	sprite.animation = "idle_default"
	sprite.frame = new_frame
	hair.frame = new_frame
	tops.frame = new_frame
	sprite.pause()  # Freeze on the frame instead of auto-playing
	if new_frame == 2:
		hair.z_index = 90
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
	tops.frame = new_frame
	sprite.pause()  # Freeze on the frame instead of auto-playing
	if new_frame == 2:
		$background/player/CharacterBody2D/Hair.z_index = 90
	else:
		$background/player/CharacterBody2D/Hair.z_index = 50


func _populate_grid(grid: GridContainer, animation_prefix: String):
	
	var animation_list = []
	var sprite_frames = ""
	var vector = ""
	
	if animation_prefix == "top":
		animation_list = tops_sprite_frames.get_animation_names()
		sprite_frames = tops_sprite_frames
		vector = Vector2(50, 40)
	elif animation_prefix == "hair":
		animation_list = hair_sprite_frames.get_animation_names()
		sprite_frames = hair_sprite_frames
		vector = Vector2(50, 85)
	else:
		animation_list = []


	for anim_name in animation_list:
		#if not anim_name.begins_with(animation_prefix):
			#continue

		var container = Panel.new()
		container.custom_minimum_size = Vector2(110, 120)
		container.name = anim_name
		container.add_theme_stylebox_override("panel", _white_box_style())

		var tops_sprite = AnimatedSprite2D.new()
		tops_sprite.frames = sprite_frames
		tops_sprite.animation = anim_name
		tops_sprite.frame = 0  # Front view
		tops_sprite.stop()
		tops_sprite.centered = true
		tops_sprite.scale = Vector2(0.4, 0.4)
		tops_sprite.position = vector

		container.mouse_filter = Control.MOUSE_FILTER_PASS
		container.connect("gui_input", _on_tops_selected.bind(container, anim_name, animation_prefix))

		container.add_child(tops_sprite)
		grid.add_child(container)
		
func _on_tops_selected(event: InputEvent, container: Panel, dress_name: String, prefix: String):
	if event is InputEventMouseButton and event.pressed:
		if selected_container:
			selected_container.add_theme_stylebox_override("panel", _white_box_style())
		selected_container = container
		container.add_theme_stylebox_override("panel", _highlighted_box_style())
		if prefix == "top":
			tops.animation = dress_name
		else:
			hair.animation = dress_name
		
		
func _white_box_style() -> StyleBoxFlat:
	var style = StyleBoxFlat.new()
	style.bg_color = Color.WHITE
	style.border_color = Color(0.8, 0.8, 0.8)
	style.set_border_width_all(2)
	style.set_corner_radius_all(10)
	return style

func _highlighted_box_style() -> StyleBoxFlat:
	var style = StyleBoxFlat.new()
	style.bg_color = Color(1, 1, 1, 1)
	style.border_color = Color(1, 0.4, 0.6)
	style.set_border_width_all(3)
	style.set_corner_radius_all(10)
	return style
