extends AudioStreamPlayer2D

const music = preload("res://Sound/Music/Pu-Li-Ru-La_spotdown.org.mp3")

func _play_music(volume = -8.0):
	if (stream == music):
		return
	stream = music
	volume_db = volume
	play()
