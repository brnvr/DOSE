varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 scale;
uniform float saturation;
uniform vec3 shadow_color;
uniform vec2 tracking_error_distance;
uniform vec2 tracking_error_variation;
uniform float tracking_error_alpha;
uniform sampler2D tracking_lines;
uniform vec3 palette[64];
uniform sampler2D wave_gradient;
uniform float wave_amount;
uniform float wave_offset;
uniform sampler2D dither_map;
uniform vec2 screen_size;
uniform float blur_radius;
uniform float blur_intensity;

vec4 apply_shadow_color(vec4 color, vec3 shadow_color) {
	vec4 color1 = vec4(vec3(color) + shadow_color, color.a);
	
	return vec4(max(color1.r, shadow_color.r), max(color1.g, shadow_color.g), max(color1.b, shadow_color.b), 1.0);
}

vec4 apply_saturation(vec4 color, float value) {
	float mean;
	vec3 grayscale, delta;
	
	grayscale = vec3((color.r+color.g+color.b)/3.0);
	delta = color.rgb - grayscale;
	
	return vec4(grayscale + delta*value, color.a);
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

vec4 apply_dithering(vec4 color, vec2 texcoord, vec2 screen_size) {
	vec2 pixel_scale = vec2(2, 2);
	
    texcoord.x *= screen_size.x / 128.0 /  pixel_scale.x;
    texcoord.y *= screen_size.y / 128.0 /  pixel_scale.y;
    
    float ditherValue = 2.0 * texture2D(dither_map, texcoord).r - 1.0;
	
	float gamma = 1.2;
	float dspread = 20.0;
    color.rgb = pow(color.rgb, vec3(1.0/gamma));
    color += ditherValue/dspread;
    color = clamp(color,0.001,0.999);
	
	return color;
}

vec4 apply_gaussian_blur(sampler2D base_texture, vec2 texcoord, vec2 tex_size, float blur_radius, float intensity) {
    vec4 color = texture2D(base_texture, texcoord);
    
    float kernel[5];
	
    kernel[0] = 0.06136 * intensity;
    kernel[1] = 0.24477 * intensity;
    kernel[2] = 0.38774 * intensity;
    kernel[3] = 0.24477 * intensity;
    kernel[4] = 0.06136 * intensity;
	
    vec2 tex_offset = blur_radius / tex_size;

    vec4 result = color * kernel[2];

    for (int i = 1; i < 3; i++) {
        result += texture2D(base_texture, texcoord + vec2(tex_offset.x * float(i), 0.0)) * kernel[2 + i];
        result += texture2D(base_texture, texcoord - vec2(tex_offset.x * float(i), 0.0)) * kernel[2 + i];

        result += texture2D(base_texture, texcoord + vec2(0.0, tex_offset.y * float(i))) * kernel[2 + i];
        result += texture2D(base_texture, texcoord - vec2(0.0, tex_offset.y * float(i))) * kernel[2 + i];
    }

    return result;
}

void main()
{
	vec2 texOffset0 = vec2(1.0) + (tracking_error_distance + tracking_error_variation) * .1;
	vec2 texOffset1 = vec2(1.0) - (tracking_error_distance + tracking_error_variation) * .1;
	
	vec4 tracking_lines_color = texture2D(tracking_lines, v_vTexcoord + tracking_error_variation * 2.0 );
	vec2 texcoord = vec2(v_vTexcoord.x + tracking_lines_color.r*.0075, v_vTexcoord.y);
	
	if (wave_amount > 0.0) {
		vec4 wave_color = texture2D(wave_gradient, vec2(0.0, v_vTexcoord.y / 2.0 + wave_offset));
		
		texcoord = texcoord + vec2(wave_color.r * wave_amount, 0.0);
	}
	
	texcoord = (texcoord - 0.5) / scale + 0.5;
	
	vec4 color0;
	
	if (blur_radius != 0.0 && blur_intensity != 0.0) {
		color0 = apply_gaussian_blur(gm_BaseTexture, texcoord, vec2(512, 512), blur_radius, blur_intensity);	
	} else {
		color0 = texture2D(gm_BaseTexture, texcoord);
	}
	
	vec4 color1 = texture2D(gm_BaseTexture, texcoord * texOffset0);
	vec4 color2 = texture2D(gm_BaseTexture, texcoord * texOffset1);
	
	vec4 color = (color0 - (color1 - color2) * tracking_error_alpha) * v_vColour;
	color = color + vec4(0.0, tracking_lines_color.r*.1, tracking_lines_color.r*.2, 0.0);
	
	color = apply_dithering(color, texcoord, screen_size);
	color = apply_shadow_color(color, shadow_color);
	color = apply_saturation(color, saturation);
	color = apply_palette(color, palette);

    gl_FragColor = color;
}