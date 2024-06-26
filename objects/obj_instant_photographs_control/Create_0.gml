yoffset = 130
photographs = []
photo_index = 0;
obj_player.can_move = false
obj_player.can_look = false
cursor_set_sprite(spr_cursor_arrow)
arrows_alpha = [.3, .3]
arrows_xdist = instant_photograph_width*.5+34
arrows_bbox = [0, -sprite_get_height(spr_selection_arrow)*.5, sprite_get_width(spr_selection_arrow), sprite_get_height(spr_selection_arrow)*.5]

event_user(0)