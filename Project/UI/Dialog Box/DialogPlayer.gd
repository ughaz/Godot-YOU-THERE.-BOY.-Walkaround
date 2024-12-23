extends Control

@onready var label:RichTextLabel = get_node("CenterContainer/Body_NinePatchRect/MarginContainer/RichTextLabel");
@onready var animPlayer:AnimationPlayer = get_node("CenterContainer/Body_NinePatchRect/AnimationPlayer");

var dialog:String = "";
var timer:int = 0;
var animDone:bool = false

func _ready():
	label.visible_ratio = 0.0
	animPlayer.play("Open")
	call_deferred("set_dialog")

func _process(_delta):
	if (!Global.dialogClosing && animDone):
		if (timer < dialog.length()):
			timer += 3;
			label.visible_characters = timer;
		elif (!Global.dialogDone):
			Global.dialogDone = true;
			print(label.get_visible_line_count())
			
		if Input.is_action_just_pressed("click"):
			if (!Global.dialogDone):
				timer = dialog.length();
				label.visible_ratio = 1.0
			else:
				label.visible_ratio = 0.0
				animPlayer.play_backwards("Open");
				Global.dialogClosing = true;

func set_dialog():
	label.bbcode_text = dialog;

func _on_animation_finished(_anim):
	animDone = true
	if (Global.dialogClosing):
		Global.dialogDone = false;
		Global.dialogClosing = false;
		queue_free();
