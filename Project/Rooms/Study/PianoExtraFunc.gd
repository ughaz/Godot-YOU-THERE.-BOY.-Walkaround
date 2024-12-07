extends Node

@export var hauntingRefrain: AudioStream

func extraFunc():
	Global.audioNode.stream = hauntingRefrain
	Global.audioNode.play()
