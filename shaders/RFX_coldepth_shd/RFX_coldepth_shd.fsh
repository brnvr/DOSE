varying vec2 v_texcoord;
varying vec4 v_color;

varying vec4 projection_plane;

uniform sampler2D s_lutmap;
uniform sampler2D s_dithmap;

uniform vec2 PixelScale;
uniform vec2 screensize;
uniform float dspread;
uniform float cdepth;

uniform float u_Gamma;
uniform float u_SSAA;

void main()
{
    //vec4 t_color;
	//vec2 rounder = screensize / PixelScale;
    //t_color = texture2D(gm_BaseTexture, floor( v_texcoord * rounder) / rounder);
	
	vec4 t_color;
	vec2 rounder = screensize / PixelScale;
	vec4 avgColor = vec4(0.0);

	// Define the number of samples for antialiasing (4 samples in this case)
	int numSamples = 4;

	if ( u_SSAA == 0.0 ){
		numSamples = 1;
	}

	//if ( u_SSAA > 0.0 ){
		for (int i = 0; i < numSamples; i++) {
		    for (int j = 0; j < numSamples; j++) {
		        // Offset the texture coordinate to sample neighboring pixels
		        vec2 offset = vec2(float(i) - float(numSamples - 1) * 0.5, float(j) - float(numSamples - 1) * 0.5) / rounder;
		        avgColor += texture2D(gm_BaseTexture, (floor(v_texcoord * rounder) + offset * u_SSAA ) / rounder );
		    }
		}
	//}

	// Calculate the average color and divide by the number of samples
	avgColor /= float(numSamples * numSamples);

	t_color = avgColor;
	
    vec3 o_color = t_color.rgb;
    vec2 dCoord = v_texcoord;
	
    dCoord.x *= screensize.x/128.0/PixelScale.x;
    dCoord.y *= screensize.y/128.0/PixelScale.y;
	
	float gamma = u_Gamma;
    t_color.rgb = pow(t_color.rgb, vec3(1.0/gamma));
    
    float ditherValue = 2.0 * texture2D(s_dithmap, dCoord).r - 1.0;
    t_color.rgb += ditherValue/dspread;
    
    //t_color.r = floor(t_color.r*cdepth)*cdepth;
    
    // Final color 
    t_color.rgb = floor(t_color.rgb*cdepth+0.5)/cdepth;
   
    gl_FragColor = t_color;
}
