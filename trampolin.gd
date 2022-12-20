extends KinematicBody2D

var lompat = false

func _on_atas_body_entered(body):
	$AnimatedSprite.play("samping")
	if body.name == "Hero":
		body.kecepatan.y = -500

func _physics_process(delta):
	if lompat == true:
		$AnimatedSprite.play("samping", load("samping"))
		
