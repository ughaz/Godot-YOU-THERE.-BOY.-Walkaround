extends RichTextLabel

signal command_clicked

var command:String;
var dialog:String = """""";
var warpScene;
var warpPos = "";
var zoomImage;

var timer:int = 2; # to make "> " visible first
var clicks:int = 0;
var width:int;

var imageBox = load("res://UI/Zoom Image/ZoomImage.tscn")
var dialogBox = load("res://UI/Dialog Box/DialogPlayer.tscn")


func _ready() -> void:
	visible_characters = timer

func _process(_delta):
	if (timer < command.length() + 2):
		timer += 2;
		visible_characters = timer;

func _on_CommandLabel_mouse_entered() -> void:
	if (!Global.fading):
		Global.hoverNodes.append(self);
	add_theme_color_override("default_color",  Color(0.63, 0.63, 0.63))

func _on_CommandLabel_mouse_exited() -> void:
	if (!Global.fading):
		Global.hoverNodes.erase(self);
	remove_theme_color_override("default_color")

func _exit_tree():
	Global.hoverNodes.erase(self);


func _on_CommandLabel_gui_input(event: InputEvent) -> void:
	if (!Global.dialogOpen && event.is_action_pressed("click")):
		emit_signal("command_clicked")
		Global.remove_commands();
		if (zoomImage):
			var imageBoxInstance = imageBox.instantiate();
			Global.imagesNode.add_child(imageBoxInstance);
			if (!dialog.is_empty() && dialog != null):
				imageBoxInstance.dialog = dialog;
			imageBoxInstance.imageTexture = zoomImage;
		elif (!dialog.is_empty() && dialog != null):
			var dialogBoxInstance = dialogBox.instantiate();
			Global.dialogsNode.add_child(dialogBoxInstance);
			dialogBoxInstance.dialog = dialog;
		elif (warpScene != null && !warpScene.is_empty()):
			Global.fadeto_scene(warpScene, warpPos);
		else:
			pass
