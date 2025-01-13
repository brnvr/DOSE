//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float angle;

vec2 rotateAroundCenter(vec2 fragCoord, float angle) {
    vec2 translated = fragCoord - 0.5;

    float cosAngle = cos(angle);
    float sinAngle = sin(angle);
    vec2 rotated = vec2(
        translated.x * cosAngle - translated.y * sinAngle,
        translated.x * sinAngle + translated.y * cosAngle
    );

    return rotated + 0.5;
}

void main()
{
	vec2 coord = rotateAroundCenter(v_vTexcoord, angle);
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, coord);
	if (gl_FragColor.a == 0.0) discard;
}
