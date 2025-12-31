/// @description s_oleada(dificultad, agrupar, tipo_monster, forzagrupo);
/// @param dificultad
/// @param  agrupar
/// @param  tipo_monster
/// @param  forzagrupo

var poblacion = argument0;
// crear un mismo tipo de monstruo
if argument2 != -1 {
    var t = s_letalidad_monster(argument2);
    while poblacion > 0 {
        if poblacion - t >= 0 {
            poblacion -= t;
            s_creamonster(argument2);
        }
        else {
            break;
        }
    }
}
// crear monstruos exactamente del grupo dado
else if argument3 != -1 {
    var m, t;
    var rep = true;
    var u = s_dado_luna(argument3);
    var f = 100;
    while f > 0 and poblacion > 0 {
        m = irandom(m_ent_ente);
        if s_grupo_monster(m) != argument3 {
            continue;
        }
        t = s_letalidad_monster(m);
        if t != u {
            if rep {
                f--;
            }
            continue;
        }
        if poblacion - t >= 0 {
            poblacion -= t;
            s_creamonster(m);
            u = s_dado_luna(argument3);
            rep = false;
        }
        else {
            f--;
        }
    }
}
// crear diferentes monstruos pero del mismo grupo
else if argument1 {
    var m, t, f, g, u;
    var rep = true;
    while rep {
        g = irandom_range(m_grupo_humano, m_grupo_vampirico);
        u = s_dado_luna(g);
        f = 100;
        while f > 0 and poblacion > 0 {
            m = irandom(m_ent_ente);
            if s_grupo_monster(m) != g {
                continue;
            }
            t = s_letalidad_monster(m);
            if t != u {
                if rep {
                    f--;
                }
                continue;
            }
            if poblacion - t >= 0 {
                poblacion -= t;
                s_creamonster(m);
                u = s_dado_luna(g);
                rep = false;
            }
            else {
                f--;
            }
        }
    }
}
// crear todo tipo de monstruos
else {
    var m, t;
    var u = s_dado_luna(-1);
    var f = 100;
    while f > 0 and poblacion > 0 {
        m = irandom(m_ent_ente);
        if s_grupo_monster(m) == m_grupo_fantasmal {
            continue;
        }
        t = s_letalidad_monster(m);
        if t != u {
            continue;
        }
        if poblacion - t >= 0 {
            poblacion -= t;
            s_creamonster(m);
            u = s_dado_luna(-1);
        }
        else {
            f--;
        }
    }
}

