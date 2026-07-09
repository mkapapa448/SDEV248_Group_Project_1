extends CharacterBody2D

const projectile_scene = preload("res://zap.tscn")
const projectile_speed = 400
@onready var attack_timer = $attackTimer
var speed = 75.0
var direction = Vector2(0, 1)

var attacking = false
var frozen = false

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	if frozen == false:
		velocity = direction * speed
	else:
		velocity = Vector2(0, 0)
	move_and_slide()
	
	if attack_timer.is_stopped() and attacking == true:
		attack()
	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		var collision_normal = collision.get_normal()
		
		
		if collider is TileMapLayer:
			if velocity.dot(collision_normal) < 0:
				position += collision_normal * 1.0 
				direction = Vector2(-direction.y, direction.x)
				
	if direction.x == -1:
		$Sprite2D.rotation = (PI/2)
		$sight.rotation = (PI/2)
		
	elif direction.x == 1:
		$Sprite2D.rotation = -(PI/2)
		$sight.rotation = -(PI/2)
	else:
		$Sprite2D.rotation = 0
		
	if direction.y == -1:
		$Sprite2D.flip_v = true
		$sight.rotation = PI
	elif direction.y == 1:
		$Sprite2D.flip_v = false
		$sight.rotation = 0
	else:
		$Sprite2D.flip_v = false

func attack():
	var new_projectile = projectile_scene.instantiate()
	new_projectile.global_position = $sight/Marker2D.global_position
	get_tree().current_scene.add_child(new_projectile)
	attack_timer.start()
	
func _on_sight_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.name == "Link":
		speed = 300

func _on_sight_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D and body.name == "Link":
		speed = 75


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.name == "Link":
		attacking = true
		frozen = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D and body.name == "Link":
		attacking = false
		frozen = false
