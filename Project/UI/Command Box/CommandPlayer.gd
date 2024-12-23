extends Control

signal clicked

@onready var root = get_tree().get_root()
@onready var commandBox = self
@onready var commandContainer = get_node("MarginContainer/VBoxContainer")
const label = preload("res://UI/Command Box/CommandLabel.tscn");
var labelInstance:RichTextLabel = label.instantiate()
@onready var COMMAND_MARGIN = labelInstance.get("theme_override_styles/normal").content_margin_left * 2

var dict:Dictionary = {"command": "", "dialog": """""", "warpScene": null, "warpPos": "", "zoomImage": null}
var interactDialog:Array
var multiCommand:bool = false

var clicks:int = 0
var width:int;
var lastWidth:int
var height:int;


func _ready() -> void:
	commandContainer.add_child(labelInstance)
# warning-ignore:return_value_discarded
	labelInstance.connect("command_clicked", emit_clicked)
	call_deferred("check_interactable_dict", labelInstance)
	if !multiCommand:
		call_deferred("set_command", labelInstance)
	else:
		call_deferred("set_multicommand")

func emit_clicked():
	emit_signal("clicked")

func check_interactable_dict(instance):
	for key in dict:
		if key in interactDialog[clicks]:
			instance.set(key, interactDialog[clicks].get(key))

func set_command(labelInst):
	labelInst.bbcode_text = ("> " + labelInst.command)
	lastWidth = labelInst.get("theme_override_fonts/normal_font").get_string_size(labelInst.text,HORIZONTAL_ALIGNMENT_LEFT, -1,labelInst.get("theme_override_font_sizes/normal_font_size")).x + COMMAND_MARGIN
	if width < lastWidth:
		width = lastWidth
		commandBox.size.x = width
	height = commandBox.size.y
	
	var click;
	if get_viewport():
		click = get_global_mouse_position()
	else:
		click = Vector2.ZERO
		push_warning("no viewport?")
	var viewportWidth = root.get_visible_rect().size.x
	if (width > viewportWidth):
		width = viewportWidth
		commandBox.size.x = width
	if (click.x + width > viewportWidth):
		click.x = viewportWidth - width;
	commandBox.global_position = Vector2(click.x, click.y - 9); # the flash has a particular offset


func set_multicommand():
	commandContainer.get_child(0).queue_free()
	for i in interactDialog:
		var lab  = label.instantiate()
		commandContainer.add_child(lab)
		for key in dict:
			if key in i:
				lab.set(key, i.get(key))
		call_deferred("set_command", lab)
