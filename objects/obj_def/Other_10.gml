/// @description Sets seed groups

var walls, push_walls;

walls = [];

push_walls = function(walls, prefix, ev_chance) {
	for (var i = 0; true; i++) {
		var wall;
	
		wall = asset_get_index($"{prefix}_{i}");
	
		if (wall == -1) {
			break;	
		}
	
		repeat(ev_chance) array_push(walls, wall);
	}	
}

push_walls(walls, "spr_wall_thisside_very_common", ev_very_common);
push_walls(walls, "spr_wall_thisside_common", ev_common);

enum sg {
	walls,
	doors,
	lamps,
	characters,
	props,
	items,
	overlays,
	wall_props,
	music
}

seed_groups = []

seed_groups[realms.thisside] = []
seed_groups[realms.thisside][sg.walls] = walls;
seed_groups[realms.thisside][sg.doors] = [spr_door_thisside_0]
seed_groups[realms.thisside][sg.lamps] = [spr_lamp_0, spr_lamp_1]
seed_groups[realms.thisside][sg.characters] = [obj_giramorph, obj_hippollusionist, obj_jibon, obj_mister_crow, obj_ravi, obj_doorman]
seed_groups[realms.thisside][sg.props] = [obj_armchair, obj_television_0]
seed_groups[realms.thisside][sg.items] = [obj_currant_syrup, obj_lucky_frog]
seed_groups[realms.thisside][sg.overlays] = [spr_painting_0, spr_air_vent]
seed_groups[realms.thisside][sg.wall_props] = [obj_wallclock]
seed_groups[realms.thisside][sg.music] = [snd_uncertain]

seed_groups[realms.otherside] = []
seed_groups[realms.otherside] = []
seed_groups[realms.otherside][sg.walls] = [spr_wall_otherside_rare_0, spr_wall_otherside_rare_1, spr_wall_otherside_rare_2];
seed_groups[realms.otherside][sg.doors] = [spr_door_thisside_0]
seed_groups[realms.otherside][sg.lamps] = [spr_lamp_0, spr_lamp_1]
seed_groups[realms.otherside][sg.characters] = [obj_giramorph, obj_hippollusionist, obj_jibon, obj_mister_crow, obj_ravi, obj_doorman]
seed_groups[realms.otherside][sg.props] = [obj_armchair, obj_television_0]
seed_groups[realms.otherside][sg.items] = [obj_currant_syrup, obj_lucky_frog]
seed_groups[realms.otherside][sg.overlays] = [spr_painting_0, spr_air_vent]
seed_groups[realms.otherside][sg.wall_props] = [obj_wallclock]
seed_groups[realms.otherside][sg.music] = [snd_uncertain]

names = []

var populate_names = function(arr, complement_property_name) {
	array_foreach(arr, method({ complement_property_name: complement_property_name }, function(obj) {
		var inst = instance_create_depth(0, 0, 0, obj, { prob_event: 0 });
		names[obj] = [inst.name, variable_instance_get(inst, complement_property_name)]; 	
		instance_destroy(inst);
	}))
}

populate_names(seed_groups[realms.thisside][sg.characters], "pronouns")
populate_names(seed_groups[realms.otherside][sg.characters], "pronouns")
populate_names(seed_groups[realms.thisside][sg.items], "name_article")
populate_names(seed_groups[realms.otherside][sg.items], "name_article")


/*seed_groups = {
	thisside: {
		walls: walls,
		
		doors: [spr_door_thisside_0],
		lamps: [spr_lamp_0, spr_lamp_1],
		chars: [obj_giramorph, obj_hippollusionist, obj_jibon, obj_mister_crow, obj_ravi, obj_doorman],
		props: [obj_armchair, obj_television_0],
		items: [obj_currant_syrup, obj_lucky_frog],
		overs: [spr_painting_0, spr_air_vent],
		wall_props: [obj_wallclock]
	},
	
	otherside: {
		
	}
}*/