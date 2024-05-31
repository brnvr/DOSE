varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float saturation;
uniform vec3 shadow_color;
uniform vec2 tracking_error_distance;
uniform vec2 tracking_error_variation;
uniform float tracking_error_alpha;
uniform sampler2D tracking_lines;

vec4 set_shadow_color(vec4 color, vec3 shadow_color) {
	vec4 color1 = vec4(vec3(color) + shadow_color, color.a);
	
	return vec4(max(color1.r, shadow_color.r), max(color1.g, shadow_color.g), max(color1.b, shadow_color.b), 1.0);
}

vec4 set_saturation(vec4 color, float value) {
	float mean;
	vec3 grayscale, delta;
	
	grayscale = vec3((color.r+color.g+color.b)/3.0);
	delta = color.rgb - grayscale;
	
	return vec4(grayscale + delta*value, color.a);
}

vec4 get_nearest_color_range(vec4 color, float n_levels, vec3 shadow_color) {
	float range, alpha;
	
	range = 1.0/n_levels;
	alpha = color.a > 1.0-range ? 1.0 : color.a - mod(color.a, range);
	
	return vec4(color.rgb - mod(color.rgb, range), alpha);
}

void main()
{
	vec2 texOffset0 = vec2(1.0) + (tracking_error_distance + tracking_error_variation) * .1;
	vec2 texOffset1 = vec2(1.0) - (tracking_error_distance + tracking_error_variation) * .1;
	
	vec4 tracking_lines_color = texture2D( tracking_lines, v_vTexcoord + tracking_error_variation * 2.0 );
	vec2 texcoord = vec2(v_vTexcoord.x + tracking_lines_color.r*.0075, v_vTexcoord.y);
	
	vec4 color0 = texture2D( gm_BaseTexture, texcoord );
	vec4 color1 = texture2D( gm_BaseTexture, texcoord * texOffset0 );
	vec4 color2 = texture2D( gm_BaseTexture, texcoord * texOffset1 );
	
	vec4 color = (color0 - (color1 - color2) * tracking_error_alpha) * v_vColour;
	color = color + vec4(0.0, tracking_lines_color.r*.1, tracking_lines_color.r*.2, 0.0);
	
	color = get_nearest_color_range(color, 5.0, shadow_color);
	
	color = set_shadow_color(color, shadow_color);
	
	if (saturation != 1.0) {
		color = set_saturation(color, saturation);
	}
	
    gl_FragColor = color;
}