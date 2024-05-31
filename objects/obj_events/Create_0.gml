function ev_lights_off() {
	with (obj_wall_generic) {
		texture_list = [-1];
	}
}

events = {
	"very_common": [ev_lights_off],
	"common": [],
	"regular": [],
	"rare": [],
	"very_rare": [],
	"anomaly": []
}