extends CanvasLayer

export(String, FILE, "*.json") var dialogue_file
export var battle_id : String = "0"

var dialogue = []
var current_dialogue_id = 0
var d_active = false

func _ready():
	$NinePatchRect.visible = false	
	
func start():
	if d_active:
		return
	d_active = true
	$NinePatchRect.visible = true
	dialogue = load_dialogue()
	current_dialogue_id = -1
	next_script()

func load_dialogue():
	var file = File.new()
	if file.file_exists(dialogue_file):
		file.open(dialogue_file, file.READ)
		var data = parse_json(file.get_as_text())
		if data != null:
			return data
		else:
			print("Error al parsear el archivo JSON")
			return []
	else:
		print("Archivo JSON no encontrado")
		return []

func _input(event):
	if not d_active:
		return
	if event.is_action_pressed("ui_accept"):
		next_script()
		
func next_script():
	current_dialogue_id += 1
	
	if dialogue == null or current_dialogue_id >= dialogue.size():
		d_active = false
		get_tree().change_scene("res://scenes/battle_"+ battle_id +".tscn")
		return
	
	$NinePatchRect/Name.text = dialogue[current_dialogue_id]['name']
	$NinePatchRect/Text.text = dialogue[current_dialogue_id]['text']
