/// @description Sets seed groups

var walls, push_walls;

walls = [];

push_walls = function(walls, prefix, ev_chance) {
	for (var i = 0; true; i++) {
		var wall = asset_get_index($"{prefix}_{i}");
	
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

global.seed_groups = []

global.seed_groups[realms.thisside] = []
global.seed_groups[realms.thisside][sg.walls] = walls;
global.seed_groups[realms.thisside][sg.doors] = [spr_door_thisside_3]
global.seed_groups[realms.thisside][sg.lamps] = [spr_lamp_0, spr_lamp_1]
global.seed_groups[realms.thisside][sg.characters] = [obj_giramorph, obj_hippollusionist, obj_jibon, obj_mister_crow, obj_ravi, obj_doorman]
global.seed_groups[realms.thisside][sg.props] = [obj_armchair, obj_television_0]
global.seed_groups[realms.thisside][sg.items] = [obj_currant_syrup, obj_antivenom, obj_lucky_frog]
global.seed_groups[realms.thisside][sg.overlays] = [spr_painting_0, spr_air_vent]
global.seed_groups[realms.thisside][sg.wall_props] = [obj_wallclock]
global.seed_groups[realms.thisside][sg.music] = [snd_uncertain]

global.seed_groups[realms.otherside] = []
global.seed_groups[realms.otherside] = []
global.seed_groups[realms.otherside][sg.walls] = [spr_wall_otherside_rare_0, spr_wall_otherside_rare_1, spr_wall_otherside_rare_2];
global.seed_groups[realms.otherside][sg.doors] = [spr_door_thisside_3]
global.seed_groups[realms.otherside][sg.lamps] = [spr_lamp_0, spr_lamp_1]
global.seed_groups[realms.otherside][sg.characters] = [obj_giramorph, obj_hippollusionist, obj_jibon, obj_mister_crow, obj_ravi, obj_doorman]
global.seed_groups[realms.otherside][sg.props] = [obj_armchair, obj_television_0]
global.seed_groups[realms.otherside][sg.items] = [obj_currant_syrup, obj_antivenom, obj_lucky_frog]
global.seed_groups[realms.otherside][sg.overlays] = [spr_painting_0, spr_air_vent]
global.seed_groups[realms.otherside][sg.wall_props] = [obj_wallclock]
global.seed_groups[realms.otherside][sg.music] = [snd_uncertain]

global.names = []

var populate_names = function(arr, complement_property_name) {
	array_foreach(arr, method({ complement_property_name: complement_property_name }, function(obj) {
		var inst = instance_create_depth(0, 0, 0, obj, { prob_event: 0 });
		global.names[obj] = [inst.name, variable_instance_get(inst, complement_property_name)]; 	
		instance_destroy(inst);
	}))
}

populate_names(global.seed_groups[realms.thisside][sg.characters], "pronouns")
populate_names(global.seed_groups[realms.otherside][sg.characters], "pronouns")
populate_names(global.seed_groups[realms.thisside][sg.items], "name_article")
populate_names(global.seed_groups[realms.otherside][sg.items], "name_article")


/*global.seed_groups = {
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