extends Node3D

@export_range(3.0, 10.0) var ENEMY_SPEED : float = 3.0 # pocasen

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#func _on_area_3d_body_entered(body):
	#if body.is_in_group("projectile"):
		#body.queue_free()
		#queue_free()
		#print("Hit!")


func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		print("Player has been detected", body.name)


func _on_detection_area_body_exited(body):
	print("Player has been lost")
	pass # Replace with function body.
