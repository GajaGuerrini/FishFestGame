extends Node

var music_ingame = load("res://Assets/Audio/Fish Shooter (MUSIC) GAMEPLAY MUSIC.wav")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func play_music():
	$Music.stream = music_ingame	
	$Music.play()
