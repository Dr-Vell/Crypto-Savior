extends CharacterBody2D

@export var vel = 150
@onready var _animation_player = $AnimationPlayer

func player_movement():
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir * vel
	
	if input_dir.x > 0:
		$Sprite2D.flip_h = false
		_animation_player.play("walk")
		
	elif input_dir.x < 0:
		$Sprite2D.flip_h = true
		_animation_player.play("walk")
		
	elif input_dir.x == 0 && input_dir.y > 0 || input_dir.x == 0 && input_dir.y < 0:
		_animation_player.play("walk")
		
	else:
		_animation_player.play("idle")
	
func _physics_process(delta):
	player_movement()
	move_and_slide()
