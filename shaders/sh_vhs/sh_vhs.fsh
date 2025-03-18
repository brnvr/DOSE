varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 scale;
uniform float saturation;
uniform vec3 shadowColor;
uniform vec2 trackingErrorDistance;
uniform vec2 trackingErrorVariation;
uniform float trackingErrorAlpha;
uniform sampler2D trackingLines;
uniform vec3 palette[64];
uniform sampler2D waveGradient;
uniform float waveAmount;
uniform float waveOffset;
uniform sampler2D ditherMap;
uniform vec2 screenSize;
uniform float blurRadius;
uniform float blurIntensity;

vec4 applyShadowColor(vec4 color, vec3 shadowColor) {
    vec4 color1 = vec4(vec3(color) + shadowColor, color.a);
    
    return vec4(max(color1.r, shadowColor.r), max(color1.g, shadowColor.g), max(color1.b, shadowColor.b), 1.0);
}

vec4 applySaturation(vec4 color, float value) {
    float mean;
    vec3 grayscale, delta;
    
    grayscale = vec3((color.r + color.g + color.b) / 3.0);
    delta = color.rgb - grayscale;
    
    return vec4(grayscale + delta * value, color.a);
}

vec4 applyPalette(vec4 refColor, vec3 palette[64]) {
    float minDistance = 1e10;
    vec3 closestColor = vec3(0.0);

    for (int i = 0; i < 64; i++) {
        float distance = dot(refColor.xyz - palette[i], refColor.xyz - palette[i]);

        if (distance < minDistance) {
            minDistance = distance;
            closestColor = palette[i];
        }
    }

    return vec4(closestColor.xyz, refColor.a);
}

vec4 applyDithering(vec4 color, vec2 texcoord, vec2 screenSize) {
    vec2 pixelScale = vec2(2, 2);
    
    texcoord.x *= screenSize.x / 128.0 / pixelScale.x;
    texcoord.y *= screenSize.y / 128.0 / pixelScale.y;
    
    float ditherValue = 2.0 * texture2D(ditherMap, texcoord).r - 1.0;
    
    float gamma = 1.2;
    float dspread = 20.0;
    color.rgb = pow(color.rgb, vec3(1.0 / gamma));
    color += ditherValue / dspread;
    color = clamp(color, 0.001, 0.999);
    
    return color;
}

vec4 applyGaussianBlur(sampler2D baseTexture, vec2 texcoord, vec2 texSize, float blurRadius, float intensity) {
    vec4 color = texture2D(baseTexture, texcoord);
    
    float kernel[5];
    
    kernel[0] = 0.06136 * intensity;
    kernel[1] = 0.24477 * intensity;
    kernel[2] = 0.38774 * intensity;
    kernel[3] = 0.24477 * intensity;
    kernel[4] = 0.06136 * intensity;
    
    vec2 texOffset = blurRadius / texSize;

    vec4 result = color * kernel[2];

    for (int i = 1; i < 3; i++) {
        result += texture2D(baseTexture, texcoord + vec2(texOffset.x * float(i), 0.0)) * kernel[2 + i];
        result += texture2D(baseTexture, texcoord - vec2(texOffset.x * float(i), 0.0)) * kernel[2 + i];

        result += texture2D(baseTexture, texcoord + vec2(0.0, texOffset.y * float(i))) * kernel[2 + i];
        result += texture2D(baseTexture, texcoord - vec2(0.0, texOffset.y * float(i))) * kernel[2 + i];
    }

    return result;
}

void main() {
    vec2 texOffset0 = vec2(1.0) + (trackingErrorDistance + trackingErrorVariation) * .1;
    vec2 texOffset1 = vec2(1.0) - (trackingErrorDistance + trackingErrorVariation) * .1;
    
    vec4 trackingLinesColor = texture2D(trackingLines, v_vTexcoord + trackingErrorVariation * 2.0);
    vec2 texcoord = vec2(v_vTexcoord.x + trackingLinesColor.r * .0075, v_vTexcoord.y);
    
    if (waveAmount > 0.0) {
        vec4 waveColor = texture2D(waveGradient, vec2(0.0, v_vTexcoord.y / 2.0 + waveOffset));
        
        texcoord = texcoord + vec2(waveColor.r * waveAmount, 0.0);
    }
    
    texcoord = (texcoord - 0.5) / scale + 0.5;
    
    vec4 color0;
    
    if (blurRadius != 0.0 && blurIntensity != 0.0) {
        color0 = applyGaussianBlur(gm_BaseTexture, texcoord, vec2(512, 512), blurRadius, blurIntensity);    
    } else {
        color0 = texture2D(gm_BaseTexture, texcoord);
    }
    
    vec4 color1 = texture2D(gm_BaseTexture, texcoord * texOffset0);
    vec4 color2 = texture2D(gm_BaseTexture, texcoord * texOffset1);
    
    vec4 color = (color0 - (color1 - color2) * trackingErrorAlpha) * v_vColour;
    color = color + vec4(0.0, trackingLinesColor.r * .1, trackingLinesColor.r * .2, 0.0);
    
    color = applyDithering(color, texcoord, screenSize);
    color = applyShadowColor(color, shadowColor);
    color = applySaturation(color, saturation);
    color = applyPalette(color, palette);

    gl_FragColor = color;
}