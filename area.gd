extends Area2D
@export var camera: Camera2D # Drag your Camera2D node into this slot in the Inspector
@export var player: CharacterBody2D # Drag your Camera2D node into this slot in the Inspector

var timesdone = 0

func _on_body_entered(body: CharacterBody2D) -> void:
	if Game.switching:
		return
	if body.name == "Link" and timesdone != 0:
		var target_coords = self.global_position
		if target_coords != camera.global_position:
			Game.switching = true
		if camera != null:
			var tween = create_tween()
			tween.set_parallel(true)
			
			var direction: Vector2 = (target_coords - body.position).normalized()
			#Q1
			if direction.y > 0.707:
				tween.tween_property(body, "global_position", body.global_position + Vector2(0, 64), 1.0) 
			elif direction.y < -0.707:
				tween.tween_property(body, "global_position", body.global_position + Vector2(0, -64), 1.0) 
			elif direction.x > 0.707:
				tween.tween_property(body, "global_position", body.global_position + Vector2(64, 0), 1.0) 
			elif direction.x < -0.707:
				tween.tween_property(body, "global_position", body.global_position + Vector2(-64, 0), 1.0) 
			
			
			tween.tween_property(camera, "global_position", target_coords, 1.0) 
			
			
			await tween.finished
			Game.switching = false
	else:
		timesdone += 1
		return

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
