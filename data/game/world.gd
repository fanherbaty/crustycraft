extends Node2D

@onready var tile_map = $WorldMap

@onready var player = $WorldMap/Player
@onready var camera = $WorldMap/Player/Camera


#var generate_spawn = false
#var use_random = false


const POS_OFFSET = Vector2(2048, 2048)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	generate_world()
	$AnimationPlayer.play("intro")

func _process(_delta) -> void:
	glob.player_info = str(tile_map.local_to_map(player.global_position))
	if Input.is_action_just_pressed("zoom_out"):
		camera.zoom.x -= 0.05
		camera.zoom.y -= 0.05
		print("set zoom to: " + str(camera.zoom.x))
	elif Input.is_action_just_pressed("zoom_in"):
		camera.zoom.x += 0.05
		camera.zoom.y += 0.05
		print("set zoom to: " + str(camera.zoom.x))
		
func generate_world() -> void:
	if glob.world_seed == "":
		glob.world_gen.altitude.seed = randi()
		# Generate Random seed if not empty
	else:
		glob.world_gen.altitude.seed = int(glob.world_seed)
		
	print("generated world with seed " + str(glob.world_gen.altitude.seed))
	glob.world_gen.altitude.noise_type = FastNoiseLite.TYPE_PERLIN
	seed(int(glob.world_seed))
	
	for x in range(glob.world_gen.world_size.x):
		for y in range(glob.world_gen.world_size.y):

			var alt_data = glob.world_gen.altitude.get_noise_2d(x, y) * 10
			alt_data = clamp(alt_data + 2, 1, 4)
			# Clamping the data so it doesnt generate empty tiles
			
			if glob.world_seed != "GREENGRASS":
				tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(0, alt_data))
			else:
				tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(0, 4))
				# Just a Grass world
			if tile_map.get_cell_atlas_coords(0, Vector2i(x,y)).y == 4:
		
				if randi_range(0, 4096) == 0:
					tile_map.set_cell(0, Vector2i(x,y), 0, Vector2i(1, 0))
					print(Vector2(x, y))
				if randi_range(0,24) == 0: 
					# Trees
					tile_map.set_cell(1, Vector2i(x,y), 1, Vector2i(randi_range(0, 1), 0))
				if randi_range(0, 9) == 0:
					# Flower
					tile_map.set_cell(1, Vector2i(x,y), 2, Vector2i(randi_range(0, 7), 0))
			elif tile_map.get_cell_atlas_coords(0, Vector2i(x,y)).y == 3:
				if randi_range(0, 49) == 0:
					tile_map.set_cell(1, Vector2i(x,y), 2, Vector2i(randi_range(0, 1), 1))
				if randi_range(0, 29) == 0:
					# Stone
					tile_map.set_cell(1, Vector2i(x,y), 2, Vector2i(randi_range(0, 3), 2))
				
			# Random spawning positions.
				
			var spawn_rand_tilepos = Vector2i(randi_range(64, 192), randi_range(64, 192))
			var stair_position = Vector2i(randi_range(32, 224), randi_range(32, 224))
			
			if tile_map.get_cell_atlas_coords(0, spawn_rand_tilepos).y != 3:
				spawn_rand_tilepos = Vector2i(randi_range(64, 192), randi_range(64, 192))
			else:
				var spawn_position = tile_map.map_to_local(spawn_rand_tilepos)
				player.position = spawn_position
