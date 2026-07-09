extends Node

var scene = [0, 0]
var collected = false
var switching = false
var win = false
var lives = 3

func _process(delta) -> void:
	if lives <= 0:
		game_over()
		lives = 3

func reset_game() -> void:
	scene = [0, 0]

func game_over():
	get_tree().change_scene_to_file("res://lose_2.tscn")

func over():
	get_tree().change_scene_to_file("res://win.tscn")
