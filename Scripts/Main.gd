extends Node3D

@onready var pointer : RayCast3D = $CursorCast3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	
	var mouse_position = get_viewport().get_mouse_position()

	pointer.global_position = $Camera3D.project_ray_origin(mouse_position)

	pointer.target_position = pointer.global_position + $Camera3D.project_ray_normal(mouse_position) * 2000
	
	$Tracker3D.global_position = pointer.get_collision_point()
