extends CharacterBody2D

var attack_dir : Vector2
var can_attack : bool = true
var coins = 0

var standing_on = "grass"
var normal_anim = ["right", "left", "down", "up"]
var water_anim = ["right_water", "left_water", "down_water", "up_water"]
var current_anim = normal_anim

@onready var speed

var is_in_cave = false

func _ready():
	$Swing.hide()
	$Swing/Hitbox.disabled = true
	
func _physics_process(_delta):
		
	if global_position <= Vector2(4096, 4096) and global_position >= Vector2(0, 0):
		update_material()
	var direction = Vector2(Input.get_axis("walk_left", "walk_right"), Input.get_axis("walk_up", "walk_down"))
	velocity = direction.normalized() * speed
	
	if Input.is_action_pressed("attack") and can_attack:
		swing(0.2)
		
	if attack_dir.x > 0:
		$Swing.rotation_degrees = 0
	elif attack_dir.x < 0:
		$Swing.rotation_degrees = 180
	elif attack_dir.y > 0:
		$Swing.rotation_degrees = 90
	elif attack_dir.y < 0:
		$Swing.rotation_degrees = 270
		
	if direction != Vector2.ZERO or not can_attack:
		update_animation(direction, current_anim)
	else:
		$Sprite.pause()
	move_and_slide()
	
func update_material():
	standing_on = get_parent().get_cell_tile_data(0, get_parent().local_to_map(global_position)).get_custom_data("material")
	
	match standing_on:
		"lava":
			current_anim = water_anim
			speed = 40
		"water":
			current_anim = water_anim
			speed = 60
		"stairs":
			is_in_cave = not is_in_cave
			if not is_in_cave:
				get_tree().change_scene_to_file("res://data/game/world.tscn")
			else:
				get_tree().change_scene_to_file("res://data/game/cave.tscn")
		_:
			speed = 90
			current_anim = normal_anim

func update_animation(dir, animations : Array):
	
	if dir.x > 0:
		$Sprite.play(animations[0])
		attack_dir = dir
	elif dir.x < 0:
		$Sprite.play(animations[1])
		attack_dir = dir
	elif dir.y > 0:
		$Sprite.play(animations[2])
		attack_dir = dir
	elif dir.y < 0:
		$Sprite.play(animations[3])
		attack_dir = dir

func swing(time):
	can_attack = false
	$Swing/Hitbox.disabled = false
	$Swing.show()
	await get_tree().create_timer(time).timeout
	$Swing.hide()
	$Swing/Hitbox.disabled = true
	await get_tree().create_timer(time).timeout
	can_attack = true

func _on_query_body_entered(body):
	if body != self:
		pass
