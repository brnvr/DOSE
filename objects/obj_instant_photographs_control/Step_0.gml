if (yoffset > 0) {
	yoffset = smooth_interpolation(yoffset, 0);
}

arrows_alpha = clamp(arrows_alpha + 0.03, 0, 0.3)