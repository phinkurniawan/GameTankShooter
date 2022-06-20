extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2()
var speed = 120
var health:int = 50
# Called when the node enters the scene tree for the first time.
onready var enemy = $AnimatedSprite
onready var player = get_parent().get_node("Player")
var stun = false
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var direction = get_direction(enemy,player)
	var move_direction = direction.normalized()
	if player != null and stun == false:
		velocity = move_direction*speed
	elif stun :
		velocity = lerp(velocity,Vector2(0,0),0.3)
	enemy.play('fly')
	move_and_slide(velocity)
	
	

func get_direction(enemy,player):
	var direction = player.global_position - enemy.global_position
	return direction
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_shape_entered(body):
	
	pass # Replace with function body.

#func handle_hit():
	
		


	 # Replace with function body.


func _on_Stun_timer_timeout():
	stun = false
	# Replace with function body.


func _on_Hitbox_body_entered(body):
	if ("Bullet" in body.name):
		health -= 40
		modulate = Color.white
		velocity = -velocity*4
		stun = true
		$Stun_timer.start()
	if health <= 0:
		queue_free()
	pass # Replace with function body.
