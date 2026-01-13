extends CharacterBody3D

#@onready var Turret = $"../Ship Test"

@export var speed := 400.0
@export var acceleration := 0.0

@onready var MeshI : MeshInstance3D = find_child('Scout')


var HP : float = 100
var ting : int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta : float):
	pass


func _hit():
	HP -= 10
	ting = 10;

func _physics_process(delta: float) -> void:
	# TODO add once scaning added
	#if HP <= 0: queue_free()
	if ting > 0:
		ting -= 1;
		
	MeshI.set_instance_shader_parameter("dmg_fac", Globals.remap(0, 100, 0, 1, HP))

	# Code to execute in game.
	speed += acceleration * delta
	velocity.z = -speed * delta
	move_and_slide()
