// pies
if reloj_pies == 0 {
    draw_sprite(d_animal, 2, xi, yi);
    draw_sprite(d_animal, 3, xi, yi);
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
    draw_sprite(d_animal, 2, xi, yi - p1 * 12);
    draw_sprite(d_animal, 3, xi, yi - p2 * 12);
}
// cuerpo y cabeza
draw_sprite(d_animal, 1, xi, yi + anima[0]);


