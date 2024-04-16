extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
		#MusicController.play_music()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://UI/Story.tscn")


func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://UI/music_volume_setting.tscn")


func _on_quit_button_pressed():
	get_tree().quit()


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://UI/Credits.tscn")


func _on_controls_pressed():
	get_tree().change_scene_to_file("res://UI/controls.tscn")
