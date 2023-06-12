extends Area2D

func _input(event):
	if event.is_action_pressed("ui_accept") and len(get_overlapping_bodies()) > 1:
		open_book(self.name)
		
func open_book(book):
	pass
	
