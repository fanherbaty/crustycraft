extends CanvasLayer

var selected_hotbar : int = 0
var inventory_open : bool = false
func update_hotbar():
	match selected_hotbar:
		-1:
			selected_hotbar = 8
		0:
			$Hotbar/Selected.position.x = -80
		1: 
			$Hotbar/Selected.position.x = -60
		2:
			$Hotbar/Selected.position.x = -40
		3: 
			$Hotbar/Selected.position.x = -20
		4:
			$Hotbar/Selected.position.x = 0
		5:
			$Hotbar/Selected.position.x = 20
		6:
			$Hotbar/Selected.position.x = 40
		7:
			$Hotbar/Selected.position.x = 60
		8:
			$Hotbar/Selected.position.x = 80
		9:
			selected_hotbar = 0
	if Input.is_key_pressed(KEY_1):
		selected_hotbar = 0
	elif Input.is_key_pressed(KEY_2):
		selected_hotbar = 1
	elif Input.is_key_pressed(KEY_3):
		selected_hotbar = 2
	elif Input.is_key_pressed(KEY_4):
		selected_hotbar = 3
	elif Input.is_key_pressed(KEY_5):
		selected_hotbar = 4
	elif Input.is_key_pressed(KEY_6):
		selected_hotbar = 5
	elif Input.is_key_pressed(KEY_7):
		selected_hotbar = 6
	elif Input.is_key_pressed(KEY_8):
		selected_hotbar = 7
	elif Input.is_key_pressed(KEY_9):
		selected_hotbar = 8
	if Input.is_action_just_pressed("scroll_up"):
		selected_hotbar -= 1
	elif Input.is_action_just_pressed("scroll_down"):
		selected_hotbar += 1
func update_inventory():
	if Input.is_action_just_pressed("inventory"): inventory_open = not inventory_open
	
func _process(delta):
	$Hotbar.global_position.x = get_viewport().get_visible_rect().size.x / 2
	$Hotbar.scale = Vector2(main.opt.ui_size, main.opt.ui_size)

#	if not inventory_open:
#		update_hotbar()
#		$Background.visible = false
#		$Inventory.visible = false
#	else: 
#		$Background.visible = true
#		$Inventory.visible = true

	#update_inventory()
	$Sprite2D2.frame = main.wall_layer
	$Background.size = get_viewport().get_visible_rect().size
	update_hotbar()
	if Input.is_action_just_pressed("zoom_out") and main.opt.zoom != 50:
		main.opt.zoom -= 10
		print(main.opt.zoom)
	elif Input.is_action_just_pressed("zoom_in") and main.opt.zoom != 100:
		main.opt.zoom += 10
		print(main.opt.zoom)
	clamp(main.opt.zoom, 50, 100)

