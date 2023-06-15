extends CanvasLayer

export var npc : String = "NPC"
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
	if npc == "Merchant":
		var d1 = "..."
		var d2 = "...Welcome to my shop stranger."
		var d3 = "There's some interesting stuff here you might want to take."
		var d4 = "but..."
		var d5 = "THEY'RE NOT FOR SALE! SO DON'T TOUCH ANYTHING!"
		var d6 = "Thanks."
		var d7 = "..."
		var d8 = "<<The merchant keeps staring at you>>"
		var d9 = "Oh, I see you are a Crypto Guard."
		var d10 = "..."
		var d11 = "THEN PROVE IT!"
		return [d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11]
		
	if npc == "Warrior":
		var d1 = "SILENCE Mr Guard of the Cryptos!"
		var d2 = "I don't wish to be cryptoed anymore..."
		var d3 = "I just want to be happy."
		var d4 = "<<The fierce warrior keeps staring at you>>"
		var d5 = "Okay...okay, you came to do your thing right?"
		var d6 = "First let's see if I can trust ur knowledge about these attacks..."
		return [d1,d2,d3,d4,d5,d6]
		
	if npc == "Mino":
		var d1 = "..."
		var d2 = "Yes, I can talk."
		var d3 = "No, you wont leave here unscathed."
		var d4 = "GRRRRR!"
		return [d1,d2,d3,d4]

func _input(event):
	if not d_active:
		return
	if event.is_action_pressed("ui_accept"):
		next_script()
		
func next_script():
	current_dialogue_id += 1
	
	if dialogue == null or current_dialogue_id >= dialogue.size():
		d_active = false
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/battle_"+ battle_id +".tscn")
		return
		
	if npc == "Merchant":
		if current_dialogue_id in [0,6,7]:
			$NinePatchRect/Name.text = " "
		else:
			$NinePatchRect/Name.text = npc
	elif npc == "Warrior":
		if current_dialogue_id == 3:
			$NinePatchRect/Name.text = " "
		else:
			$NinePatchRect/Name.text = npc
	else:
		$NinePatchRect/Name.text = npc
	$NinePatchRect/Text.text = dialogue[current_dialogue_id]
