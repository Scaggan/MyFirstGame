extends CanvasLayer

@onready var HP := $Label
@onready var TP := $Label2
@onready var Person := $"../Loki/Loki"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		HP.text = "HP: " + str(Person.health)
		TP.text = "TP:" + str(Person.TP)
