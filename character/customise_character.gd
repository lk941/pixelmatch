extends Control

var sprite: AnimatedSprite2D
var hair: AnimatedSprite2D
var tops: AnimatedSprite2D
var bottoms: AnimatedSprite2D
var bangs: AnimatedSprite2D

var head_sprite: AnimatedSprite2D
var head_sprite_hair: AnimatedSprite2D
var head_sprite_bangs = AnimatedSprite2D

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
@onready var bottoms_grid = $background/face_page/PageControl/BottomsPageControl/BottomsGrid
var body_sprite_frames = preload("res://sprites/player_spriteframe.tres")
var body_list = body_sprite_frames.get_animation_names()

var tops_sprite_frames = preload("res://character/female/tops/female_tops.tres")
var tops_list = tops_sprite_frames.get_animation_names()

var bangs_sprite_frames = preload("res://character/female/bangs/female_bangs.tres")
var bangs_list = bangs_sprite_frames.get_animation_names()

var hair_sprite_frames = preload("res://character/female/hair/female_hair.tres")
var hair_list = hair_sprite_frames.get_animation_names()

var bottoms_sprite_frames = preload("res://character/female/bottoms/female_bottoms.tres")
var bottoms_list = bottoms_sprite_frames.get_animation_names()

var skin_tones = [
	Color("#fffaf7"), Color("#f5ece5"), Color("#f5e3d5"),
	Color("#f2d5bf"), Color("#edcaaf") #, Color("#e8bd9c"), Color("#dead87")
]

var selected_skin_tone_button : Button = null

func _ready():
	sprite = $background/player/CharacterBody2D/Body
	hair = $background/player/CharacterBody2D/Hair
	tops = $background/player/CharacterBody2D/Tops
	bottoms = $background/player/CharacterBody2D/Bottoms
	bangs = $background/player/CharacterBody2D/Bangs
	
	head_sprite = $background/face_page/PageControl/FacePageControl/SubViewportContainer/SubViewport/player/CharacterBody2D/Body
	head_sprite_hair = $background/face_page/PageControl/FacePageControl/SubViewportContainer/SubViewport/player/CharacterBody2D/Hair
	head_sprite_bangs = $background/face_page/PageControl/FacePageControl/SubViewportContainer/SubViewport/player/CharacterBody2D/Bangs

	tops.animation = tops_list.get(0)
	_populate_grid(tops_grid, "top")
	_populate_grid(hair_grid, "hair")
	_populate_grid(bottoms_grid, "bottom")
	_show_page(face_page)
	
	for i in skin_tones.size():
		var tone = skin_tones[i]
		var btn = Button.new()
		btn.custom_minimum_size = Vector2(25, 25)
		# btn.flat = true
		btn.focus_mode = Control.FOCUS_NONE

		# Create a circular colored style
		var stylebox := StyleBoxFlat.new()
		stylebox.bg_color = tone
		stylebox.draw_center = true
		stylebox.set_corner_radius_all(100)
		stylebox.set_border_width_all(0)
		btn.add_theme_stylebox_override("normal", stylebox)
		
		var hover_stylebox := stylebox.duplicate() as StyleBoxFlat
		hover_stylebox.set_border_width_all(4)
		hover_stylebox.border_color = Color(1, 1, 1)  # white
		btn.add_theme_stylebox_override("hover", hover_stylebox)
		
		var pressed_stylebox := stylebox.duplicate() as StyleBoxFlat
		pressed_stylebox.set_border_width_all(4)
		pressed_stylebox.border_color = Color(1, 1, 1)  # or any color you like
		btn.add_theme_stylebox_override("pressed", pressed_stylebox)


		# Set button signal
		btn.pressed.connect(_on_skin_tone_pressed.bind(btn, stylebox, i))
		
		var skin_tone_grid := $background/face_page/PageControl/FacePageControl/SkinToneGridContainer
		skin_tone_grid.set("theme_override_constants/h_separation", 15)
		skin_tone_grid.set("theme_override_constants/v_separation", 10)
		
		# Add to grid
		skin_tone_grid.add_child(btn)
	
func _show_page(page: Control):
	for p in all_pages:
		p.visible = false
	page.visible = true

func _on_back_season_button_pressed():
	get_tree().change_scene_to_file("res://select_season_screen.tscn")
	

func _on_skin_tone_pressed(button: Button, stylebox: StyleBoxFlat, i: int):
	# Remove ring from previously selected button
	if selected_skin_tone_button:
		var old_style: StyleBoxFlat = selected_skin_tone_button.get_theme_stylebox("normal")
		old_style.set_border_width_all(0)
		selected_skin_tone_button.add_theme_stylebox_override("normal", old_style)

	# Add purple ring to current button
	stylebox.set_border_width_all(4)
	stylebox.border_color = Color(0.6, 0.3, 1.0)  # purple
	button.add_theme_stylebox_override("normal", stylebox)
	
	sprite.animation = body_list[i]

	selected_skin_tone_button = button

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
		new_frame = sprite.sprite_frames.get_frame_count("body_2") - 2
		
	# sprite.animation = "body_2"
	sprite.frame = new_frame
	hair.frame = new_frame
	tops.frame = new_frame
	bottoms.frame = new_frame
	bangs.frame = new_frame
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
		
	# sprite.animation = "body_2"
	sprite.frame = new_frame
	hair.frame = new_frame
	tops.frame = new_frame
	bottoms.frame = new_frame
	bangs.frame = new_frame
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
	elif animation_prefix == "bottom":
		animation_list = bottoms_sprite_frames.get_animation_names()
		sprite_frames = bottoms_sprite_frames
		vector = Vector2(50, 40)
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
		elif prefix == "bottom":
			bottoms.animation = dress_name
		else:
			hair.animation = dress_name
			head_sprite_hair.animation = dress_name
		
		
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


func _on_left_bangs_button_pressed():
	var current_index = bangs_list.find(bangs.animation)
	var prev_index = (current_index - 1 + bangs_list.size()) % bangs_list.size()
	bangs.animation = bangs_list[prev_index]
	head_sprite_bangs.animation = bangs_list[prev_index]


func _on_right_bangs_button_pressed():
	var current_index = bangs_list.find(bangs.animation)
	var next_index = (current_index + 1) % bangs_list.size()
	bangs.animation = bangs_list[next_index]
	head_sprite_bangs.animation = bangs_list[next_index]


func on_user_confirm_character(season: String):
	var data = {
		"body": sprite.animation,
		"top": tops.animation,
		"bangs": bangs.animation,
		"hair": hair.animation,
		"bottom": bottoms.animation
	}
	SaveManager.save_character(season, data)


func _on_finish_character_button_pressed():
	on_user_confirm_character("1")
	get_tree().change_scene_to_file("res://start_panel/starting_room.tscn")
