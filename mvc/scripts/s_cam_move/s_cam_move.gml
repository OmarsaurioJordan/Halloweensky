/// @description s_cam_move();
// debe existir la variable global clicdxy

if clicdxy[0] != 0 and clicdxy[1] != 0 {
    __view_set( e__VW.XView, 0, __view_get( e__VW.XView, 0 ) + (clicdxy[0] - mouse_x) );
    __view_set( e__VW.YView, 0, __view_get( e__VW.YView, 0 ) + (clicdxy[1] - mouse_y) );
    s_cam_limit();
}
if mouse_check_button_pressed(mb_right) {
    clicdxy[0] = mouse_x;
    clicdxy[1] = mouse_y;
}
else if mouse_check_button_released(mb_right) {
    clicdxy[0] = 0;
    clicdxy[1] = 0;
}

