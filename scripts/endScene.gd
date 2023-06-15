extends Control


func _ready():
	$Timer.start()


func _on_Timer_timeout():
	if self.name=="Tutorial":
		GameState.player_current_motivation = 60
		GameState.player_current_position= Vector2(0,0)
		GameState.player_hit = 20
		GameState.merchant_defeated = false
		GameState.warrior_defeated = false
		GameState.mino_defeated = false
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/main.tscn")
	else:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/menu.tscn")
