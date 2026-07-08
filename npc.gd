extends CharacterBody2D
@onready var dialogue_box = $Sprite2D2
@onready var dialogue_text = $Sprite2D2/Label

var dialogue = [["Hey Husband!\nHappy Anniversary!", "Our life has been \nso happy together here.", "I can't help but think,\nthough...", "All of our neighbors have those \nnew Apple computers shipped \nfrom the mainland.","Could you pretty please go and \nfetch me one?","I love you! ;3"],["I wish I had a computer...","Oh, hi again."],["WOW! Thanks hubby!! <3"]]
var dialogue_active = false
var dialogue_message = 0
var dialogue_stage = 0

var in_zone = false

var direction = 1
var SPEED = 25

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if in_zone != true:
		if position.y <= 227:
			direction *= -1
		if position.y >= 355:
			direction *= -1
		velocity = Vector2(0, direction*SPEED)
	else:
		velocity.y = 0
		
	velocity.x = 0
			
	if in_zone and Input.is_action_just_pressed('interact'):
		$Label.hide()
		$Sprite2D3.hide()
		if dialogue_active != true:
			dialogue_active = true
			dialogue_box.show()
			dialogue_text.show()
			update_dialogue()
		elif dialogue_message < dialogue[dialogue_stage].size() - 1:
			dialogue_message += 1
			update_dialogue()
		else:
			dialogue_active = false
			dialogue_message = 0
			if dialogue_stage == 0:
				dialogue_stage += 1
			
			
	if dialogue_active == false:
		dialogue_box.hide()
		dialogue_text.hide()
		
	if !in_zone: #Prevents Link from being able to move it
		move_and_slide()

func update_dialogue():
	dialogue_text.text = dialogue[dialogue_stage][dialogue_message]

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body.name == "Link":
			in_zone = true
			$Label.show()
			$Sprite2D3.show()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D and body.name == "Link":
		in_zone = false
		dialogue_active = false
		$Label.hide()
		$Sprite2D3.hide()
