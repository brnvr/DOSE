// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function events_get_functions(arr) {
	return array_map(arr, function(elem) {
		return elem[1]	
	})
}