extends Control


func _ready():
	$Timer.start()
	GameState.player_current_motivation = 60
	GameState.player_current_position= Vector2(0,0)
	GameState.player_hit = 20
	GameState.merchant_defeated = false
	GameState.warrior_defeated = false
	GameState.mino_defeated = false


func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/menu.tscn")
