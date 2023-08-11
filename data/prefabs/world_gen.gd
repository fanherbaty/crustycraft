extends TileMap

var noise = FastNoiseLite.new()
#var temperature = FastNoiseLite.new()
#var moisture = FastNoiseLite.new()

var chunk_size : Vector2i = Vector2i(42, 32)

var ground_layer = 1
var wall_layer = 2

@onready var player = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready():
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.seed = randi()
	noise.frequency = 0.015

func _process(_delta):
	generate_chunk(player.position)
	var mouse_pos = local_to_map(get_global_mouse_position())
	if Input.is_action_pressed("use"):
		set_cell(1 + int(main.wall_layer), mouse_pos, 1 + int(not main.wall_layer), Vector2i(0, $"../UI".selected_hotbar))
	elif Input.is_action_pressed("destroy"):
		erase_cell(1 + int(main.wall_layer), mouse_pos)
	
func generate_chunk(pos):
	var tile_pos = local_to_map(pos)
	for x in range(chunk_size.x):
		for y in range(chunk_size.y):
			var height = noise.get_noise_2d(tile_pos.x - chunk_size.x / 2 + x, tile_pos.y - chunk_size.y / 2 + y) * 15
			set_cell(0, Vector2i(tile_pos.x - chunk_size.x / 2 + x, tile_pos.y - chunk_size.y / 2 + y), 0, Vector2(0,clamp(height + 2, 0, 5)))
#			set_cell(0, Vector2i(tile_pos.x - chunk_size.x / 2 + x, tile_pos.y - chunk_size.y / 2 + y), 0, Vector2i(0, 0))
			
			
