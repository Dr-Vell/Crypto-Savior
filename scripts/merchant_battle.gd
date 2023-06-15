extends Control

signal textpanel_closed
var test_id = 1
var player_current_motivation = GameState.player_current_motivation
var enemy_current_motivation = 0

func _ready():
	set_motivation($PlayerContainer/MotivationBar, GameState.player_current_motivation, GameState.player_max_motivation)	
	set_motivation($EnemyContainer/MotivationBar, 0, GameState.merchant_max_motivation)
	$PlayerContainer/AnimationPlayer.play("idle")
	$TextPanel.hide()
	$TestPanel.hide()
	show_text("Wild Merchant appears unexpectedly!")
	yield(self,"textpanel_closed")
	show_text("Merchant: If you speak the truth...")
	yield(self,"textpanel_closed")
	show_text("Merchant: ...answer these questions correctly!")
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
			if answer == "A":
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
			if answer == "C":
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
			if answer == "B":
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
		$TestPanel/Question.text = "How can attackers compromise sensitive information?"
		$TestPanel/OptionA/OptionAText.text = "By increasing encryption key resilience."
		$TestPanel/OptionB/OptionBText.text = "By complying with standardized protocols."
		$TestPanel/OptionC/OptionCText.text = "By extracting data from web browsers."	
		yield(get_tree().create_timer(0.15), "timeout")
		$TestPanel.show()
	else:
		$TestPanel/Question.text = "What are the potential consequences of cryptographic failure?"
		$TestPanel/OptionA/OptionAText.text = "Cryptographic failure can cause malfunctioning of electronic devices and lead to random shutdowns."
		$TestPanel/OptionB/OptionBText.text = "Cryptographic failure can lead to the unauthorized disclosure of sensitive information, such as passwords, \n credit card numbers, or classified documents."
		$TestPanel/OptionC/OptionCText.text = "Cryptographic failure can result in the loss of internet connectivity and disrupt online communication."
		yield(get_tree().create_timer(0.15), "timeout")
		$TestPanel.show()
		
func death():
	$PlayerContainer/AnimationPlayer.play("death")
	show_text("Merchant: You fake bastard!")	
	yield(self,"textpanel_closed")
	show_text("Merchant: I knew I shouldn't trust your ass.")
	yield(self,"textpanel_closed")
	show_text("Merchant: Get the hell out.")
	yield(self,"textpanel_closed")
	yield(get_tree().create_timer(0.25), "timeout")
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/gameover.tscn")
	
		
func victory():
	show_text("You completely motivated The Wild Merchant!")
	yield(self,"textpanel_closed")
	show_text("Merchant: Alright! I see you know your stuff!")	
	yield(self,"textpanel_closed")
	show_text("Merchant: Keep it up!")
	yield(self,"textpanel_closed")
	show_text("This battle raised your motivation fists 20 points!")
	yield(self,"textpanel_closed")
	yield(get_tree().create_timer(0.25), "timeout")
	GameState.player_current_motivation = player_current_motivation
	GameState.player_hit = 40
	GameState.merchant_defeated = true
	GameState.player_current_position=Vector2(434,-85)
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/main.tscn")
		
func correct_answer():	
	show_text("Correct!")
	enemy_current_motivation += GameState.player_hit
	set_motivation($EnemyContainer/MotivationBar, enemy_current_motivation, GameState.merchant_max_motivation)	
	yield(self,"textpanel_closed")
	
func incorrect_answer():	
	show_text("Incorrect!")
	player_current_motivation -= GameState.enemy_hit
	set_motivation($PlayerContainer/MotivationBar, player_current_motivation, GameState.player_max_motivation)
	enemy_current_motivation += GameState.player_hit
	set_motivation($EnemyContainer/MotivationBar, enemy_current_motivation, GameState.merchant_max_motivation)
	yield(self,"textpanel_closed")	
	show_text("You lost 20 motivation")
	yield(self,"textpanel_closed")
