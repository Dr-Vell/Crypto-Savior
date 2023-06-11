extends Node2D


func _ready():
	$Player.position=GameState.player_current_position
