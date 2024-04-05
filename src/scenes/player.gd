extends Node2D
var walk_speed = 160
var attacking = false

func set_dead():
	$sprite.speed_scale = 0
	$eyes.speed_scale = 0
	set_animation("dead")
	
func set_attack():
	$sprite.speed_scale = 1
	$eyes.speed_scale = $sprite.speed_scale
	set_animation("attack")

func set_run():
	$sprite.speed_scale = 0.8
	$eyes.speed_scale = 0.5
	set_animation("run")

func set_idle():
	$sprite.speed_scale = 0.2
	$eyes.speed_scale = $sprite.speed_scale
	set_animation("idle")
	
func set_animation(anim):
	$sprite.animation = anim
	$eyes.animation = $sprite.animation
	$sprite.play()
	$eyes.play()

func _ready():
	add_to_group("players")
	set_idle()
	
func _physics_process(delta):
	var left = Input.is_action_pressed("left")
	var right = Input.is_action_pressed("right")
	var up = Input.is_action_pressed("up")
	var down = Input.is_action_pressed("down")
	var action = Input.is_action_pressed("action")
	var moving = left or right or up or down
	
	if !attacking and action:
		attacking = true
		set_attack()
		
	if attacking:
		left = false
		right = false
		up = false
		down = false
		moving = false
	
	if left:
		position.x -= walk_speed * delta
		$sprite.scale.x = -1
		$eyes.scale.x = -1
		
	elif right:
		position.x += walk_speed * delta
		$sprite.scale.x = 1
		$eyes.scale.x = 1

	if up:
		position.y -= walk_speed * delta
	elif down:
		position.y += walk_speed * delta
		
	if !attacking:
		if moving:
			set_run()
		else:
			set_idle()

func _on_sprite_animation_looped():
	if attacking:
		attacking = false
