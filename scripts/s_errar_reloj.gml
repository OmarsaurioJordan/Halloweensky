///s_errar_reloj(id);
// requiere id con reloj_errar y moverse
// ret: true si disparo al iniciar movimiento

var ok = false;
with argument0 {
    reloj_errar -= dlt;
    if reloj_errar <= 0 {
        reloj_errar = m_errar_s + random(m_errar_s);
        if moverse {
            moverse = choose(true, true, false);
            direction += random_range(-90, 90);
        }
        else {
            moverse = choose(false, false, true);
            direction = random(360);
            ok = moverse;
        }
    }
}
return ok;

