/// @description RFX_init(pixel width, dither texture, dither spread, SSAA(?), double wide pixels(?))
/// @param pixelWidth
/// @param  ditherTexture
/// @param  ditherSpread
/// @param  SSAA?
/// @param  doubleWide?
function RFX_init(_PixelScale, _DitherTex, _DitherSpread, _SSAA = 0, _double = false) {

	globalvar RFXshader,RFXscale,RFXdith,RFXspread,RFXbdepth,RFXpal,
	    RFXudepth,RFXdithsampler,RFXpalsampler,RFXscreensize,RFXdithdiv,RFX2wide,RFXenabled,RFXcdepth,RFXuspread,RFXuPixelScale,RFXPixelScale,RFXGamma,RFXSSAA,RFXuSSAA;

	RFXshader = 0;
	RFXscale = _PixelScale;
	RFXdith = _DitherTex;
	RFXspread = _DitherSpread;
	RFXcdepth = 10;
	RFXpal = 0;
	RFXdithsampler = 0;
	RFXpalsampler = 0;
	RFXscreensize = 0;
	RFXuspread = 0;
	RFXudepth = 0;
	RFXenabled = true;
	RFX2wide = _double;
	RFXPixelScale = [RFX2wide? _PixelScale*2: _PixelScale, _PixelScale];
	RFXGamma = 1.2;
	RFXSSAA = _SSAA;

}

function RFX_set_shader( area ){
	
	shader_set(RFXshader);
	
	RFXdithsampler = shader_get_sampler_index(RFXshader, "s_dithmap");
	RFXpalsampler = shader_get_sampler_index(RFXshader, "s_lutmap");
	RFXscreensize = shader_get_uniform(RFXshader ,"screensize");
	RFXuspread = shader_get_uniform(RFXshader ,"dspread");
	RFXudepth = shader_get_uniform(RFXshader ,"cdepth");
	RFXuPixelScale = shader_get_uniform(RFXshader ,"PixelScale");
	RFXuSSAA = shader_get_uniform(RFXshader ,"u_SSAA");
	
	gpu_set_tex_filter(false);
	
	gpu_set_texrepeat_ext(RFXpalsampler,false);
	gpu_set_texrepeat_ext(RFXdithsampler,true);
	
	gpu_set_tex_mip_enable_ext(RFXdithsampler,mip_off);
	gpu_set_tex_filter_ext(RFXdithsampler,false);
	gpu_set_tex_mip_enable_ext(RFXpalsampler,mip_off);
	gpu_set_tex_filter_ext(RFXpalsampler,false);
	
	var RFXuGamma = shader_get_uniform(RFXshader ,"u_Gamma");
	shader_set_uniform_f(RFXuGamma,RFXGamma);
	shader_set_uniform_f_array(RFXuPixelScale,RFXPixelScale);
	
	texture_set_stage(RFXpalsampler,RFXpal);
	texture_set_stage(RFXdithsampler,RFXdith);
    
	shader_set_uniform_f_array(RFXscreensize,area);
	shader_set_uniform_f(RFXuspread,RFXspread);
	shader_set_uniform_f(RFXudepth,RFXcdepth);
	shader_set_uniform_f(RFXuSSAA,RFXSSAA);
	
}

/// @description RFX_set_palswap( Lut texture )
/// @param  Lut texture 
function RFX_set_palswap(lutTex) {
	RFXshader=RFX_palswap_shd;
	RFXpal=lutTex;
}

/// @description RFX_set_coldepth(Color Depth)
/// @param Color Depth
function RFX_set_coldepth(_ColorDepth) {
	RFXshader = RFX_coldepth_shd;
	RFXcdepth = _ColorDepth;
}