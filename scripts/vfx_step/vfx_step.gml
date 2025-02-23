function vfx_step() {
	array_foreach(vfx_filters, function(item) {
		var interpolators = item[1]
	
		struct_foreach(interpolators, function(key, interpolator) {
			interpolator.step()
		})
	})
}