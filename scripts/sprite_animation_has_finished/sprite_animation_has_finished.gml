function sprite_animation_has_finished(sprite, subimage, img_speed){
	var n_images;
	
	n_images = sprite_get_number(sprite);
	
	return (subimage > n_images - img_speed);
}