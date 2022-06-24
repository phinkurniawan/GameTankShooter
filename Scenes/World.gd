extends Node2D
onready var health_progress = $Player/GUI/HealthBar
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var enemy = preload("res://Enemy.tscn")
var boss = preload("res://Boss.tscn")
var player = preload("res://Player/Player.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

	
func _on_SpawnTimer_timeout():
	var enemy_instance = enemy.instance()
	add_child(enemy_instance)
	enemy_instance.position = $SpawnLocation.position
	
	var nodes = get_tree().get_nodes_in_group("spawn")
	var node = nodes[randi()% nodes.size()]
	var position = node.position
	$SpawnLocation.position = position
	 # Replace with function body.


func _on_Player_hero_update_health(value):
	health_progress.value = value
	pass # Replace with function body.

		
func _on_BossSpawn_timeout():
	var bossInstance = boss.instance()
	add_child(bossInstance)
	bossInstance.position = $SpawnLocation.position
	var nodes = get_tree().get_nodes_in_group("spawn")
	var node = nodes[randi()% nodes.size()]
	var position = node.position
	$SpawnLocation.position = position
	pass # Replace with function body.



	pass # Replace with function body.
 # Replace with function body.
