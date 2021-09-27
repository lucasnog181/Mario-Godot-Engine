extends KinematicBody2D

export var gravity = 10
export var walk_speed = 150
export var jump_forcer = 300
export var movement = Vector2(0,0)

var double_jump = true


func _physics_process(delta):
	if not is_on_floor():
		movement.y+=gravity
	else:
		double_jump = true
		
		var horizotal_aixs = Input.get_action_strength("rigth") - Input.get_action_strength("left")
		movement.x = horizotal_aixs * walk_speed
		
		if Input.is_action_just_pressed("jump") and is_on_floor():
			position.y -= jump_forcer
		
		elif Input.is_action_just_pressed("jump") and double_jump:
			movement.y = - jump_forcer
			double_jump = false
		
		move_and_slide(movement, Vector2.UP)
		
		update_animations()
		
		
func update_animations():
		if movement.x >0:
			$AnimatedSprite.flip_h = false
		elif movement.x <0:
			$AnimatedSprite.flip_h = true
			
			if is_on_floor():
				if abs(movement.x) > 0:
					$AnimatedSprite.play("walk")
				else:
					$AnimatedSprite.play("idle")
			else:
				$AnimatedSprite.play("jump")		

