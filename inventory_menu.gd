class_name Inventory_menu extends Control

@export var fade_in_duration := 0.3
@export var fade_out_duration := 0.2

@onready var center_cont := $ColorRect/CenterContainer as CenterContainer
@onready var noteLabel := $ColorRect/CenterContainer/HBoxContainer/TextureRect2/VBoxContainer/RichTextLabel
@onready var vocabBox := $ColorRect/CenterContainer/HBoxContainer/TextureRect2/VBoxContainer/ColorRect/HFlowContainer
var entrywayNote = "[font_size={12}][color=black]Dear Xanath,
I am [color=brown][url=entrywayWord1]{entryway1}[/url][/color], writing to you to request your assistance in my magical tutelage. I have heard tales of your great magical prowess told throughout my home village enough to carefully learn the location of your deep seclusion in hopes of seeking out your assistance. While I may not have the magic coursing through me, I promise you that I am quite serious about pursuing the craft of incantation and spellcasting. I understand that this is a considerable ask for a wizard of your renown and I can only wish that you will pass along your breadth of magical knowledge to me in kind by allowing me to be your student.
Hopefully, Rey"
var entryway1 = entrywayNote.format({"entryway1": "_____"})
var activeButton = "_____"
var note_array = ["red", "yellow", "blue"]
#updateVocabulary():
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	createButtons(note_array)
	updateNote()
	



func close() -> void:
	var tween := create_tween()
	get_tree().paused = false
	tween.tween_property(
		self,
		^"modulate:a",
		0.0,
		fade_out_duration
	).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(
		center_cont,
		^"anchor_bottom",
		0.5,
		fade_out_duration
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_callback(hide)
	
func open() -> void:
	#updateVocabulary()
	show()
	#resume_button.grab_focus()
	modulate.a = 0.0
	center_cont.anchor_bottom = 0.5
	var tween := create_tween()
	tween.tween_property(
		self,
		^"modulate:a",
		1.0,
		fade_in_duration
	).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	tween.parallel().tween_property(
		center_cont,
		^"anchor_bottom",
		1.0,
		fade_out_duration
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	

func updateNote():
	noteLabel.text = entryway1


func _on_rich_text_label_meta_clicked(meta):
	print("plop")
	match meta:
		"entrywayWord1":
			entryway1 = entrywayNote.format({"entryway1": activeButton})
			updateNote()

func createButtons(options: Array):
	for option in options:
		var button = Button.new()
		button.text = option
		button.connect("pressed", Callable(self, "_on_button_pressed()"))
		vocabBox.add_child(button)
		

func _on_button_pressed(option: String):
	print("Button pressed: %s" % option)
