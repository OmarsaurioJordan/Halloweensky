/// @description Sombras

var xx = __view_get( e__VW.XView, 0 );
var yy = __view_get( e__VW.YView, 0 );

// oscuridad fondo
var sss = surface_create(rectw, recth);
surface_set_target(sss);
draw_clear_alpha(c_black, 1);
var h = hora / 255;
var alp;
if h > 0.1 and h < 0.4 { // dia
    alp = 0;
}
else if h > 0.6 and h < 0.9 { // noche
    alp = m_oscuridad;
}
else if h >= 0.4 and h <= 0.6 { // atardecer
    alp = lerp(0, m_oscuridad, (h - 0.4) / 0.2);
}
else { // amanecer
    if h > 0.5 {
        alp = lerp(m_oscuridad, 0, (h - 0.9) / 0.2);
    }
    else {
        alp = lerp(m_oscuridad, 0, (h + 0.1) / 0.2);
    }
}
draw_set_blend_mode(bm_subtract);
if alp != 0 {
    with o_luz {
        draw_sprite_ext(d_luz, 0, x - xx, y - yy, 2 * radio, 2 * radio, 0, c_white, 1);
    }
    with o_humano {
        if herramienta == m_herr_antorcha {
            if ds_list_find_value(municiones, herramienta) != 0 {
                draw_sprite_ext(d_luz, 0, x - xx, y - yy, 2 * radio, 2 * radio, 0, c_white, 1);
            }
        }
    }
}
draw_set_blend_mode(bm_normal);
surface_reset_target();
draw_surface_ext(sss, xx, yy, 1, 1, 0, c_white, alp);
surface_free(sss);

// sombras
with o_movil {
    if visible {
        draw_sprite(d_sombra, 0, xi, yi);
    }
}
with o_astral {
    if visible {
        draw_sprite(d_sombra, 1, xi, yi);
    }
}
with o_proyectil {
    if visible {
        var d = 0;
        if tipo == 12 or tipo == 13 {
            d = direction;
        }
        draw_sprite_ext(d_proyesombra, tipo, x, y,
            1, 1, d, c_white, 1);
    }
}

// circulo oscuro de vision
if !modo_editor {
    draw_sprite_ext(d_vision, 0, xx, yy + recth, escala_vision,
        escala_vision, 0, c_white, 1);
    draw_rectangle_colour(xx, yy, xx + rectw, yy +
        desfase_vision, c_black, c_black, c_black,
        c_black, false);
}

// linea mouse
if player != noone {
    draw_set_alpha(0.5);
    draw_line_width_colour(player.x, player.y, o_mouse.x, o_mouse.y,
        2, c_lime, c_lime);
    draw_set_alpha(1);
}


