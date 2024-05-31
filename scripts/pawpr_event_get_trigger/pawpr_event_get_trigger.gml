function pawpr_event_get_trigger(event) {
	switch (event) {
		case pawpr_ev.mouse_over:
			return function(element) {
				return element[pawpr_attr.is_mouse_over];
			}
			
		case pawpr_ev.mouse_out:
			return function(element) {
				return !element[pawpr_attr.is_mouse_over];
			}
			
		case pawpr_ev.mouse_move:
			return function(element) {
				return element[pawpr_attr.ui][pawpr_attr.has_mouse_moved] && element[pawpr_attr.is_mouse_over]	
			}
			
		case pawpr_ev.mouse_enter:
			return function(element) {
				return element[pawpr_attr.is_mouse_entering];	
			}
			
		case pawpr_ev.mouse_leave:
			return function(element) {
				return element[pawpr_attr.is_mouse_leaving];	
			}
			
		case pawpr_ev.create:
			return function() {
				return false;	
			}
			
		case pawpr_ev.update:
			return function() {
				return true;	
			}
			
		default:
			throw "Event not defined.";
	}
}