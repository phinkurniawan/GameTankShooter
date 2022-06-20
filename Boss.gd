extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 50
var bullet_speed = 1000
var health_bar=300 
var velocity = Vector2()

var bullet = preload("res://Player/bulletBoss.tscn")
onready var player = get_parent().get_node("Player")
onready var boss = $Sprite
var detected = false
var can_fire = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if global_position.distance_to(player.global_position)<300 or detected:
		look_at(player.global_position)
		velocity = get_direction(boss,player)*speed
		velocity = velocity.normalized()
		fire()
	else  :
		velocity = Vector2.ZERO
	move_and_slide(velocity*speed)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func fire():
	if can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.position = $bulletPoint.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(0.3), "timeout")
		can_fire = true
 # Replace with function body.


func get_direction(enemy,player):
	var direction = player.global_position - enemy.global_position
	return direction
func _on_detectPlayer_body_entered(body):
	if 'Player' in body.name:
		detected =true
	pass # Replace with function body.


func _on_detectPlayer_body_exited(body):
	detected =false
	
	pass # Replace with function body.
	



# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_hitbox_body_entered(body):
	if "Bullet" in body.name:
		health_bar -= 50
		if health_bar <=0:
			queue_free()
	pass # Replace with function body.
