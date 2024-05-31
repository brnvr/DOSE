// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function vector_add(vector_0, vector_1){
	if (!is_array(vector_0)) {
		throw "vector_0 must be an array";	
	}
	
	if (!is_array(vector_1)) {
		throw "vector_1 must be an array";	
	}
	
	var vector_0_length, vector_1_length, new_vector;
	
	vector_0_length = array_length(vector_0);
	vector_1_length = array_length(vector_1);
	new_vector = [];
	
	for (var i = 0; i < min(vector_0_length, vector_1_length); i++) {
		array_push(new_vector, vector_0[i] + vector_1[i]);
	}
	
	return new_vector;
}