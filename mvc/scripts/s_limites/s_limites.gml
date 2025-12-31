/// @description s_limites(id);
/// @param id
// objeto id debe tener xi, yi

with argument0 {
    var ll = point_distance(2048, 2048 + 250, x, y);
    if ll > 2000 {
        ll = 2000;
        direction = point_direction(2048, 2048 + 250, x, y);
        x = 2048 + lengthdir_x(ll, direction);
        y = 2048 + 250 + lengthdir_y(ll, direction);
    }
    // filtro movimiento
    var vv = point_distance(xi, yi, x, y) * dlt * 10;
    var dd = point_direction(xi, yi, x, y);
    if vv > 3 {
        xi += lengthdir_x(vv, dd);
        yi += lengthdir_y(vv, dd);
    }
    depth = -yi;
}

