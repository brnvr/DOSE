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
uniform float key;
uniform bool highlightKey;
uniform vec4 highlightColor;
uniform vec2 textureDimensions;
uniform float pressedKeys[10];

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

vec4 getNearestColorRange(vec4 color, float nLevels, vec3 shadowColor) {
    float range, alpha;
    
    range = 1.0 / nLevels;
    
    alpha = color.a > 1.0 - range ? 1.0 : color.a - mod(color.a, range);
    
    if (shadowColor.r > 0.0 || shadowColor.g > 0.0 || shadowColor.b > 0.0) {
        return vec4((1.0 - (1.0 - color.rgb) * (1.0 - shadowColor)) - mod(color.rgb, range), alpha);
    }
    
    return vec4(color.rgb - mod(color.rgb, range), alpha);
}

vec2 getTexturePosition(vec2 coord) {
    return vec2(coord.x / textureDimensions.x, coord.y / textureDimensions.y);    
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

vec2 getPressedKeyTexcoord(vec2 texcoord, float key) {
    if (key < 0.0) {
        return texcoord;
    }
    
    float note = mod(key, 12.0);
    
    if (note == 1.0 || note == 3.0 || note == 6.0 || note == 8.0 || note == 10.0) {
        return texcoord;
    }
    
    int octave = int(key / 12.0);
    float kStartPos = float(octave) * 7.0;
    vec2 startPos, endPos;

    float pos;
        
    if (note == 0.0) {
        pos = kStartPos;
    } else if (note == 2.0) {
        pos = kStartPos + 1.0;    
    } else if (note == 4.0) {
        pos = kStartPos + 2.0;
    } else if (note == 5.0) {
        pos = kStartPos + 3.0;
    } else if (note == 7.0) {
        pos = kStartPos + 4.0;    
    } else if (note == 9.0) {
        pos = kStartPos + 5.0;    
    } else {
        pos = kStartPos + 6.0;    
    }
        
    float keyXstart = pos * 10.0;
        
    startPos = getTexturePosition(vec2(230.0 + keyXstart, 57.0));
    endPos = getTexturePosition(vec2(239.0 + keyXstart, 59.0));
    
    if (texcoord.x >= startPos.x && texcoord.x <= endPos.x &&
        texcoord.y >= startPos.y && texcoord.y <= endPos.y) {
        return texcoord + getTexturePosition(vec2(0.0, -1.0));
    }
    
    return texcoord;    
}

vec2 getPressedKeysTexcoord(vec2 texcoord, float[10] pressedKeys) {
    for (int i = 0; i < 10; i++) {
        vec2 texcoordNew = getPressedKeyTexcoord(texcoord, pressedKeys[i]);
        
        if (texcoordNew != texcoord) {
            return texcoordNew;    
        }
    }
    
    return texcoord;
}

vec4 drawKey(vec4 color, vec2 texcoord, float key) {
    float note = mod(key, 12.0);
    int octave = int(key / 12.0);
    float kStartPos = float(octave) * 7.0;
    vec2 startPos, endPos;
    
    if (note == 1.0 || note == 3.0 || note == 6.0 || note == 8.0 || note == 10.0) {
        float pos;
        
        if (note == 1.0) {
            pos = kStartPos;    
        } else if (note == 3.0) {
            pos = kStartPos + 1.0;    
        } else if (note == 6.0) {
            pos = kStartPos + 3.0;    
        } else if (note == 8.0) {
            pos = kStartPos + 4.0;    
        } else {
            pos = kStartPos + 5.0;    
        }
        
        float keyXstart = pos * 10.0;
        
        startPos = getTexturePosition(vec2(238.0 + keyXstart, 48.0));
        endPos = getTexturePosition(vec2(242.0 + keyXstart, 52.0));
        
        if (texcoord.x >= startPos.x && texcoord.x <= endPos.x &&
            texcoord.y >= startPos.y && texcoord.y <= endPos.y) {
            return highlightColor;
        }
    } else {
        float pos;
        
        if (note == 0.0) {
            pos = kStartPos;
        } else if (note == 2.0) {
            pos = kStartPos + 1.0;    
        } else if (note == 4.0) {
            pos = kStartPos + 2.0;
        } else if (note == 5.0) {
            pos = kStartPos + 3.0;
        } else if (note == 7.0) {
            pos = kStartPos + 4.0;    
        } else if (note == 9.0) {
            pos = kStartPos + 5.0;    
        } else {
            pos = kStartPos + 6.0;    
        }
        
        float keyXstart = pos * 10.0;
        
        startPos = getTexturePosition(vec2(231.0 + keyXstart, 48.0));
        endPos = getTexturePosition(vec2(239.0 + keyXstart, 59.0));
        
        if (texcoord.x >= startPos.x && texcoord.x <= endPos.x &&
            texcoord.y >= startPos.y && texcoord.y <= endPos.y) {
            return color + highlightColor * .72;
        }
    }
    
    return color;
}

void main() {
    vec4 color, color2;
    
    color = v_vColour * texture2D(gm_BaseTexture, getPressedKeysTexcoord(v_vTexcoord, pressedKeys));
    
    if (lightingEnabled) {
        color = color * directionalLight(lightDirection, lightHue, normalWorld(v_vNormal));
    }
    
    if (fogEnabled) {
        color = applyFogMix(cameraPosition, color, fogColor, fogStart, fogEnd);
    }
    
    if (highlightKey) {
        color = drawKey(color, v_vTexcoord, key);
    }
    
    gl_FragColor = color * vec4(1.0, 1.0, 1.0, alpha);
    
    if (gl_FragColor.a == 0.0) {
        discard;
    }
}