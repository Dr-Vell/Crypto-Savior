extends Control

signal textpanel_closed
var test_id = 1
var player_current_motivation = GameState.player_current_motivation
var enemy_current_motivation = 0

func _ready():
	set_motivation($PlayerContainer/MotivationBar, GameState.player_current_motivation, GameState.player_max_motivation)	
	set_motivation($EnemyContainer/MotivationBar, 0, GameState.mino_max_motivation)
	$PlayerContainer/AnimationPlayer.play("idle")
	$TextPanel.hide()
	$TestPanel.hide()
	show_text("A massive wild minotaur appears unexpectedly!")
	yield(self,"textpanel_closed")
	show_text("Mino: Grrr!")
	yield(self,"textpanel_closed")
	yield(get_tree().create_timer(0.15), "timeout")
	$TestPanel.show()
	

func _input(_event):
	if Input.is_action_just_pressed("ui_accept"):
		$TextPanel.hide()
		emit_signal("textpanel_closed")
		
func show_text(text):
	$TextPanel.show()
	$TextPanel/Label.text = text
	


func _on_OptionA_pressed():	
	attack("A")

func _on_OptionB_pressed():	
	attack("B")

func _on_OptionC_pressed():		
	attack("C")


func attack(option):	
	$TestPanel.hide()	
	$PlayerContainer/AnimationPlayer.play("attack")
	yield($PlayerContainer/AnimationPlayer, "animation_finished")
	$PlayerContainer/AnimationPlayer.play("idle")
	check_answer(test_id,option)

func check_answer(test, answer):
	match (test):
		1:
			if answer == "B":
				correct_answer()
				test_id=2
				show_test(test_id)
				
			elif player_current_motivation==20:
				incorrect_answer()
				death()
				
			else:
				incorrect_answer()
				test_id=2
				show_test(test_id)
				
		2:
			if answer == "A":
				correct_answer()
				test_id=3
				show_test(test_id)
				
			elif player_current_motivation==20:
				incorrect_answer()
				death()
				
			else:
				incorrect_answer()
				test_id=3
				show_test(test_id)
		3:
			if answer == "C":
				correct_answer()
				victory()
				
			elif player_current_motivation==20:
				incorrect_answer()
				death()
				
			else:
				incorrect_answer()
				victory()
		

func set_motivation(bar, motivation, max_motivation):
	bar.value = motivation
	bar.max_value = max_motivation
	bar.get_node("Motivation").text = "M: %d/%d" % [motivation,max_motivation]
	

func show_test(test):
	if test==2:
		$TestPanel/Question.text = "Which of the following is NOT a preventive measure for cryptographic failures?"
		$TestPanel/OptionA/OptionAText.text = "Using outdated protocols like FTP and SMTP for transmitting sensitive data."
		$TestPanel/OptionB/OptionBText.text = "Categorizing data based on privacy laws and business needs."
		$TestPanel/OptionC/OptionCText.text = "Choosing appropriate initialization vectors for the mode of operation."	
		yield(get_tree().create_timer(0.15), "timeout")
		$TestPanel.show()
	else:
		$TestPanel/Question.text = "What is the recommended approach for storing passwords to \n prevent cryptographic failures?"
		$TestPanel/OptionA/OptionAText.text = "Generating keys randomly using cryptographic methods and storing them as plain text."
		$TestPanel/OptionB/OptionBText.text = "Storing passwords as plain text for easy retrieval."
		$TestPanel/OptionC/OptionCText.text = "Converting passwords to keys using a password-based key derivation function."	
		yield(get_tree().create_timer(0.15), "timeout")
		$TestPanel.show()
		
func death():
	$PlayerContainer/AnimationPlayer.play("death")
	show_text("Mino: Hahahaha!")	
	yield(self,"textpanel_closed")
	show_text("Mino: What a prick.")
	yield(self,"textpanel_closed")
	show_text("Mino: Prepare yourself better next time.")
	yield(self,"textpanel_closed")
	yield(get_tree().create_timer(0.25), "timeout")
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/gameover.tscn")
	
		
func victory():
	show_text("You completely motivated Mino!")
	yield(self,"textpanel_closed")
	show_text("Mino: Grrrr!")	
	yield(self,"textpanel_closed")
	show_text("Mino: You win...")
	yield(self,"textpanel_closed")
	show_text("This battle raised your motivation fists 2000 points!")
	yield(self,"textpanel_closed")
	yield(get_tree().create_timer(0.25), "timeout")
	GameState.player_current_motivation = player_current_motivation
	GameState.mino_defeated = true
	GameState.player_current_position=Vector2(1266,-65)
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/main.tscn")
		
func correct_answer():	
	show_text("Correct!")
	enemy_current_motivation += GameState.player_hit
	set_motivation($EnemyContainer/MotivationBar, enemy_current_motivation, GameState.mino_max_motivation)	
	yield(self,"textpanel_closed")
	
func incorrect_answer():	
	show_text("Incorrect!")
	player_current_motivation -= GameState.enemy_hit
	set_motivation($PlayerContainer/MotivationBar, player_current_motivation, GameState.player_max_motivation)
	enemy_current_motivation += GameState.player_hit
	set_motivation($EnemyContainer/MotivationBar, enemy_current_motivation, GameState.mino_max_motivation)
	yield(self,"textpanel_closed")	
	show_text("You lost 20 motivation")
	yield(self,"textpanel_closed")
