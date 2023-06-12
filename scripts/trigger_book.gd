extends Area2D

func _input(event):
	if event.is_action_pressed("ui_accept") and len(get_overlapping_bodies()) > 1:
		open_book(self.name)
		
func open_book(book):
	var book_panel = get_parent().get_node("BookPanel")	
	if book_panel:
		book_panel.start(book)
