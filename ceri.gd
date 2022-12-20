extends Area2D

func _on_ceri_body_entered(body):
	if body.name == 'Hero' :
		body.ambil_buah()
	var _efekbuah = preload("res://efekbuah.tscn")
	var efekbuah = _efekbuah.instance()
	efekbuah.transform = self.transform
	get_tree().current_scene.add_child(efekbuah)
	queue_free()
