extends KinematicBody2D

var Dash = 400
var normal = 100
var gerak = normal
var kecepatan =Vector2.ZERO
var gerak_lompat = -340
var gravitasi = 12 
var koin = 0
var buah = 0
var sedang_terluka = false
var health_max = 200 
var health = 200

onready var sprite = $Sprite

signal hero_apdet_health(value)
signal hero_apdet_koin(value)
signal hero_apdet_buah(value)

func _physics_process(delta):
	kecepatan.y = kecepatan.y + gravitasi
	
	if(not sedang_terluka and Input.is_action_pressed("gerak_kanan")):
		kecepatan.x = gerak
	if(not sedang_terluka and Input.is_action_pressed("gerak_kiri")):
		kecepatan.x = -gerak
	
	if (not sedang_terluka and Input.is_action_just_pressed("Dash")):
		Dash()
	
	if(not sedang_terluka and Input.is_action_pressed("lompat") and is_on_floor()):
		kecepatan.y = gerak_lompat
	
	
	
	kecepatan.x = lerp(kecepatan.x, 0, 0.2)
	kecepatan = move_and_slide(kecepatan, Vector2.UP)
	
	if not sedang_terluka:
		update_animasi()

func update_animasi():
	if is_on_floor():
		if kecepatan.x < (gerak * 0.5) and kecepatan.x > (-gerak * 0.5):
			sprite.play("Diam")
		else:
			if gerak == normal:
				sprite.play("Lari")
			elif gerak == Dash:
				sprite.play("Dash")
	else:
		if kecepatan.y > 0:
			#jatuh
			sprite.play("Jatuh")
		else:
			#lompat
			sprite.play("Lompat")
	
	sprite.flip_h = false
	if kecepatan.x < 0:
		sprite.flip_h = true


func Dash():
	gerak = Dash
	$Timer.start()

func _on_Timer_timeout():
	gerak = normal
	

func ambil_koin():
	koin = koin + 1
#	print(" KOIN: ", koin)
	emit_signal("hero_apdet_koin", koin)
	
func ambil_buah():
	buah = buah + 1
	print(" Buah: ", buah)
	emit_signal("hero_apdet_buah", buah)

func terluka():
	sedang_terluka = true
	
	health -= 50
	emit_signal("hero_apdet_health", (float(health)/float(health_max)) * 100)
	
	if kecepatan.x > 0:
		kecepatan.x = -500
	else: 
		kecepatan.x = 500
	
	sprite.play("Hit")
	yield(get_tree().create_timer(1), "timeout")
	
	if health <= 0:
		mati()
	else:
		sedang_terluka = false
		
	

func mati():
	sprite.play("mati")
	set_collision_layer_bit(0, false)
	set_collision_mask_bit(2, false)
	yield(get_tree().create_timer(1), "timeout")
	get_parent().emit_signal("hero_mati")
	get_tree().change_scene("res://option.tscn")
