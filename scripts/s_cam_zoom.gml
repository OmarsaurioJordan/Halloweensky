// hace zoom con el mouse
var minw = room_width * 0.2;
var maxw = room_width;
var minh = room_height * 0.2;
var maxh = room_height;
var velcambio = 0.1;
// hacer las cosas
var rezi = 0;
if mouse_wheel_down() {
    rezi = 1 + velcambio;
}
if mouse_wheel_up() {
    rezi = 1 - velcambio;
}
if rezi != 0 {
    var mx = mouse_x;
    var my = mouse_y;
    var cx = (mx - view_xview[0]) / view_wview[0];
    var cy = (my - view_yview[0]) / view_hview[0];
    view_wview[0] = clamp(view_wview[0] * rezi, minw, maxw);
    view_hview[0] = clamp(view_hview[0] * rezi, minh, maxh);
    view_xview[0] = mx - cx * view_wview[0];
    view_yview[0] = my - cy * view_hview[0];
    s_cam_limit();
}

