varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	float mColour;
	vec4 colour;
	
	colour = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	mColour = (colour.r+colour.g+colour.b)/3.0;
	
	gl_FragColor = vec4(vec3(colour), mColour*colour.a);
	
	if (gl_FragColor.a == 0.0) discard;
}
