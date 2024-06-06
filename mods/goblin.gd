extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var chase = false 
var speed = 100
@onready var anim = $AnimatedSprite2D
var alive = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	var loki = $"../../Loki/Loki"
	var direction = (loki.position - self.position).normalized()
	if alive == true:
		if chase == true:
			velocity.x = direction.x * speed
			anim.play("run")
		else:
			velocity.x = 0
			anim.play("idle")
		if direction.x < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	
	move_and_slide()

func _on_detector_body_entered(body):
	if body.name == "Loki":
		chase = true
	
func _on_detector_body_exited(body):
	if body.name == "Loki":
		chase = false
	

func _on_death_body_entered(body):
	if body.name == "Loki":
		body.velocity.y -= 300
		death()

func _on_death_2_body_entered(body):
	if body.name == "Loki":
		if alive == true:
			body.health -= 20
		death()


func death():
	alive = false
	anim.play("death")
	await anim.animation_finished
	queue_free()



	
