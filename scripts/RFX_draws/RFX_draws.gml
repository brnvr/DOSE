/// @description RFX_draw_sprite()
function RFX_draw_sprite() {
	if RFXenabled{
	
	    var sprite = argument[0];
		var index = argument[1]
		var xx = argument[2];
		var yy = argument[3];
		var xScale = argument_count>4? argument[4]: 1;
		var yScale = argument_count>5? argument[5]: 1;
		var Rot = argument_count>6? argument[6]: 0;
		var Col = argument_count>7? argument[7]: c_white;
		var Alph = argument_count>8? argument[8]: 1;
    
	    var sSize = [sprite_get_width(sprite),sprite_get_height(sprite)];
	
		RFX_set_shader(sSize);
	
		draw_sprite_ext(sprite,index,xx,yy,xScale,yScale,Rot,Col,Alph);
    
	    shader_reset();

	}
}

function RFX_apply_screen() {
	if RFXenabled{
	
	    var sSize = [display_get_gui_width(),display_get_gui_height()];
		RFX_set_shader(sSize);
		
		draw_surface_stretched(application_surface,0,0,sSize[0],sSize[1]);
    
	    shader_reset();

	}
}

/// @description RFX_draw_sprite()
/// @param Surface
/// @param X
/// @param Y
/// @param xScale
/// @param yScale
/// @param Angle
/// @param Color
/// @param Alpha
function RFX_draw_surface() {

	var surf = argument[0];
	var xx = argument[1];
	var yy = argument[2];
	var xScale = argument_count>3? argument[3]: 1;
	var yScale = argument_count>4? argument[4]: 1;
	var Rot = argument_count>5? argument[5]: 0;
	var Col = argument_count>6? argument[6]: c_white;
	var Alph = argument_count>7? argument[7]: 1;

	if RFXenabled{
	
		var area = [surface_get_width(surf)*xScale,surface_get_height(surf)*yScale];
	
	    RFX_set_shader( area );
		
		var mip = gpu_get_tex_mip_enable();
		
		gpu_set_tex_mip_enable(mip_off);
	}
		draw_surface_ext(surf,xx,yy,xScale,yScale,Rot,Col,Alph);

	if RFXenabled{
	    shader_reset();
		
		gpu_set_tex_mip_enable(mip);
	}
}