// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function passage_get_next_area(passage, on_area_created) {
	var n_defined_areas;
	
	n_defined_areas = array_length(passage.areas);
	
	static update_neighbors = function(passage) {
		array_push(passage.areas[0].neighbors, passage.areas[1]);
		array_push(passage.areas[1].neighbors, passage.areas[0]);	
	}
	
	if (n_defined_areas == 0) {
		passage.areas[0] = obj_game_control.current_area;
		passage.areas[1] = on_area_created();
		
		update_neighbors(passage);
		
		return passage.areas[1];
	} else if (n_defined_areas == 1) {
		if (passage.areas[0] == obj_game_control.current_area) {
			passage.areas[1] = on_area_created();	
			
			update_neighbors(passage);
			
			return passage.areas[1];
		}
		
		passage.areas[1] = obj_game_control.current_area;	
		
		update_neighbors(passage);
		
		return passage.areas[0];
	}
	
	if (passage.areas[0] == obj_game_control.current_area) {
		return passage.areas[1];	
	}
	
	return passage.areas[0];
}