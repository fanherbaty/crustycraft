extends CharacterBody2D

var speed = 80

func _physics_process(_delta):
	
	$Camera2D.zoom = Vector2(main.opt.zoom / 50.0, main.opt.zoom / 50.0)
	$Body.look_at(get_global_mouse_position())
	if Input.is_action_pressed("run"): speed = 115 
	else: speed = 80
	var dir = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	velocity = dir.normalized() * speed
	if Input.is_action_just_pressed("switch_layer"):
		main.wall_layer = not main.wall_layer	
	if velocity.is_zero_approx():
		$Body.play("idle")
		$Legs.play("idle")
	else:
		$Body.play("walk")
		$Legs.play("walk")
	$Legs.rotation = dir.angle()
	move_and_slide()
