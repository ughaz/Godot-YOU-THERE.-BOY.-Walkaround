extends Area2D

@export var interactDialog:Array[InteractDialog]
@export var multiCommand: bool = false
@export var extraFunc: NodePath

var clicks:int = 0
var selected:bool = false;
var commandBox = load("res://UI/Command Box/CommandPlayer.tscn")

func _ready():
	var interactable = self
	interactable.connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	interactable.connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _on_mouse_entered()->void:
	Global.hoverNodes.append(self);
	selected = true;

func _on_mouse_exited()->void:
	Global.hoverNodes.erase(self);
	selected = false;

func _exit_tree():
	Global.hoverNodes.erase(self);

func updateClicks():
	if clicks < interactDialog.size() - 1:
		clicks += 1
	else:
		clicks = 0

func _process(_delta):
	if (!Global.dialogOpen && !Global.imageOpen && !Global.fading && selected && Input.is_action_just_pressed("click")):
		var commandBoxInstance = commandBox.instantiate();
		if multiCommand:
			commandBoxInstance.multiCommand = multiCommand
		commandBoxInstance.interactDialog = interactDialog
		Global.remove_commands();
		Global.commandsNode.add_child(commandBoxInstance);
		if !multiCommand:
			commandBoxInstance.connect("clicked", Callable(self, "updateClicks"))
			commandBoxInstance.clicks = clicks
		if extraFunc:
			var extraFunction = get_node(extraFunc)
			if extraFunction.has_method("extraFunc"):
				commandBoxInstance.connect("clicked", Callable(extraFunction, "extraFunc"))
