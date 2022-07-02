extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2()
var speed = 120
var health:int = 100
var dead_sound = load("res://dead.mp3")
# Called when the node enters the scene tree for the first time.
var bullet = preload("res://Player/miniBullet.tscn")
onready var player = get_parent().get_node("Player")
onready var enemy = $Sprite
var bullet_speed= 600
var stun = false
var can_fire = true
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if player != null and stun == false:
		var direction = get_direction(enemy,player)
		var move_direction = direction.normalized()
		velocity = move_direction*speed
		look_at(player.global_position)
		fire()
	elif stun :
		velocity = lerp(velocity,Vector2(0,0),0.3)
	else:
		velocity = Vector2.ZERO
	move_and_slide(velocity)
func fire():
	if can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.position = $bulletPoint.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		$Timer.start(0.8); yield($Timer, "timeout")
		can_fire = true
	

func get_direction(enemy,player):
	var direction = player.global_position - enemy.global_position
	return direction
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	
		


	 # Replace with function body.


func _on_Stun_timer_timeout():
	stun = false
	# Replace with function body.


func _on_Hitbox_body_entered(body):
	if !('Boss') in body.name and !("miniBullet") in body.name :
		health -= 40
		velocity = -velocity*4
		stun = true
		$Stun_timer.start()
	if health <= 0:
		queue_free()
		AudioManager.play_effect(dead_sound)
	pass # Replace with function body.
# Replace with function body.

# Replace with function body.
