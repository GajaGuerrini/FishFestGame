class_name Player 
extends CharacterBody3D

@export var MOUSE_SENSITIVITY : float = 0.5
@export var TILT_LOWER_LIMIT := deg_to_rad(-75.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(75.0)
@export var CAMERA_CONTROLLER : Camera3D
@export var ANIMATIONPLAYER : AnimationPlayer
@export var MAX_HP : int = 50
#standard bullet
@export var BULLET_SPEED : int = 25
@onready var bullet_scene = preload("res://standard_bullet.tscn")
@onready var bullet_spawn_point = $CameraController/MainCamera/BulletSpawner


var _mouse_input : bool = false
var _rotation_input : float
var _tilt_input : float
var _mouse_rotation : Vector3
var _player_rotation : Vector3
var _camera_rotation : Vector3
var CURRENT_HP : int

# Get the gravity from the project settings to be synced with RigidBody nodes.
# gravitacijo se lahko spremeni po potrebi
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") 

func _unhandled_input(event: InputEvent) -> void:
	_mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	if _mouse_input:
		_rotation_input = -event.relative.x * MOUSE_SENSITIVITY
		_tilt_input = -event.relative.y * MOUSE_SENSITIVITY

func _input(event):
	if event.is_action_pressed("fire"):
		spawn_bullet()
		%AudioBulletSFX.play()
	if event.is_action_pressed("exit"):
		get_tree().quit()

func update_camera(delta) -> void:
	_mouse_rotation.x += _tilt_input * delta
	_mouse_rotation.x = clamp(_mouse_rotation.x, TILT_LOWER_LIMIT, TILT_UPPER_LIMIT)
	_mouse_rotation.y += _rotation_input * delta
	
	_player_rotation = Vector3(0.0,_mouse_rotation.y,0.0)
	_camera_rotation = Vector3(_mouse_rotation.x,0.0,0.0)

	CAMERA_CONTROLLER.transform.basis = Basis.from_euler(_camera_rotation)
	global_transform.basis = Basis.from_euler(_player_rotation)
	
	CAMERA_CONTROLLER.rotation.z = 0.0

	_rotation_input = 0.0
	_tilt_input = 0.0
	
func _ready():
	
	Global.player = self
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	CURRENT_HP = MAX_HP
	set_health_label()
	set_health_bar()
	
func _physics_process(delta):
	
	Global.debug.add_property("Velocity","%.2f" % velocity.length(), 2)
	update_camera(delta)

	
func update_gravity(delta) -> void:
	velocity.y -= gravity * delta
	
func update_input(speed: float, acceleration: float, deceleration: float) -> void:
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = lerp(velocity.x,direction.x * speed, acceleration)
		velocity.z = lerp(velocity.z,direction.z * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.z = move_toward(velocity.z, 0, deceleration)
	
func update_velocity() -> void:
	move_and_slide()

func spawn_bullet():
	var projectile = bullet_scene.instantiate()
	add_sibling(projectile)
	projectile.transform = bullet_spawn_point.global_transform
	projectile.linear_velocity = bullet_spawn_point.global_transform.basis.z * -1 * BULLET_SPEED

func _on_area_detecting_hits_body_entered(body):
	if body.is_in_group("enemy_projectile"):
		CURRENT_HP -= 1
		body.queue_free()
		$AreaDetectingHits/AudioPlayerisHitt.play()
		set_health_label()
		set_health_bar()
	if CURRENT_HP == 0:
		$AreaDetectingHits/AudioPlayerDeath.play()
		set_health_bar()
		set_health_label()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		await $AreaDetectingHits/AudioPlayerDeath.finished
		get_tree().change_scene_to_file("res://UI/game_over.tscn")
		
		

func set_health_label() -> void:
	$PlayersHP/PanelContainer/Panel/VBoxContainer/HP.text = "HP: %s" % CURRENT_HP

func set_health_bar() -> void:
	$PlayersHP/PanelContainer/Panel/VBoxContainer/HPBar.max_value = MAX_HP
	$PlayersHP/PanelContainer/Panel/VBoxContainer/HPBar.value = CURRENT_HP
