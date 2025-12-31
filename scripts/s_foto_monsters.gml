
var ente;
ente[0] = d_diablo;
ente[1] = d_bruja;
ente[2] = d_pulpo;
ente[3] = d_lobo;
ente[4] = d_vampiro;
ente[5] = d_monstruo;
ente[6] = d_calabaza;
ente[7] = d_robot;
ente[8] = d_frankenstein;
ente[9] = d_momia;
ente[10] = d_payaso;
ente[11] = d_asesino;
ente[12] = d_munneco;
ente[13] = d_sucubo;
ente[14] = d_incubo;
ente[15] = d_gordo;
ente[16] = d_esqueleto;
ente[17] = d_abominacion;
ente[18] = d_alien;
ente[19] = d_insecto;
ente[20] = d_siames;
ente[21] = d_espectro;
ente[22] = d_harpia;
ente[23] = d_ente;
var ancho_una = 180;
var alto_una = 406;
var desf_y = 355;
var porc_entre = 0.75;
var tot = array_length_1d(ente);
var sss = surface_create(ancho_una + ancho_una * max(0, tot - 1) * porc_entre, alto_una);
surface_set_target(sss);
draw_clear(c_white);
var xx;
for (var i = 0; i < tot; i++) {
    xx = ancho_una * 0.5 + ancho_una * porc_entre * i;
    draw_sprite(ente[i], 2, xx, desf_y);
    draw_sprite(ente[i], 3, xx, desf_y);
    draw_sprite(ente[i], 1, xx, desf_y);
    draw_sprite(ente[i], 0, xx, desf_y);
}
surface_reset_target();
surface_save(sss, "monsters.png");
surface_free(sss);

