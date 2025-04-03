extends Control

func _ready():
	$AnimationPlayer.play("fade_in_out")

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://select_season_screen.tscn")
