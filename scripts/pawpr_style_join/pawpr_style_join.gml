function pawpr_style_join(element_base, style_joined, properties_to_bypass=[]) {
	var style_base = element_base[pawpr_attr.style];
	var style_joined_length = array_length(style_joined);
	var n_properties_to_bypass = array_length(properties_to_bypass);

	for (var i = 0; i < style_joined_length; i++) {
		if (style_base[i] != undefined) continue;
		var bypass = false;
		
		for (var j = 0; j < n_properties_to_bypass; j++) {
			if (properties_to_bypass[j] == i) bypass = true;
		}
		
		if (bypass) continue;

		style_base[i] = style_joined[i];
	}
}