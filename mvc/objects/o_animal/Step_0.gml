// animacion
s_ani_osci(id, 0, 2.5, 5); // body
s_ani_paso(id, 0, 0.15, 5); // pies

if servidor {
    
    // errar
    if s_errar_reloj(id) and random(1) < 0.25 {
        //var cc = instance_find(o_casa, irandom(instance_number(o_casa) - 1));
        //direction = point_direction(x, y, cc.x, cc.y);
    }
    
    // IA
    if !s_colision(id) {
        if moverse {
            var vel = m_velocidad * dlt;
            x += lengthdir_x(vel, direction);
            y += lengthdir_y(vel, direction);
        }
    }
}

// interpolacion y anima pies
s_limites(id);
if x == xprevious and y == yprevious {
    reloj_pies = max(0, reloj_pies - dlt);
}
else {
    reloj_pies = 0.25;
}


