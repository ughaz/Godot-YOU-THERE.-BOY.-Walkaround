extends Control

var dialog = """To walk around, use the mouse, arrow keys, or WASD keys. Click on various objects to open command menus for them!

Godot programming by Sharkalien and Axollyon (abyssalLotl).
Based on "[S] YOU THERE. BOY." from Homestuck (page 253).""";

var dialogBox = load("res://UI/Dialog Box/DialogPlayer.tscn")
var selected:bool = false;
var faded:bool = false;

func _on_mouse_entered()->void:
	if (!Global.fading):
		Global.hoverNodes.append(self);
		selected = true;

func _on_mouse_exited()->void:
	if (!Global.fading):
		Global.hoverNodes.erase(self);
		selected = false;

func _exit_tree():
	Global.hoverNodes.erase(self);

func _process(_delta):
	var time = 0.2;
	if (Global.dialogOpen && !Global.dialogDone && !Global.dialogClosing && !faded):
		faded = true;
		$Tween.interpolate_property($Sprite, "modulate", Color(1,1,1,1), Color(1,1,1,0.5), time, Tween.TRANS_LINEAR, Tween.EASE_OUT);
		$Tween.start();
	elif (Global.dialogOpen && Global.dialogClosing && faded):
		faded = false;
		$Tween.interpolate_property($Sprite, "modulate", Color(1,1,1,0.5), Color(1,1,1,1), time, Tween.TRANS_LINEAR, Tween.EASE_OUT);
		$Tween.start();
	
	if (Global.dialogsNode && !Global.dialogOpen && !Global.imageOpen && !Global.fading && selected && Input.is_action_just_pressed("click")):
		Global.remove_commands();
		var dialogBoxInstance = dialogBox.instance();
		Global.dialogsNode.add_child(dialogBoxInstance);
		dialogBoxInstance.dialog = dialog;
