// fogata
if tipo == 2 {
    if random(1) < 0.1 {
        if player != noone {
            escoliding = collision_circle(x, y, 96,
                player, true, false) != noone;
        }
        else {
            escoliding = false;
        }
    }
}


