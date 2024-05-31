// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function areas_destroy_distance(area_start, max_dist_nodes, dist=0, caller=noone, index=-1) {
	var n_neighbors;
	
	n_neighbors = array_length(area_start.neighbors);
	
	for (var i = 0; i < n_neighbors; i++) {
		var neighbor;
		
		neighbor = area_start.neighbors[i];
		
		if (neighbor == caller || neighbor == -1) continue;
		
		areas_destroy_distance(neighbor, max_dist_nodes, dist+1, area_start, i);
	}
	
	if (dist > max_dist_nodes) {
		if (caller != noone) {
			caller.neighbors[index] = -1;
		}	
		
		instance_destroy(area_start);	
	}
}