varying vec3 v_vNormal;
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;
varying mat4 v_vMatrixWorld;

uniform vec3 lightDirection;
uniform vec3 lightHue;
uniform vec3 cameraPosition;
uniform float fogStart;
uniform float fogEnd;
uniform vec3 fogColor;
uniform bool lightingEnabled;
uniform bool fogEnabled;
uniform float alpha;
uniform vec3 shadowColor;

float distanceFromCamera(vec3 cameraPosition) {
    return distance(cameraPosition.xy, vec2(v_vMatrixWorld * vec4(v_vPosition.xy, 0.0, 1.0)));    
}

float ratio(float val, float start, float end) {
    return (val - start) / (end - start);    
}

vec3 normalWorld(vec3 vec) {
    return normalize(vec4(v_vMatrixWorld * vec4(vec, 0)).xyz);
}

vec4 directionalLight(vec3 direction, vec3 hue, vec3 normal) {
    float brightness;
    
    brightness = length(normal * direction);
    return vec4(hue * brightness, 1);
}

float fadeAlpha(vec3 cameraPosition, float fadeStart, float fadeEnd) {
    float aMix, dist;

    dist = distanceFromCamera(cameraPosition);
    aMix = ratio(dist, fadeStart, fadeEnd);
    
    return 1.0 - clamp(aMix, 0.0, 1.0);
}

vec4 applyFogMix(vec3 cameraPosition, vec4 color, vec3 fogColor, float fogStart, float fogEnd) {
    float dist, fMix, cMix;

    dist = distanceFromCamera(cameraPosition);
    
    if (dist > fogEnd) return vec4(fogColor, color.a);
    if (dist < fogStart) return color;
    
    fMix = ratio(dist, fogStart, fogEnd);
    cMix = 1.0 - clamp(fMix, 0.0, 1.0);
    
    return vec4(vec3(vec3(color) * cMix + fogColor * fMix), color.a);
}

vec4 applyShadowColor(vec4 color, vec3 shadowColor) {
    vec4 color1 = vec4(vec3(color) + shadowColor, color.a);
    
    return vec4(max(color.r, shadowColor.r), max(color.g, shadowColor.g), max(color.b, shadowColor.b), color.a);
}

void main() {
    vec4 color = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    
    if (lightingEnabled) {
        color = color * directionalLight(lightDirection, lightHue, normalWorld(v_vNormal));
    }
    
    if (fogEnabled) {
        color = applyFogMix(cameraPosition, color, fogColor, fogStart, fogEnd);
    }
    
    if (shadowColor != vec3(0.0, 0.0, 0.0)) {
        color = applyShadowColor(color, shadowColor);    
    }
    
    gl_FragColor = color * vec4(1.0, 1.0, 1.0, alpha);
    
    if (gl_FragColor.a == 0.0) {
        discard;
    }
}