function Interpolator(_value = 0, _destination = 0, _delta = 0, _active = true) constructor {
	value = _value
	delta = _delta
	active = _active
	destination = _destination
	
	step = function() {
		if (active) {
			value = linear_interpolation(value, destination, delta)		
		}
	}
	
	has_completed = function() {
		return value == destination	
	}
	
	start = function() {
		active = true	
	}
	
	stop = function() {
		active = false	
	}
}