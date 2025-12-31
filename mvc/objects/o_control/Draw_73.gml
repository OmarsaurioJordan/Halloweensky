/// @description GUI

var xx = __view_get( e__VW.XView, 0 );
var yy = __view_get( e__VW.YView, 0 );
if modo_editor {
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    var e = __view_get( e__VW.WView, 0 ) / 768;
    draw_text_transformed_colour(xx, yy,
        string_hash_to_newline(editor_objeto + " - " + string(editor_tipo)),
        e, e, 0, c_aqua, c_aqua, c_aqua, c_aqua, 1);
}
else {
    var esc = 0.666;
    
    // informacion de costo de objetos en fogata
    with o_mobiliario {
        if tipo == 2 {
            if escoliding {
                if o_control.paraventa != m_herr_nada {
                    draw_sprite_ext(d_crafting, 0, x, y,
                        1, 1, 0, c_white, 0.75);
                    draw_sprite(d_crafting, 1, x, y);
                    draw_set_valign(fa_middle);
                    draw_set_halign(fa_left);
                    var ccc = c_black;
                    if o_control.costo[o_control.paraventa, 0] > o_control.materiales[1] {
                        ccc = c_red;
                    }
                    draw_text_transformed_colour(x + 65, y - 201,
                        string_hash_to_newline(string(o_control.costo[o_control.paraventa, 0])),
                        1.5, 1.5, 0, ccc, ccc, ccc, ccc, 1);
                    ccc = c_black;
                    if o_control.costo[o_control.paraventa, 1] > o_control.materiales[2] {
                        ccc = c_red;
                    }
                    draw_text_transformed_colour(x + 65, y - 141,
                        string_hash_to_newline(string(o_control.costo[o_control.paraventa, 1])),
                        1.5, 1.5, 0, ccc, ccc, ccc, ccc, 1);
                    draw_sprite_ext(d_crafting, 1 + o_control.paraventa,
                        x, y, 1, 1, 0, c_white, 1);
                }
                else {
                    draw_sprite_ext(d_crafting, 0, x, y,
                        1, 1, 0, c_white, 0.75);
                }
                draw_sprite(d_crafting, 22, x, y + 110 * (o_control.paraventa / 20));
            }
            break;
        }
    }
    
    // reloj con hora y dia
    draw_sprite_ext(d_tiempo, 0, xx, yy, esc, esc, 0, c_white, 1);
    draw_sprite_ext(d_aguja, 0, xx + 83 * esc, yy + 75 * esc, esc, esc,
        (-hora / 255) * 360 - 90, c_white, 1);
    draw_set_valign(fa_middle);
    draw_set_halign(fa_center);
    draw_text_transformed_colour(xx + 83 * esc, yy + 209 * esc,
        string_hash_to_newline(string(dia)),
        2.5 * esc, 2.5 * esc, 0, c_black, c_black, c_black, c_black, 1);
    if hora < 127 {
        draw_sprite_ext(d_tiempo, 1, xx, yy, esc, esc, 0, c_white, 1);
    }
    else {
        draw_sprite_ext(d_tiempo, 2 + luna, xx, yy, esc, esc, 0, c_white, 1);
    }
    
    // estadisticas de entidades
    draw_set_valign(fa_middle);
    draw_set_halign(fa_right);
    for (var i = array_length_1d(estadisticas) - 1; i >= 0; i--) {
        draw_sprite_ext(d_monstersgui, i, xx + rectw, yy + 60 * esc + i * 80 * esc,
            0.8 * esc, 0.8 * esc, 0, c_white, 1);
        draw_text_transformed_colour(xx + rectw - 90 * esc, yy + 60 * esc + i * 80 * esc,
            string_hash_to_newline(string(estadisticas[i])), 2 * esc, 2 * esc, 0,
            c_white, c_white, c_white, c_white, 1);
    }
    
    // materiales recolectados
    draw_set_valign(fa_middle);
    draw_set_halign(fa_left);
    for (var i = 0; i < array_length_1d(materiales) - 1; i++) {
        draw_sprite_ext(d_itemsgui, i, xx, yy + recth - 50 * esc - i * 72 * esc,
            0.8 * esc, 0.8 * esc, 0, c_white, 1);
        draw_text_transformed_colour(xx + 80 * esc, yy + recth - 50 * esc - i * 72 * esc,
            string_hash_to_newline(string(materiales[i])), 2 * esc, 2 * esc, 0,
            c_white, c_white, c_white, c_white, 1);
    }
    
    // estadisticas networking
    draw_set_valign(fa_bottom);
    draw_set_halign(fa_right);
    var nnn, vvv;
    if servidor {
        draw_text_transformed_colour(xx + rectw, yy + recth,
            string_hash_to_newline("(F2) Server "), 2.5 * esc, 2.5 * esc, 0, c_white, c_white, c_white, c_white, 1);
        nnn = losnombres;
        vvv = estavivo;
    }
    else {
        draw_text_transformed_colour(xx + rectw, yy + recth,
            string_hash_to_newline("(F2) Client "), 2.5 * esc, 2.5 * esc, 0, c_white, c_white, c_white, c_white, 1);
        nnn = listadonombres;
        vvv = listadoestavivo;
    }
    for (var i = 0; i < ds_list_size(nnn); i++) {
        if ds_list_find_value(vvv, i) == 0 {
            draw_text_transformed_colour(xx + rectw, yy + recth - 32 - i * 24,
                string_hash_to_newline(ds_list_find_value(nnn, i) + " - "),
                2 * esc, 2 * esc, 0, c_gray, c_gray, c_gray, c_gray, 1);
        }
        else {
            draw_text_transformed_colour(xx + rectw, yy + recth - 32 - i * 24,
                string_hash_to_newline(ds_list_find_value(nnn, i) + " - "),
                2 * esc, 2 * esc, 0, c_white, c_white, c_white, c_white, 1);
        }
    }
}


