@tool # Needed so it runs in editor.
extends EditorScenePostImport

func _post_import(scene):
	# Change all node names to "modified_[oldnodename]"
	
	iterate(scene)
	return scene

func iterate(scene):
	for child in scene.get_children():
		iterate(child)
	
	var node : MeshInstance3D
	
	if scene is MeshInstance3D:
		node = scene
	else:
		return scene
		
	if scene != null:
		match node.name:
			"Scout":
				node.mesh.surface_set_material(0, load("res://Materials/Ship Frame.tres"))
				node.mesh.surface_set_material(1, load("res://Materials/Ship Frame.tres"))
				node.mesh.surface_set_material(2, load("res://Materials/Shield Bubble.tres"))
					
					
					
					
					
	
	return scene # Remember to return the imported scene
