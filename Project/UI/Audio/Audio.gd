extends TextureButton

const transTime = 0.2;
var faded = false;


func _ready():
	
	if pressed:
		Global.muteAudio = true
	else:
		Global.muteAudio = false
	

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


func _on_Audio_toggled(button_pressed: bool) -> void:
		Global.mute_audio(button_pressed)
