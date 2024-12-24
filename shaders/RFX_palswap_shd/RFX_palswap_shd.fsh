varying vec2 v_texcoord;
varying vec4 v_color;

varying vec4 projection_plane;

uniform sampler2D s_lutmap;
uniform sampler2D s_dithmap;

uniform vec2 PixelScale;
uniform vec2 screensize;
uniform float dspread;

uniform float u_Gamma;
uniform float u_SSAA;
uniform bool u_NoMask;

vec3 sample3DTexture(sampler2D texture, vec3 color, float width) {
    
    float lutSize = sqrt(width); //size of grid, e.g. 8x8
	
    float sliceSize = 1.0 / lutSize; //size of slice (0.0 - 1.0)
	
    float PixelSize = sliceSize / width; // space of 1 pixel
	
    float sliceInnerSize = PixelSize * (width - 1.0);  // space of width pixels
	
    color = clamp(color,0.001,0.999);
	
    float p_x = color.r / width; //r value position
    float p_y = floor( color.g * width ) / width; //g value position
    p_x += floor( color.b * width ) / width; //b value position
    
    vec3 result = texture2D( texture, vec2( p_x, p_y ) ).rgb; //get the new color from the LUT Texture
	
    return result;
}

void main()
{
	//vec2 rounder = screensize / PixelScale;
    //vec4 oCol = texture2D(gm_BaseTexture, floor( v_texcoord * rounder) / rounder);
	//vec3 t_color;
    //t_color = oCol.rgb;
	
	
	vec4 oCol;
	vec2 rounder = screensize / PixelScale;
	vec4 avgColor = vec4(0.0);

	// Define the number of samples for antialiasing (4 samples in this case)
	int numSamples = 4;

	if ( u_SSAA == 0.0 ){
		numSamples = 1;
	}
		for (int i = 0; i < numSamples; i++) {
		    for (int j = 0; j < numSamples; j++) {
		        // Offset the texture coordinate to sample neighboring pixels
		        vec2 offset = vec2(float(i) - float(numSamples - 1) * 0.5, float(j) - float(numSamples - 1) * 0.5) / rounder;
				vec2 UV = (floor(v_texcoord * rounder) + offset * u_SSAA ) / rounder;
				UV = clamp(UV,0.0,1.0);
		        avgColor += texture2D(gm_BaseTexture, UV);
				if ( i == 0 && j == 0 ){
					oCol.a = avgColor.a;
				}
		    }
		}
	//}

	// Calculate the average color and divide by the number of samples
	avgColor /= float(numSamples * numSamples);
	
	oCol.rgb = avgColor.rgb;
	
	vec3 t_color;
    t_color = oCol.rgb;
    vec3 o_color = t_color;
    vec2 dCoord = v_texcoord;
    dCoord.x *= screensize.x / 128.0 / PixelScale.x;
    dCoord.y *= screensize.y / 128.0 / PixelScale.y;
    
    float ditherValue = 2.0 * texture2D(s_dithmap, dCoord).r - 1.0;
	
	float gamma = u_Gamma;
    t_color.rgb = pow(t_color.rgb, vec3(1.0/gamma));
    t_color += ditherValue/dspread;
    t_color = clamp(t_color,0.001,0.999);
    
    // Final color 
    vec3 t_col = sample3DTexture(s_lutmap, t_color, 16.0);
	
    gl_FragColor = vec4(t_col.rgb,1.0);
	if (u_NoMask == true){
		gl_FragColor.a = 1.0;
	}
}
