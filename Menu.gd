extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_StartButton_pressed():
	get_tree().change_scene("res://Level.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()



func _on_Button_pressed():
	get_tree().change_scene("res://Level1.tscn")


func _on_Button2_pressed():
	get_tree().change_scene("res://Level2.tscn")


func _on_Button3_pressed():
	get_tree().change_scene("res://Level.tscn")


func _on_Button4_pressed():
	get_tree().change_scene("res://Menu.tscn")
