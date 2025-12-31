// animacion
s_ani_osci(id, 0, 2.5, 5); // body
s_ani_osci(id, 1, 2.2, 3); // cara

// errar
if s_errar_reloj(id) and random(1) < 0.25 {
    //var cc = instance_find(o_casa, irandom(instance_number(o_casa) - 1));
    //direction = point_direction(x, y, cc.x, cc.y);
}

// colision con astrales
var otro = instance_place(x, y, o_astral);
if otro != noone {
    var ddd = point_direction(otro.x, otro.y, x, y);
    var vel = m_velocidad * dlt / 2;
    x += lengthdir_x(vel, ddd);
    y += lengthdir_y(vel, ddd);
    otro.x += lengthdir_x(vel, -ddd);
    otro.y += lengthdir_y(vel, -ddd);
}
// IA
else {
    if moverse {
        var vel = m_velocidad * dlt;
        x += lengthdir_x(vel, direction);
        y += lengthdir_y(vel, direction);
    }
}

// interpolacion
s_limites(id);


