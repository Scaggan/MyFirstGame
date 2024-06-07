extends CharacterBody2D

enum {
	person,
	mob, 
	enemy,
}

var SPEED := 200.0
var TP := 5
const JUMP_VELOCITY = -400.0
var repeat := 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $first

var health = 20

func _ready():
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		

	# Handle jump.
	if Input.is_action_just_pressed("w") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("Jump")
		
	if Input.is_action_just_pressed("shift"):
		if TP <= 0:
			return
		SPEED = 1500
		TP -= 1
	else:
		SPEED = 200

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("a", "d")
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("idle")
	
	if direction == -1:
		anim.flip_h = true
	elif  direction == 1:
		anim.flip_h = false
	
	if velocity.y > 0:
		anim.play("fall")
	end()
	dead(health)

	move_and_slide()

func dead(hp):
	if hp <= 0:
		print(repeat)
		repeat -= 1 
		queue_free()
		get_tree().reload_current_scene()
		

func end():
	if repeat <= 0:
		get_tree().quit()
		return


func _on_target_body_entered(body):
	if body.name == "Loki":
		get_tree().reload_current_scene()
