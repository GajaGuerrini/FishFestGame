extends Camera3D

var Ray_Range = 2000
# Called when the node enters the scene tree for the first time.
func _input(event):
	if event.is_action_pressed("fire"):
		Get_Camera_Collision()

func Get_Camera_Collision():
	var Centre = get_viewport().get_size()/2
	var Ray_Origin = project_ray_origin(Centre)
	var Ray_End = Ray_Origin + project_ray_normal(Centre)*Ray_Range
	var New_Intersection = PhysicsRayQueryParameters3D.create(Ray_Origin, Ray_End)
	var Intersection = get_world_3d().direct_space_state.intersect_ray(New_Intersection)
	
	if not Intersection.is_empty():
		print(Intersection.collider.name)
	else:
		print("Nothing")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
