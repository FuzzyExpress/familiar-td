shader_type spatial;
render_mode unshaded, cull_disabled; // , world_vertex_coords;

uniform float shield_str : hint_range(0., 1.) = 1;
uniform float ting : hint_range(0., 1.) = 1;
uniform vec3 color : source_color = vec3(0.0, 1., 0.4);

#include "res://Shaders/Shield.gdshaderinc"

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if ( FRONT_FACING ) {
		ALBEDO = mix( color, vec3(1.), ting * .5 );
		ALPHA  = ( shield_str * (ting*5. + 1.) );
	} else {
		ALBEDO = mix( color, vec3(1.), ting * .5 );
		ALPHA  = shield(4.0, NORMAL, VIEW) * ( shield_str * (ting*5. + 1.) );
	}
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
