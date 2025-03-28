function BaseInterpolator(_initial_value = 0, _final_value = 0, _active = true) constructor {
	value = _initial_value
	final_value = _final_value
	active = _active
	
	step = function() {
		throw "Method not implemented."	
	}
	
	has_completed = function() {
		return value == final_value
	}
	
	start = function() {
		active = true	
	}
	
	stop = function() {
		active = false	
	}
}