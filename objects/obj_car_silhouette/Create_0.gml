ts_destroy = time_source_create(time_source_global, 20, time_source_units_seconds, function() {
	instance_destroy();	
});

time_source_start(ts_destroy);

texture_list = [sprite_get_texture(spr_car_silhouette, irandom(sprite_get_number(spr_car_silhouette)-1))];

event_inherited();