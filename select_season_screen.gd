extends Control

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://start_screen.tscn")
	
func _on_season_button_pressed(season_name: String):
	GameManager.set_season(season_name)
	if SaveManager.has_character_for(season_name):
		get_tree().change_scene_to_file("res://character/character_in_room.tscn")
	else:
		get_tree().change_scene_to_file("res://character/customise_character.tscn")


func _on_texture_button_pressed(extra_arg_0: String) -> void:
	pass # Replace with function body.
