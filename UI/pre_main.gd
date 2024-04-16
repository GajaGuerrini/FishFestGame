extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	MusicController.play_music()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_start_pressed():
	get_tree().change_scene_to_file("res://UI/menu.tscn")
