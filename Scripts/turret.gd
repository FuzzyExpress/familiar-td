extends Node3D

@onready var Yaw	 = $"LT Base/LT Yaw"
@onready var Pitch	 = $"LT Base/LT Yaw/LT Pitch"
#@onready var Head	 = $"LT Base/LT Yaw/LT Pitch"
@onready var Emitter = $"LT Base/LT Yaw/LT Pitch/LT Emitter"

#@onready var Target	= $"../Bad"
@onready var Target	= $"../../Scout2"

var CDown : float = 0
var CoolingTime : float = 0.25


var Projectile = preload("res://Scenes/Laser Projectile 3D.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	#for sample in [0, 1]:
	if true:
		var t = Globals.get_intercept( Emitter.global_position, 20, Target.global_position, Target.velocity )
		# Ratate base
		Yaw.look_at(t, Vector3(0,1,0))
		Yaw.rotation.x = 0
		Yaw.rotation.z = 0
		
		# Rotate turret head
		Pitch.look_at(t, Vector3(0,1,0))
		Pitch.rotation.y = 0
		Pitch.rotation.z = 0
		
		$"../../Target3D".global_position = t
		
	
	
	
	
	if CDown <= 0:
		CDown = CoolingTime
		
		var projectile : Node3D = Projectile.instantiate()
		$"..".add_child(projectile)
		projectile.global_transform = Emitter.global_transform
		
	else:
		CDown -= _delta;
		
	#Head.position.z = Globals.remap( 0, CoolingTime, 0, 0.289, CDown )
	
	#Z.look_at(Target.global_position, Vector3(0, 1, 0))
	#Y.look_at(Target.global_position, Vector3(0, 1, 0))
