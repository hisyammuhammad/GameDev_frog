extends Area2D





func _on_checkpoint_body_entered(body):
	if body.name == 'Hero':
		get_tree().change_scene("res://level2.tscn")
