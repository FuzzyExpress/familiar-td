extends CharacterBody3D

#@onready var Turret = $"../Ship Test"

@export var speed := 400.0
@export var acceleration := 0.0

var HP : float = 100
var ting : int = 0;

@onready var MeshI : MeshInstance3D = $Bad/Cube

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
		

func _process(_delta : float):
	pass
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if true: # hit
		HP -= 10
		ting = 10;
	
	if ting != 0:
		ting -= 1;
		
	MeshI.get_surface_override_material(3).set_shader_parameter("ting", ting/10)
	MeshI.get_surface_override_material(0).set_shader_parameter("dmg_fac", Globals.remap(0, 50, 0, 1, HP))

	# Code to execute in game.
	speed += acceleration * delta
	velocity.z = -speed * delta
	move_and_slide()
