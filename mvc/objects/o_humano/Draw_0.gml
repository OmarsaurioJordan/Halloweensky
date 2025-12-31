// pies
if reloj_pies == 0 {
    draw_sprite(d_humano, 6, xi, yi);
    draw_sprite(d_humano, 7, xi, yi);
}
else {
    var p1, p2;
    switch paso[0] {
        case 0: p1 = 0; p2 = 1; break;
        case 1: p1 = 0.3; p2 = 0.7; break;
        case 2: p1 = 0.7; p2 = 0.3; break;
        case 3: p1 = 1; p2 = 0; break;
        case 4: p1 = 0.7; p2 = 0.3; break;
        case 5: p1 = 0.3; p2 = 0.7; break;
    }
    draw_sprite(d_humano, 6, xi, yi - p1 * 12);
    draw_sprite(d_humano, 7, xi, yi - p2 * 12);
}
// cuerpo y cabeza
var g = genero * 2;
draw_sprite(d_humano, 1 + g, xi, yi + anima[0]);
draw_sprite(d_humano, g, xi, yi + anima[0] + anima[1]);
// objetos
draw_sprite(d_material, material, xi, yi + anima[0] - anima[2]);
if ds_list_find_value(municiones, herramienta) != 0 {
    if player == id and reloj_cadencia != 0 {
        draw_sprite_ext(d_herramienta, herramienta, xi, yi + anima[0] + anima[2],
            1, 1, 0, c_white, 0.5);
    }
    else {
        draw_sprite(d_herramienta, herramienta, xi, yi + anima[0] + anima[2]);
    }
}
// nombre
draw_set_valign(fa_bottom);
draw_set_halign(fa_center);
var nnn = "";
if player == id {
    nnn = o_control.nombre;
}
else if servidor {
    var i = ds_list_find_index(o_control.estavivo, idweb);
    if i != -1 {
        nnn = ds_list_find_value(o_control.losnombres, i);
    }
}
else {
    var i = ds_list_find_index(o_control.listadoestavivo, idweb);
    if i != -1 {
        nnn = ds_list_find_value(o_control.listadonombres, i);
    }
}
draw_text_transformed_colour(xi + 1, yi - 185 + anima[0] + anima[1], string_hash_to_newline(nnn),
    1.4, 1.4, 0, c_white, c_white, c_white, c_white, 1);
draw_text_transformed_colour(xi - 1, yi - 185 + anima[0] + anima[1], string_hash_to_newline(nnn),
    1.4, 1.4, 0, c_white, c_white, c_white, c_white, 1);
draw_text_transformed_colour(xi, yi - 185 + anima[0] + anima[1], string_hash_to_newline(nnn),
    1.4, 1.4, 0, c_black, c_black, c_black, c_black, 1);


