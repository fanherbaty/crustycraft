extends Node2D


@onready var cave_map = $CaveMap
@onready var player = $CaveMap/Player
@onready var camera = $CaveMap/Player/Camera

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_cave()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	glob.player_info = str(cave_map.local_to_map(player.global_position))
	if Input.is_action_just_pressed("zoom_out"):
		camera.zoom.x -= 0.1
		camera.zoom.y -= 0.1
		print("set zoom to: " + str(camera.zoom.x))
	elif Input.is_action_just_pressed("zoom_in"):
		camera.zoom.x += 0.1
		camera.zoom.y += 0.1
		print("set zoom to: " + str(camera.zoom.x))
func generate_cave() -> void:
	if glob.world_seed == "":
		glob.world_gen.altitude.seed = randi()
		
	else:
		glob.world_gen.altitude.seed = int(glob.world_seed)
	print("generated world with seed " + str(glob.world_gen.altitude.seed))
	glob.world_gen.altitude.noise_type = FastNoiseLite.TYPE_PERLIN
	
	for x in range(glob.world_gen.world_size.x):
		for y in range(glob.world_gen.world_size.y):
#			var moist_data = world_gen.moisture.get_noise_2d(x,y)*10
#			var temp_data = world_gen.temperature.get_noise_2d(x,y)*10
			var alt_data = glob.world_gen.altitude.get_noise_2d(x, y)*5
			alt_data = clamp(alt_data + 2, 0, 2)
			# Claping the data so it doesnt generate empty tiles
			
			if glob.world_seed != "GREENGRASS":
				cave_map.set_cell(0, Vector2i(x, y), 0, Vector2i(0, alt_data))
			else:
				cave_map.set_cell(0, Vector2i(x, y), 0, Vector2i(0, 4))
				# Just a Grass world
#			if cave_map.get_cell_atlas_coords(0, Vector2i(x,y)).y == 4:
#
#				if randi() % 8192 == 0:
#					cave_map.set_cell(0, Vector2i(x, y), 0, Vector2i(1, 0))
#					print("stairs at " + str(Vector2i(x,y)))
#				if randi() % 39 == 0: 
#					cave_map.set_cell(1, Vector2i(x,y), 1, Vector2i(randi_range(0, 1), 0))
#				if randi() % 14 == 0:
#					cave_map.set_cell(1, Vector2i(x,y), 2, Vector2i(randi_range(0, 7), 0))
#			elif tile_map.get_cell_atlas_coords(0, Vector2i(x,y)).y == 3:
#				if randi() % 49 == 0:
#					cave_map.set_cell(1, Vector2i(x,y), 2, Vector2i(randi_range(0, 1), 1))
			
