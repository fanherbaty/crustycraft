shader_type canvas_item;
render_mode blend_mix;

uniform float radius = 1.0;
uniform vec4 modulate : source_color;

void fragment() {
	vec2 ps = TEXTURE_PIXEL_SIZE;

	vec4 shadow = texture(TEXTURE, UV + vec2(-radius, -radius) * ps);
	shadow *= modulate;

	vec4 col = texture(TEXTURE, UV);
	COLOR = mix(shadow, col, col.a);
}