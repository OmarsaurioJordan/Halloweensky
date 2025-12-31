/// @description s_azar_cosas(densidad, objeto, radio);
/// @param densidad
/// @param  objeto
/// @param  radio

var cuantos = ceil(((pi * power(2000, 2)) / (pi * power(48, 2))) * argument0);
var xx, yy, freno;
repeat cuantos {
    freno = 100;
    do {
        xx = random(room_width);
        yy = random(room_height);
        freno--;
    }
    until freno <= 0 or
        (point_distance(xx, yy, 2048, 2048 + 250) < 2000 and
        !collision_circle(xx, yy, argument2, o_visible, true, false));
    if freno > 0 {
        instance_create(xx, yy, argument1);
    }
}

