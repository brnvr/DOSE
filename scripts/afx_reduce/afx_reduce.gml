function afx_reduce(effect_type, interpolator_type) {
	var default_value = global.afx_default_values[$ effect_type][$ interpolator_type]
	
	return array_reduce(afx_filters, method ({ default_value, effect_type, interpolator_type }, function(previous, current, index) {
		var previous_value = default_value
		
		if (index > 0) {
			var previous_interpolators = previous[1][$ effect_type]
		
			if (is_undefined(previous_interpolators)) {
				return default_value	
			}
			
			var previous_interpolator = previous_interpolators[$ interpolator_type]
			
			if (is_undefined(previous_interpolator)) {
				return default_value	
			}
			
			previous_value = previous_interpolator.value
		}
		
		var current_interpolators = current[1][$ effect_type]
		
		if (is_undefined(current_interpolators)) {
			return default_value
		}
			
		var current_interpolator = current_interpolators[$ interpolator_type]
		
		if (!is_undefined(current_interpolator)) {
			if (current_interpolator.final_value >= current_interpolator.initial_value) {
				return max(previous_value, current_interpolator.value)
			} else {
				return min(previous_value, current_interpolator.value)	
			}
		}
		
		return max(previous_value, default_value)
	}), default_value)
}