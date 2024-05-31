varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float saturation;
uniform float color_levels;
uniform float pixel_size;
uniform vec2 texture_dimentions;

vec4 set_saturation(vec4 color, float value) {
	float mean;
	vec3 grayscale, delta;
	
	grayscale = vec3((color.r+color.g+color.b)/3.0);
	delta = color.rgb - grayscale;
	
	return vec4(grayscale + delta*value, color.a);
}

vec4 get_nearest_color_range(vec4 color, float n_levels) {
	float range;
	
	range = 1.0/n_levels;
	
	return vec4(color.rgb - mod(color.rgb, range), color.a);
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
    gl_FragColor = get_nearest_color_range(set_saturation(get_frag_color( gm_BaseTexture, v_vTexcoord, pixel_size ), saturation), color_levels);
	if (gl_FragColor.a == 0.0) discard;
}
