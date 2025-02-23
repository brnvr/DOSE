function Waver(_value = 0, _max_value = 0, _delta = 0, _active = true) constructor {
	value = _value
	delta = _delta
	active = _active
	max_value = _max_value
	
	step = function() {
		if (active) {
			value = (value + delta) mod max_value
		}
	}
	
	start = function() {
		active = true	
	}
	
	stop = function() {
		active = false	
	}
}