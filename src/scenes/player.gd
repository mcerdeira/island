extends CharacterBody2D
var walk_speed = 300
var click_position = null
var target_position = Vector2(0, 0)

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
	Global.PLAYER = self
	
func _physics_process(delta):
	var click = Input.is_action_just_pressed("click")
	var moving = click
	if click:
		click_position = get_global_mouse_position()
		if position.x > click_position.x:
			$sprite.scale.x = -1
			$eyes.scale.x = -1
		else:
			$sprite.scale.x = 1
			$eyes.scale.x = 1
		
	if click_position != null and position.distance_to(click_position) > 3:
		moving = true
		target_position = (click_position - position).normalized()
		velocity = target_position * walk_speed
		move_and_slide()
		
	if moving:
		set_run()
	else:
		set_idle()

func _on_sprite_animation_looped():
	pass
