shader_type canvas_item;

uniform bool show_stripes = true;

uniform vec4 input_color1 : source_color;
uniform vec4 output_color1 : source_color;

uniform vec4 input_color2 : source_color;
uniform vec4 output_color2 : source_color;

uniform vec4 input_color3 : source_color;
uniform vec4 output_color3 : source_color;

uniform vec4 input_color4 : source_color;
uniform vec4 output_color4 : source_color;

uniform vec4 input_color5 : source_color;
uniform vec4 output_color5 : source_color;

uniform vec4 input_color6 : source_color;
uniform vec4 output_color6 : source_color;

uniform vec4 input_color7 : source_color;
uniform vec4 output_color7 : source_color;

uniform vec4 input_color8 : source_color;
uniform vec4 output_color8 : source_color;

vec4 grayscale(vec4 color){
	float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
	return vec4(gray, gray, gray, color.a);
}

vec4 stripe(vec2 uv, vec4 color){
	float w = cos(0.7854) * uv.x + sin(0.7854) * uv.y - 0.05 * TIME;
	if (floor(mod(w * 48.0, 2.0)) < 0.0001) {
		return color;
	}
	else {
		return grayscale(color);
	}
}

void fragment(){
	vec4[] input_colors = {
		input_color1,
		input_color2,
		input_color3,
		input_color4,
		input_color5,
		input_color6,
		input_color7,
		input_color8
	};
	
	vec4[] output_colors = {
		output_color1,
		output_color2,
		output_color3,
		output_color4,
		output_color5,
		output_color6,
		output_color7,
		output_color8
	};
	
	vec4 current_color = texture(TEXTURE, UV);
	
	bool is_color = false;
	
	for(int cr = 0; cr < input_colors.length(); cr++){
		if (current_color == input_colors[cr]){
			COLOR = output_colors[cr];
			is_color = true;
			break;
		}
	}
	
	if (!is_color){
		if (show_stripes && !(current_color.a < 0.001)){
			COLOR = stripe(SCREEN_UV, current_color);
		} else{
			COLOR = current_color;
		}
	}
}