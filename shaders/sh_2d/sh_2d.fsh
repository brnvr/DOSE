varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float saturation;
uniform float color_range;
uniform float pixel_size;
uniform sampler2D dither_map;
uniform vec2 texture_dimentions;
uniform vec3 palette[64];

vec4 apply_saturation(vec4 color, float value) {
	float mean;
	vec3 grayscale, delta;
	
	grayscale = vec3((color.r+color.g+color.b)/3.0);
	delta = color.rgb - grayscale;
	
	return vec4(grayscale + delta*value, color.a);
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

vec4 apply_dithering(vec4 color) {
    vec2 screensize = vec2(960, 540); // Replace with actual screen resolution
    vec2 PixelScale = vec2(2, 2);
    
    // Use gl_FragCoord.xy for screen-space coordinates
    vec2 texcoord = gl_FragCoord.xy / screensize;
    texcoord.x *= screensize.x / 128.0 / PixelScale.x;
    texcoord.y *= screensize.y / 128.0 / PixelScale.y;
    
    float ditherValue = 2.0 * texture2D(dither_map, texcoord).r - 1.0;
    
    float gamma = 1.2;
    float dspread = 20.0;
    color.rgb = pow(color.rgb, vec3(1.0 / gamma));
    color += ditherValue / dspread;
    color = clamp(color, 0.001, 0.999);
    
    return color;
}
vec4 apply_palette(vec4 ref_color, vec3 palette[64]) {
    float min_distance = 1e10;
    vec3 closest_color = vec3(0.0);

    for (int i = 0; i < 64; i++) {
        float distance = dot(ref_color.xyz - palette[i], ref_color.xyz - palette[i]);

        if (distance < min_distance) {
            min_distance = distance;
            closest_color = palette[i];
        }
    }

    return vec4(closest_color.xyz, ref_color.a);
}


void main()
{	
	vec4 color = get_frag_color(gm_BaseTexture, v_vTexcoord, pixel_size);
	
	color = apply_dithering(color);
	
	if (saturation != 1.0) {
		color = apply_saturation(color, saturation);
	}
	
	color = apply_palette(color, palette);
	
    gl_FragColor = color;
	if (gl_FragColor.a == 0.0) discard;
}
