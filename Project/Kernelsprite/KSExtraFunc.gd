extends Node

@export var ksBabbleAnimPlayer: NodePath

func extraFunc():
	if ksBabbleAnimPlayer:
		var animPlayer: AnimationPlayer = get_node(ksBabbleAnimPlayer)
		animPlayer.play("babble")
