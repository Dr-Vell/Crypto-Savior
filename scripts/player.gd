extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()
onready var _animation_player = $AnimationPlayer

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
		
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		
	if Input.is_action_pressed("down"):
		velocity.y += 1
		
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		
	velocity = velocity.normalized() * speed
	
func set_anims():
	if Input.is_action_pressed("right"):
		$PlayerSprite.flip_h = false
		_animation_player.play("walk")
	elif Input.is_action_pressed("left"):
		$PlayerSprite.flip_h = true
		_animation_player.play("walk")
	elif Input.is_action_pressed("down") || Input.is_action_pressed("up") :
		_animation_player.play("walk")
	else:
		_animation_player.play("idle")

func _physics_process(delta):
	get_input()
	set_anims()
	velocity = move_and_slide(velocity)
