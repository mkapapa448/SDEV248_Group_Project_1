extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var impacted = false
var impacts = 0
var impact_vel: Vector2
var has_computer = false

signal changeScene
func change_scene(scenechange):
	changeScene.emit(scenechange)
	
func _physics_process(delta: float) -> void:
	if has_computer:
		$Link.hide()
		$ComputerLink.show()
	else:
		$Link.show()
		$ComputerLink.hide()
	
	if Game.switching == false and impacted == false:
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var directionx := Input.get_axis("left", "right")
		if directionx:
			velocity.x = directionx * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		var directiony := Input.get_axis("up", "down")
		if directiony:
			velocity.y = directiony * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
		move_and_slide()
	else:
		velocity += impact_vel
		impact_vel *= 0.6
		impacts += 1
		if impact_vel.length() <= 0.1:
			impacted = false
		move_and_slide()
	#else:
		#var tween = create_tween()
		
		#tween.tween_property(self, "position", position.x + 64, 1)
		#
		#pass

func impact(vel):
	velocity = Vector2(0, 0)
	impacted = true
	impact_vel = vel
	Game.lives -= 1
