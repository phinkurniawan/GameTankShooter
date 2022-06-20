extends RigidBody2D

var explosion = preload("res://Explosion.tscn")

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta)


# Replace with function body.


func _on_bulletBoss_body_entered(body):
	if !body.is_in_group("boss"):
		var explosion_instance = explosion.instance()
		explosion_instance.position = get_global_position()
		get_tree().get_root().add_child(explosion_instance)
		queue_free()
	pass # Replace with function body.
