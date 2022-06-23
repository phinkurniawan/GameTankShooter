extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var explosion = preload("res://Explosion.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_miniBullet_body_entered(body):
	if !body.is_in_group('enemy') :
		var explosion_instance = explosion.instance()
		explosion_instance.position = get_global_position()
		get_tree().get_root().add_child(explosion_instance)
		queue_free()

	pass # Replace with function body.
