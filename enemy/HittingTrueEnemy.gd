class_name Enemy

extends CharacterBody3D

@export var CURRENT_HP:int = 5
@export_range(3.0, 10.0) var ENEMY_SPEED : float = 3.0 # pocasen
@export var HOVER_DISTANCE:float = 5

var direction : Vector3
var Enemy_hight = range(0.2, )
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _physics_process(delta):
	#var direction = (transform.basis *(Global.player.position- position)).normalized()
	direction = (Global.player.position- position).normalized()
	direction.y=0
	
	if (Global.player.position- position).length() > HOVER_DISTANCE:
		velocity.x = direction.x * ENEMY_SPEED
		velocity.z = direction.z * ENEMY_SPEED
		
	if (Global.player.position- position).length() < HOVER_DISTANCE:
		velocity.x = -direction.x * ENEMY_SPEED
		velocity.z = -direction.z * ENEMY_SPEED
		
	update_gravity(delta)
	var PointToLookAt = Global.player.global_transform.origin
	#PointToLookAt.z += 1
	look_at(PointToLookAt, Vector3.UP) 
	
	move_and_slide()
	
	
func update_gravity(delta) -> void:
	velocity.y -= gravity * delta

func _on_area_3d_body_entered(body):
	if body.is_in_group("projectile"):
		body.queue_free()
		queue_free()
		print("Hit!")


func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		print("Player has been detected", body.name)



func _on_detection_area_body_exited(body):
	if body.is_in_group("player"):
		print("Player has been lost")
	


func _on_bullet_hit_box_body_entered(body):
	if body.is_in_group("projectile"):
		CURRENT_HP -= 1
		body.queue_free()
		print("bullet hit! remaining HP: ",CURRENT_HP)
		$AudioEnemyDmg.play()
		if CURRENT_HP == 0:
			$AudioEnemyDeath.play()
			$AudioEnemyDmg.stop()
			hide()
			#queue_free()
