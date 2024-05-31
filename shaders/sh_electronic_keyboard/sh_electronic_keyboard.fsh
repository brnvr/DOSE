varying vec3 v_vNormal;
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;
varying mat4 v_vMatrixWorld;

uniform vec3 light_direction;
uniform vec3 light_hue;
uniform vec3 camera_position;
uniform float fog_start;
uniform float fog_end;
uniform vec3 fog_color;
uniform bool lighting_enabled;
uniform bool fog_enabled;
uniform float alpha;
uniform float color_levels;
uniform vec3 shadow_color;
uniform float key;
uniform bool highlight_key;
uniform vec4 highlight_color;
uniform vec2 texture_dimentions;
uniform float pressed_keys[10];

float distance_from_camera(vec3 camera_position) {
	return distance(camera_position.xy, vec2(v_vMatrixWorld * vec4(v_vPosition.xy, 0.0, 1.0)));	
}

float ratio(float val, float start, float end) {
	return (val-start)/(end-start);	
}

vec3 normal_world(vec3 vec) {
	return normalize(vec4(v_vMatrixWorld * vec4(vec, 0)).xyz);
}

vec4 directional_light(vec3 direction, vec3 hue, vec3 normal) {
	float brightness;
	
	brightness = length(normal*direction);
	return vec4(hue*brightness, 1);
}

float fade_alpha(vec3 camera_position, float fade_start, float fade_end) {
	float a_mix, dist;

	dist = distance_from_camera(camera_position);
	a_mix = ratio(dist, fade_start, fade_end);
	
	return 1.0 - clamp(a_mix, 0.0, 1.0);
}

vec4 fog_mix(vec3 camera_position, vec4 color, vec3 fog_color, float fog_start, float fog_end) {
	float dist, f_mix, c_mix;

	dist = distance_from_camera(camera_position);
	
	if (dist > fog_end) return vec4(fog_color, color.a);
	if (dist < fog_start) return color;
	
	f_mix = ratio(dist, fog_start, fog_end);
	c_mix = 1.0 - clamp(f_mix, 0.0, 1.0);
	
	return vec4(vec3(vec3(color)*c_mix + fog_color*f_mix), color.a);
}

vec4 get_nearest_color_range(vec4 color, float n_levels, vec3 shadow_color) {
	float range, alpha;
	
	range = 1.0/n_levels;
	
	alpha = color.a > 1.0-range ? 1.0 : color.a - mod(color.a, range);
	
	if (shadow_color.r > 0.0 || shadow_color.g > 0.0 || shadow_color.b > 0.0) {
		return vec4((1.0 - (1.0 - color.rgb) * (1.0 - shadow_color)) - mod(color.rgb, range),  alpha);
	}
	
	return vec4(color.rgb - mod(color.rgb, range), alpha);
}

vec2 get_texture_position(vec2 coord) {
	return vec2(coord.x/texture_dimentions.x, coord.y/texture_dimentions.y);	
}

bool isValueInMatrix(mat4 m, float value) {
    // Loop through each row and column of the matrix
    for (int i = 0; i < 4; ++i) {
        for (int j = 0; j < 4; ++j) {
            if (m[i][j] == value) {
                return true; // Return true if any element matches the value
            }
        }
    }
    return false; // Return false if no elements match the value
}

vec2 get_pressed_key_texcoord(vec2 texcoord, float key) {
	if (key < 0.0) {
		return texcoord;
	}
	
	float note = mod(key, 12.0);
	
	if (note == 1.0 || note == 3.0 || note == 6.0 || note == 8.0 || note == 10.0) {
		return texcoord;
	}
	
	int octave = int(key / 12.0);
	float k_start_pos = float(octave) * 7.0;
	vec2 start_pos, end_pos;

	float pos;
		
	if (note == 0.0) {
		pos	= k_start_pos;
	} else if (note == 2.0) {
		pos = k_start_pos + 1.0;	
	} else if (note == 4.0) {
		pos = k_start_pos + 2.0;
	} else if (note == 5.0) {
		pos = k_start_pos + 3.0;
	} else if (note == 7.0) {
		pos = k_start_pos + 4.0;	
	} else if (note == 9.0) {
		pos = k_start_pos + 5.0;	
	} else {
		pos = k_start_pos + 6.0;	
	}
		
	float key_xstart = pos*10.0;
		
	start_pos = get_texture_position(vec2(230.0 + key_xstart, 57.0));
	end_pos = get_texture_position(vec2(239.0 + key_xstart, 59.0));
	
	if (texcoord.x >= start_pos.x && texcoord.x <= end_pos.x &&
		texcoord.y >= start_pos.y && texcoord.y <= end_pos.y) {
		return texcoord + get_texture_position(vec2(0.0, -1.0));
	}
	
	return texcoord;	
}

vec2 get_pressed_keys_texcoord(vec2 texcoord, float[10] pressed_keys) {
	for (int i = 0; i < 10; i++) {
		vec2 texcoord_new = get_pressed_key_texcoord(texcoord, pressed_keys[i]);
		
		if (texcoord_new != texcoord) {
			return texcoord_new;	
		}
	}
	
	return texcoord;
}

vec4 draw_key(vec4 color, vec2 texcoord, float key) {
	float note = mod(key, 12.0);
	int octave = int(key / 12.0);
	float k_start_pos = float(octave) * 7.0;
	vec2 start_pos, end_pos;
	
	if (note == 1.0 || note == 3.0 || note == 6.0 || note == 8.0 || note == 10.0) {
		float pos;
		
		if (note == 1.0) {
			pos = k_start_pos;	
		} else if (note == 3.0) {
			pos = k_start_pos + 1.0;	
		} else if (note == 6.0) {
			pos = k_start_pos + 3.0;	
		} else if (note == 8.0) {
			pos = k_start_pos + 4.0;	
		} else {
			pos = k_start_pos + 5.0;	
		}
		
		float key_xstart = pos*10.0;
		
		start_pos = get_texture_position(vec2(238.0 + key_xstart, 48.0));
		end_pos = get_texture_position(vec2(242.0 + key_xstart, 52.0));
		
		if (texcoord.x >= start_pos.x && texcoord.x <= end_pos.x &&
			texcoord.y >= start_pos.y && texcoord.y <= end_pos.y) {
			return highlight_color;
		}
	} else {
		float pos;
		
		if (note == 0.0) {
			pos	= k_start_pos;
		} else if (note == 2.0) {
			pos = k_start_pos + 1.0;	
		} else if (note == 4.0) {
			pos = k_start_pos + 2.0;
		} else if (note == 5.0) {
			pos = k_start_pos + 3.0;
		} else if (note == 7.0) {
			pos = k_start_pos + 4.0;	
		} else if (note == 9.0) {
			pos = k_start_pos + 5.0;	
		} else {
			pos = k_start_pos + 6.0;	
		}
		
		float key_xstart = pos*10.0;
		
		start_pos = get_texture_position(vec2(231.0 + key_xstart, 48.0));
		end_pos = get_texture_position(vec2(239.0 + key_xstart, 59.0));
		
		if (texcoord.x >= start_pos.x && texcoord.x <= end_pos.x &&
			texcoord.y >= start_pos.y && texcoord.y <= end_pos.y) {
			return color + highlight_color * .72;
		}
	}
	
	
	
	return color;
}

void main() {
	vec4 color, color2;
	
	color = v_vColour * texture2D(gm_BaseTexture, get_pressed_keys_texcoord(v_vTexcoord, pressed_keys));
	
	if (lighting_enabled) {
		color = color * directional_light(light_direction, light_hue, normal_world(v_vNormal));
	}
	
	if (fog_enabled) {
		color = fog_mix(camera_position, color, fog_color, fog_start, fog_end);
	}
	
	if (color_levels > 0.0) {
		//color = get_nearest_color_range(color, color_levels, shadow_color);
	}
	
	if (highlight_key) {
		color = draw_key(color, v_vTexcoord, key);
	}
	
	gl_FragColor = color * vec4(1.0, 1.0, 1.0, alpha);
	
	if (gl_FragColor.a == 0.0) {
        discard;
    }
}
