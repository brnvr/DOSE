function position_3d_get_projected(xx, yy, zz, view_id=0) {
	var w, x2, y2, view_center_x, view_center_y, view_mat, proj_mat, cam;
	
	view_center_x = view_get_wport(view_id)*0.5;
	view_center_y = view_get_hport(view_id)*0.5;
	
	cam = view_get_camera(view_id);
	
	view_mat = camera_get_view_mat(cam);
	proj_mat = camera_get_proj_mat(cam);
	
	w = xx*view_mat[2] + yy*view_mat[6] + zz*view_mat[10] + view_mat[14];

	if (w > 0) {
	    x2 = (xx*view_mat[0] + yy*view_mat[4] + zz*view_mat[8] + view_mat[12])*proj_mat[0]/w*view_center_x + view_center_x;
	    y2 = (xx*view_mat[1] + yy*view_mat[5] + zz*view_mat[9] + view_mat[13])*proj_mat[5]/w*-view_center_y + view_center_y;
		
		return [x2, y2];
	} 
	
	return undefined;
}