function relative_positioning(x0, y0, x1, y1, rotation) {
    var door_normal = point_direction(0, 0, lengthdir_y(1, rotation), lengthdir_x(1, rotation));
    
    var player_vector = [x0 - x1, y0 - y1];
    
    var product = player_vector[0] * lengthdir_x(1, door_normal) + player_vector[1] * lengthdir_y(1, door_normal);
    
    return product > 0
}