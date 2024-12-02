/// @description collision overflow correction

repeat(200) {
	var inst_meeting = actor_3d_place(x, y, z, obj_actor_3d_generic);
	
	if (inst_meeting == noone) break;

	var point_dir = point_direction(x, y, inst_meeting.x, inst_meeting.y);
	var xspeed = dcos(inst_meeting.zrotation);
	var yspeed = -dsin(inst_meeting.zrotation);
	
	if (angle_difference(point_dir, inst_meeting.zrotation + 90) > 0) {
		x += xspeed;
		y += yspeed;
	} else {
		x -= xspeed;
		y -= yspeed;
	}
	
	if (x == xprevious && y == yprevious) {
		throw "You're stuck!";	
	}
}