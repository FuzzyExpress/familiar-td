extends CharacterBody3D

@onready var Turret = $"../Ship Test"

@export var speed := 400.0
@export var move_x := false
@export var acceleration := 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#self.look_at(Turret.global_position)
	
	#self.rotation.y += 0.1 / -40
	
		# Accelerate
	speed += acceleration * delta
	if move_x:
		velocity.x = -speed * delta
	else:
		velocity.z = -speed * delta
	move_and_slide()
	#global_position += Vector3(0.0,0.0,1.0) * delta
