extends AudioStreamPlayer

const music = preload("res://Sound/Music/Pu-Li-Ru-La_spotdown.org.mp3")

func _ready():
	finished.connect(func(): play(0))
