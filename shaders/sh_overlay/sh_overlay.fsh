varying vec2 v_vTexcoord;
varying vec4 v_vColour;

vec4 get_nearest_color_range(vec4 color, float n_levels) {
	float range;
	
	range = 1.0/n_levels;
	
	return vec4(color.rgb - mod(color.rgb, range), color.a);
}

void main()
{
	float mColour;
	vec4 colour;
	
	colour = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	mColour = (colour.r+colour.g+colour.b)/3.0;
	
	gl_FragColor = get_nearest_color_range(vec4(vec3(colour), mColour*colour.a), 5.0);
	gl_FragColor = vec4(vec3(colour), mColour*colour.a);
	
	if (gl_FragColor.a == 0.0) discard;
}
