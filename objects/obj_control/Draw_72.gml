var background_id, background_visible;

background_id = layer_background_get_id("Background");
background_visible = view_current == views.view_3d;

layer_background_visible(background_id, background_visible);