///s_colision(id);

var otro = noone;
with argument0 {
    // colision con solidos
    otro = instance_place(x, y, o_bloque);
    if otro != noone {
        var ddd = point_direction(otro.x, otro.y, x, y);
        ddd -= clamp(angle_difference(ddd,
            point_direction(xprevious, yprevious, x, y)), -40, 40);
        var vel = m_velocidad * dlt;
        x += lengthdir_x(vel, ddd);
        y += lengthdir_y(vel, ddd);
    }
    // colision con moviles
    else {
        otro = instance_place(x, y, o_movil);
        if otro != noone {
            var ddd = point_direction(otro.x, otro.y, x, y);
            var vel = m_velocidad * dlt / 2;
            x += lengthdir_x(vel, ddd);
            y += lengthdir_y(vel, ddd);
            otro.x += lengthdir_x(vel, -ddd);
            otro.y += lengthdir_y(vel, -ddd);
        }
    }
}
return otro != noone;

