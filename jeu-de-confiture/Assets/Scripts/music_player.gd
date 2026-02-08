extends AudioStreamPlayer

const music = preload("res://Sound/Music/Pu-Li-Ru-La_spotdown.org.mp3")

func _ready():
	_play_music()

func _play_music(volume = -15.0):
	if (stream == music):
		return
	stream = music
	volume_db = volume
	play()
	finished.connect(_play_music)
