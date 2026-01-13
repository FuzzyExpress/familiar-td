// NOTE: Shader automatically converted from Godot Engine 4.5.1.stable's StandardMaterial3D.

shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_burley, specular_schlick_ggx;

uniform vec4 albedo : source_color;

uniform float roughness : hint_range(0.0, 1.0);

uniform float specular : hint_range(0.0, 1.0, 0.01);
uniform float metallic : hint_range(0.0, 1.0, 0.01);

instance uniform float dmg_fac : hint_range(0., 1.) = 1;

uniform sampler2D nTexture;
uniform sampler2D normTexture;


#include "res://Shaders/fBM Noise.gdshaderinc"
#include "res://Shaders/Remap.gdshaderinc"

#define DIFFUSE_BURLEY
#define SPECULAR_SCHLICK_GGX
#include "res://Shaders/standard_lighting.gdshaderinc"

//void vertex() {
	//UV = UV * uv1_scale.xy + uv1_offset.xy;
//}

void light()
{
	STANDARD_LIGHTING(DIFFUSE_LIGHT, SPECULAR_LIGHT);
}

void fragment() {
	vec2 iUV = - UV + vec2(1.);

	ALBEDO = albedo.rgb;

	float noise = texture(nTexture, UV).r;
	float noise2 = texture(nTexture, iUV).r;

	float dmg = remap(0.0, 1, 1, 0, noise);
	float swt = float(dmg > dmg_fac);
	ALBEDO = mix(albedo.rgb, vec3(.4), swt );

	METALLIC = metallic;
	SPECULAR = specular;


	vec4 roughness_texture_channel = vec4(1.0, 0.0, 0.0, 0.0);
	ROUGHNESS = mix(roughness, mix(0.4, 0.7, dmg), float(dmg > dmg_fac) );
	//NORMAL = mix(NORMAL, NORMAL + texture(normTexture, iUV).rgb, swt);
	//ALBEDO = NORMAL;


}
