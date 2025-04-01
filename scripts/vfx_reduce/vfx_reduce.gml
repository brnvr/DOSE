function vfx_reduce(interpolator_type) {
	var default_value = global.vfx_default_values[$ interpolator_type]
	
	return array_reduce(vfx_filters, method ({ default_value, interpolator_type }, function(previous, current, index) {
		var previous_value = default_value
		
		if (index > 0) {
			var previous_interpolator = previous[1][$ interpolator_type]
		
			if (is_undefined(previous_interpolator)) {
				return default_value	
			}	
			
			previous_value = previous_interpolator.value
		}
		
		var current_interpolator = current[1][$ interpolator_type]
		var current_value = is_undefined(current_interpolator) ? default_value : current_interpolator.value
		
		return max(previous_value, current_value)
	}), default_value)
}