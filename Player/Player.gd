extends KinematicBody2D

export var speed = 100
export var bullet_speed = 1000
export var fire_rate = 0.2
var health_bar= 200
var bullet = preload("res://Player/Bullet.tscn")
#var sound = preload("res://laserShot.mp3")
var shoot_sound = load("res://laserShot.mp3")
var main_menu = load("res://MainMenu.tscn")
var can_fire = true
var health_maks = 200
var health_hero = 200
signal hero_update_health(value)
func _process(delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("fire") and can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.position = $BulletPoint.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
		AudioManager.play_effect(shoot_sound)
	
func _physics_process(delta):
	
	var direction = Vector2()
	if Input.is_action_pressed("move_up"):
		direction += Vector2(0, -1)
	if Input.is_action_pressed("move_down"):
		direction += Vector2(0, 1)
	if Input.is_action_pressed("move_left"):
		direction += Vector2(-1, 0)
	if Input.is_action_pressed("move_right"):
		direction += Vector2(1, 0)
	
	move_and_slide(direction * speed)

func kill():
	get_tree().paused = true
	get_tree().change_scene("res://GameOver.tscn")
	emit_signal("hero_update_health",200)
	health_bar = health_maks
	
func _on_Area2D_body_entered(body):
	if ("Enemy" in body.name) or ("miniBullet" in body.name):
		health_bar -= 15
	if 'bulletBoss' in body.name:
		health_bar -= 30
	emit_signal("hero_update_health", (float(health_bar)/float(health_maks)) * 100)
	if health_bar <= 0:
		kill()
		
		
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
