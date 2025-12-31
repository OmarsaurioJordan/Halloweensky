x = mouse_x;
y = mouse_y;
if player != noone {
    var ll = point_distance(player.x, player.y, x, y);
    if ll > __view_get( e__VW.WView, 0 ) * 0.666 {
        ll = __view_get( e__VW.WView, 0 ) * 0.666;
        direction = point_direction(player.x, player.y, x, y);
        x = player.x + lengthdir_x(ll, direction);
        y = player.y + lengthdir_y(ll, direction);
    }
}
depth = -y;


