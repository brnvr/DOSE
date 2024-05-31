attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

varying vec3 v_vNormal;
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;
varying mat4 v_vMatrixWorld;

void main() {
	vec4 object_space_pos = vec4(in_Position, 1.0);
	gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;

	v_vNormal = in_Normal;
	v_vColour = in_Colour;
	v_vTexcoord = in_TextureCoord;
	v_vPosition = in_Position;
	v_vMatrixWorld = gm_Matrices[MATRIX_WORLD];
}
