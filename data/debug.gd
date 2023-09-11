extends CanvasLayer

#TODO
# destroying and placing
# items 

const GAME_VERSION = "CRUSTYCRAFT WORLDGEN PRERELEASE" #Alpha 2

var player = {
	config = {
		volume = [10, 6],
		window_config = Vector3i(426, 240, 2),
		window_fullscreen = false,
	},
	game = {
		deaths = 0,
	}
}

var splashes = [
	'Also try Primal!', 'Also try Pussy Destroyer!', 'Also try Fraczek\'s Mystery!',  'Game by CRUSTY!',
	'h!', 'Yeet that meat!', 'Free and Open Source!',
	'Made in GODOT!', 'extends Minicraft!', 'Simple and CRUSTY!',
	'pozdro seba', 'Music by PFB!', 'if not my drug addiction  this game wouldnt exist',
	'There is no Game!', 'Contribute!', 'Axoljusz pozdrawia!', ':)',
	'subscribe to Paweł Lidak on youtube.com', 'Welcome to Alpha 2!', 'github.com/fanherbaty/crustycraft!',
	'minceraft film the movie', '256x256!', 'Shining like a wrist-watch!',
	'splooge adventure', 'I\'m here to see CRUSTYCRAFT!', 
	'ALL CAPS when you spell the man\'s game\'s Name!', 'jebac brudasa',
	'lorem ipsun dolor something this is a super long splash text i dont know what im doing',
	'Won\'t talk with you!', 'i genuinely love Joe Pera his humor is so bad its good',
	'call these mine thoughts i guess idk', 'i cant wait to go to the zoo', 
	'pretzels are actually pretty good', 'genuine amish simulator', 
	'IM WATCHING ANNOYING ORANGE PORN!', 'ermmm what the flip??!',
	'welcome to the underground', 'smile_ghost.mp3', 'i lost my job',
	"why does every survival game have splash texts now", "https://youtu.be/hkBscgjlCaQ",
	"umieomameentemeincantetamaina", "piotrskrobekjuniorcraft"
	]

var player_info = ""

var world_seed = ""

var world_gen = {
	world_size = Vector2(256, 256),
#	moisture = FastNoiseLite.new(),
#	temperature = FastNoiseLite.new(),
	altitude = FastNoiseLite.new(),
}

func resize_window(new_size : Vector3):
	get_window().size.x = new_size.x * new_size.z
	get_window().size.y = new_size.y * new_size.z
	get_window().position = DisplayServer.screen_get_size(0) / 2 - get_window().size / 2
	return Vector2(new_size.x * new_size.z, new_size.y * new_size.z)

# Called when the node enters the scene tree for the first time.
func _ready():  
	get_window().title = "crustycraft.exe: " + splashes.pick_random()
	
	print(resize_window(Vector3(480.0, 270.0, 2.0)))
func _process(_delta):
	$Debug/FPS.text = GAME_VERSION + "\nFPS: " + str(Engine.get_frames_per_second()) + " " + player_info
#	$FPS/Shadow.text = $FPS.text
	if Input.is_action_just_pressed("debug"): $Debug.visible = not $Debug.visible
	if Input.is_action_just_pressed("fullscreen"): 
		player.config.window_fullscreen = not player.config.window_fullscreen
		if player.config.window_fullscreen:
			get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
		else:
			get_window().mode = Window.MODE_WINDOWED

func create_object(position : Vector2, parent : Node2D, res, new_name):
	var node_res = load(res).instatiate()
	node_res.name = new_name
	parent.add_child(node_res)
	parent.get_node(new_name).position = position
