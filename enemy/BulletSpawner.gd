extends Node3D

@export var BULLET_SPEED : int = 25
@onready var bullet_scene = preload("res://standard_bullet.tscn")
@onready var bullet_spawn_point = %EnemyBulletSpawner

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	spawn_bullet()
	pass

func spawn_bullet():
	var projectile = bullet_scene.instantiate()
	add_sibling(projectile)
	projectile.transform = bullet_spawn_point.global_transform
	projectile.linear_velocity = bullet_spawn_point.global_transform.basis.z * -1 * BULLET_SPEED

func _on_despawning_bullets_timeout():
	queue_free()


func _on_fire_timer_timeout():
	spawn_bullet()
