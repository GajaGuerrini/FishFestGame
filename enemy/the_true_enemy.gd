class_name Enemy

extends CharacterBody3D

@export var CURRENT_HP:int = 5
@export_range(3.0, 10.0) var ENEMY_SPEED : float = 3.0 # pocasen

var Enemy_hight = range(0.2, )

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _physics_process(delta):
	var direction = (transform.basis *(Global.player.position- position)).normalized()
	velocity = direction * ENEMY_SPEED
	
	move_and_slide()

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
		print("bullet hit! remaining HP: ",CURRENT_HP)
		if CURRENT_HP == 0:
			queue_free()
		
