extends CharacterBody2D

@onready var stateCats := [$first,$secend,$three,$four]
var SPEED = 200.0
const JUMP_VELOCITY = -430
var TP := 100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var health = 0
@onready var anim = stateCats[health]

@onready var cat := $three

func _ready():
	anim.visible = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("shift"):
		if TP <= 0:
			return
		SPEED = 1500
		TP -= 1
	else:
		SPEED = 200
		

	# Handle jump.
	if Input.is_action_just_pressed("w") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("Jump")

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
		
	match health:
		1:
			stateCats[0].visible = false
			anim = stateCats[1]
			anim.visible = true
		2:
			stateCats[1].visible = false
			anim = stateCats[2]
			anim.visible = true
		3:
			stateCats[2].visible = false
			anim = stateCats[3]
			anim.visible = true
		4:
			get_tree().quit()
			
	move_and_slide()
