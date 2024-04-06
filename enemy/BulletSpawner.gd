extends Node3D

@export var BULLET_SPEED : float = 25
@onready var bullet_scene = preload("res://enemy/enemy_bullet.tscn")
@onready var bullet_spawn_point = %EnemyBulletSpawner
var amIdead = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _physics_process(_delta):
	pass
	
func spawn_bullet():
	if (amIdead == 0):
		var projectile = bullet_scene.instantiate()
		add_sibling(projectile)
		projectile.global_position = bullet_spawn_point.global_position
		projectile.linear_velocity = bullet_spawn_point.global_transform.basis.z * BULLET_SPEED

func _on_despawning_bullets_timeout():
	queue_free()


func _on_fire_timer_timeout():
	spawn_bullet()


func _on_hitting_enemy_am_idead():
	amIdead = 1 # Replace with function body.
