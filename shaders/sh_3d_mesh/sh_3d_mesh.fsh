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
uniform vec3 shadow_color;

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

vec4 set_shadow_color(vec4 color, vec3 shadow_color) {
	vec4 color1 = vec4(vec3(color) + shadow_color, color.a);
	
	return vec4(max(color.r, shadow_color.r), max(color.g, shadow_color.g), max(color.b, shadow_color.b), color.a);
}

void main() {
	vec4 color, color2;
	
	color = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	
	if (lighting_enabled) {
		color = color * directional_light(light_direction, light_hue, normal_world(v_vNormal));
	}
	
	if (fog_enabled) {
		color = fog_mix(camera_position, color, fog_color, fog_start, fog_end);
	}
	
	if (shadow_color != vec3(0.0, 0.0, 0.0)) {
		color = set_shadow_color(color, shadow_color);	
	}
	
	gl_FragColor = color * vec4(1.0, 1.0, 1.0, alpha);
	
	if (gl_FragColor.a == 0.0) {
        discard;
    }
}
