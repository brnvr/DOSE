function angle_get_signed(angle) {
   return umod(angle+180, 360) - 180;
}