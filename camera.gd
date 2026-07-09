extends Camera2D

@export var zelda: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Game.win == true:
		var tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(self, "position", zelda.position + Vector2(80, -64), 0.5)
		tween.tween_property(self, "zoom", Vector2(2,2), 0.5) 
		await get_tree().create_timer(4.0).timeout
		Game.over()
