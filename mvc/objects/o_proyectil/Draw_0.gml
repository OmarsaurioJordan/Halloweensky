var d = 0;
if tipo == 12 or tipo == 13 {
    d = direction;
}
if dehumano {
    draw_sprite_ext(d_proyectil, tipo, x, y - 100,
        1, 1, d, c_white, 1);
}
else {
    draw_sprite_ext(d_proyectol, tipo, x, y - 100,
        1, 1, d, c_white, 1);
}


