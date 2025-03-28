function Interpolator(_initial_value = 0, _final_value = 0, _delta = 0, _active = true) : BaseInterpolator(_initial_value, _final_value, _active) constructor {
	delta = _delta
	
	step = function() {
		if (active) {
			value = linear_interpolation(value, final_value, delta)		
		}
		
		return value
	}
}