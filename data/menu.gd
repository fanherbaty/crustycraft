extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func seed_text_submitted(new_text):
	glob.world_seed = new_text
	$ClickSFX.play()

func play_button_pressed():
	get_tree().change_scene_to_file("res://data/game/world.tscn")

func quit_pressed():
	get_tree().quit()
