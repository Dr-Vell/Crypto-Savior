extends Node2D


func _ready():
	$Player.position=GameState.player_current_position
	
	if GameState.merchant_defeated:
		$"Plants 1".queue_free()
		$"Enemy 3/Area2D".queue_free()
	if GameState.warrior_defeated:
		$"Plants 2".queue_free()
		$"Enemy 1/Area2D".queue_free()
	if GameState.mino_defeated:
		$"Plants 3".queue_free()
		$"Enemy 2/Area2D".queue_free()
