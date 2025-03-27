varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float saturation;
uniform float colorRange;
uniform float pixelSize;
uniform sampler2D ditherMap;
uniform vec2 textureDimensions;
uniform vec3 palette[64];

vec4 applySaturation(vec4 color, float value) {
    float mean;
    vec3 grayscale, delta;
    
    grayscale = vec3((color.r + color.g + color.b) / 3.0);
    delta = color.rgb - grayscale;
    
    return vec4(grayscale + delta * value, color.a);
}

vec4 getFragColor(sampler2D texture, vec2 texcoord, float pixelSize) {
    if (pixelSize <= 1.0) {
        return texture2D(texture, texcoord);    
    }
    
    vec2 newPixcoord, newTexcoord;
    
    float xpixel = floor(textureDimensions.x * texcoord.x);
    float ypixel = floor(textureDimensions.y * texcoord.y);
    
    newPixcoord.x = xpixel - mod(xpixel, pixelSize);
    newPixcoord.y = ypixel - mod(ypixel, pixelSize);
    
    newTexcoord.x = newPixcoord.x / textureDimensions.x;
    newTexcoord.y = newPixcoord.y / textureDimensions.y;
    
    return texture2D(texture, newTexcoord);    
}

vec4 applyDithering(vec4 color) {
    vec2 screensize = vec2(960, 540); // Replace with actual screen resolution
    vec2 pixelScale = vec2(2, 2);
    
    // Use gl_FragCoord.xy for screen-space coordinates
    vec2 texcoord = gl_FragCoord.xy / screensize;
    texcoord.x *= screensize.x / 128.0 / pixelScale.x;
    texcoord.y *= screensize.y / 128.0 / pixelScale.y;
    
    float ditherValue = 2.0 * texture2D(ditherMap, texcoord).r - 1.0;
    
    float gamma = 1.2;
    float dspread = 20.0;
    color.rgb = pow(color.rgb, vec3(1.0 / gamma));
    color += ditherValue / dspread;
    color = clamp(color, 0.001, 0.999);
    
    return color;
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

void main() {    
    vec4 color = getFragColor(gm_BaseTexture, v_vTexcoord, pixelSize);
    
    color = applyDithering(color);
    
    if (saturation != 1.0) {
        color = applySaturation(color, saturation);
    }
    
    color = applyPalette(color, palette);
    
    gl_FragColor = color;
    if (gl_FragColor.a == 0.0) discard;
}