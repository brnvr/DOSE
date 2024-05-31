function background_set_color(color, layer_name="Background") {
	var background;
	
	background = layer_background_get_id(layer_get_id(layer_name));
	layer_background_blend(background, color);
}