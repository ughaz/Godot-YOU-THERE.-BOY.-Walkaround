extends TextureButton

var dialog = """To walk around, use the mouse, arrow keys, or WASD keys. Click on various objects to open command menus for them!

Godot programming by Sharkalien and Axollyon (abyssalLotl).
Based on "[S] YOU THERE. BOY." from Homestuck (page 253).""";

var dialogBox = load("res://UI/Dialog Box/DialogPlayer.tscn")
var faded:bool = false;
const transTime = 0.2;


func _process(_delta):
	if (Global.dialogOpen && !Global.dialogDone && !Global.dialogClosing && !faded):
		faded = true;
		var tween := create_tween()
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "modulate", Color(1,1,1,0.5), transTime);
		tween.play();
	elif (Global.dialogOpen && Global.dialogClosing && faded):
		faded = false;
		var tween := create_tween()
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "modulate", Color(1,1,1,1), transTime);
		tween.play();


func _on_Controls_pressed() -> void:
	if (!Global.dialogOpen && !Global.imageOpen && !Global.fading):
		Global.remove_commands();
		var dialogBoxInstance = dialogBox.instantiate();
		Global.dialogsNode.add_child(dialogBoxInstance);
		dialogBoxInstance.dialog = dialog;
