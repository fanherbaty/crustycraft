extends Node2D


func audio_finished():
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://data/menu.tscn")
