varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float saturation;
uniform float color_range;
uniform float pixel_size;
uniform vec2 texture_dimentions;
uniform vec3 shadow_color;

vec4 set_saturation(vec4 color, float value) {
	float mean;
	vec3 grayscale, delta;
	
	grayscale = vec3((color.r+color.g+color.b)/3.0);
	delta = color.rgb - grayscale;
	
	return vec4(grayscale + delta*value, color.a);
}

vec4 set_shadow_color(vec4 color, vec3 shadow_color) {
	vec4 color1 = vec4(vec3(color) + shadow_color, color.a);
	
	return vec4(max(color1.r, shadow_color.r), max(color1.g, shadow_color.g), max(color1.b, shadow_color.b), 1.0);
}

vec4 get_nearest_color_range(vec4 color, float n_levels, vec3 shadow_color) {
	float range, alpha;
	
	range = 1.0/n_levels;
	alpha = color.a > 1.0-range ? 1.0 : color.a - mod(color.a, range);
	
	return vec4(color.rgb - mod(color.rgb, range), alpha);
}


vec4 get_frag_color(sampler2D texture, vec2 texcoord, float pixel_size) {
	if (pixel_size <= 1.0) {
		return texture2D(texture, texcoord);	
	}
	
	float xpixel, ypixel;
	vec2 new_pixcoord, new_texcoord;
	
	xpixel = floor(texture_dimentions.x * texcoord.x);
	ypixel = floor(texture_dimentions.y * texcoord.y);
	
	new_pixcoord.x = xpixel - mod(xpixel, pixel_size);
	new_pixcoord.y = ypixel - mod(ypixel, pixel_size);
	
	new_texcoord.x = new_pixcoord.x / texture_dimentions.x;
	new_texcoord.y = new_pixcoord.y / texture_dimentions.y;
	
	return texture2D(texture, new_texcoord);	
}

void main()
{	
	vec4 color = get_frag_color( gm_BaseTexture, v_vTexcoord, pixel_size);
	
	if (color_range != 0.0) {
		color = get_nearest_color_range(color, color_range, shadow_color);
	}
	
	if (shadow_color != vec3(0.0, 0.0, 0.0)) {
		color = set_shadow_color(color, shadow_color);	
	}
	
	if (saturation != 1.0) {
		color = set_saturation(color, saturation);
	}
	
    gl_FragColor = color;
	if (gl_FragColor.a == 0.0) discard;
}
