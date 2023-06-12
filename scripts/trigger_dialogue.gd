extends Area2D

func _input(event):
	if event.is_action_pressed("ui_accept") and len(get_overlapping_bodies()) > 1:
		var node_name = self.name
		if node_name == "CF-1 Intro" || node_name == "CF-2 Attack" || node_name == "CF-3 Defense":
			open_book(self.name)
		elif node_name == "VictoryArea":
			victory()
		else:
			use_dialogue()
		
func use_dialogue():
	var dialogue = get_parent().get_node("Dialogue")	
	if dialogue:
		dialogue.start()
		
func open_book(book):
	var book_panel = get_parent().get_node("BookPanel")	
	if book_panel:
		book_panel.start(book)		
		
func victory():
	get_tree().change_scene("res://scenes/victory.tscn")
