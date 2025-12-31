// animacion
s_ani_osci(id, 0, 2.5, 5); // body
s_ani_osci(id, 1, 2.2, 3); // cara
s_ani_osci(id, 2, 1.9, 4); // objeto
s_ani_paso(id, 0, 0.15, 5); // pies

// iluminacion
reloj_luz -= dlt;
if reloj_luz <= 0 {
    reloj_luz = random_range(0.5, 2);
    radio = random_range(0.8, 1.2);
}

// reloj para poder atacar o accionar
reloj_cadencia = max(0, reloj_cadencia - dlt);

// movimiento manual
if player == id {
    
    // caminar
    if !s_colision(id) {
        s_manejo(id);
        if direction != 1 {
            var vel = m_velocidad * dlt;
            x += lengthdir_x(vel, direction);
            y += lengthdir_y(vel, direction);
        }
    }
    
    // cambiar de herramienta
    if mouse_wheel_down() {
        if !s_cambio_fogata(true) {
            var ant = herramienta;
            do {
                herramienta++;
                if herramienta >= m_herr_total {
                    herramienta = 0;
                }
            }
            until ant == herramienta or ds_list_find_value(municiones, herramienta) != 0;
        }
    }
    else if mouse_wheel_up() {
        if !s_cambio_fogata(false) {
            var ant = herramienta;
            do {
                herramienta--;
                if herramienta < 0 {
                    herramienta = m_herr_total - 1;
                }
            }
            until ant == herramienta or ds_list_find_value(municiones, herramienta) != 0;
        }
    }
    
    // acciones de clic derecho
    if mouse_check_button_pressed(mb_right) {
        // hacer crafting
        var foga = s_en_fogata();
        if foga {
            var que = o_control.paraventa;
            var mok = o_control.costo[que, 0] <= o_control.materiales[1];
            var hok = o_control.costo[que, 1] <= o_control.materiales[2];
            if mok and hok and que != 0 and (que < m_herrx_escudin or material != que - 11) {
                if servidor {
                    s_crafting(idweb, que);
                }
                else {
                    s_udp_crafting(idweb, que);
                }
            }
        }
        // intercambiar objeto
        else {
            foga = collision_circle(x, y, 48, o_humano, true, true);
            if foga != noone {
                if foga.genero != 2 {
                    if servidor {
                        s_intercambio(id, foga);
                    }
                    else {
                        s_udp_intercambio(idweb, foga.idweb);
                    }
                }
            }
        }
    }
    
    // acciones de clic izquierdo
    if mouse_check_button(mb_left) {
        var mmm = ds_list_find_value(municiones, herramienta);
        if reloj_cadencia == 0 and mmm > 0 {
            reloj_cadencia = o_control.costo[herramienta, 3];
            // ataque dependiendo del arma
            switch herramienta {
                case m_herr_guitarra:
                case m_herr_tambor:
                case m_herr_explosivo:
                case m_herr_ballesta:
                case m_herr_lanza:
                case m_herr_pistola:
                case m_herr_escopeta:
                case m_herr_rifle:
                case m_herr_metralla:
                case m_herr_baculo:
                    ds_list_replace(municiones, herramienta, mmm - 1);
                    var ddd = point_direction(xi, yi, o_mouse.x, o_mouse.y);
                    s_udp_disparo(xi, yi, ddd, herramienta, true, idweb, true);
                    break;
            }
        }
    }
}
// movimiento autonomo IA
else if servidor {
    
    // errar
    if s_errar_reloj(id) and random(1) < 0.25 {
        var cc = instance_find(o_casa, irandom(instance_number(o_casa) - 1));
        direction = point_direction(x, y, cc.x, cc.y);
        direction += random_range(-45, 45);
        if point_distance(x, y, cc.x, cc.y) < 150 {
            moverse = false;
        }
    }
    
    // objservar enemigos cercanos
    if random(1) < 0.1 {
        blanco = s_busqueda(id, m_vision, o_monstruo);
        if blanco != noone {
            dir_hulle = point_direction(blanco.x, blanco.y, x, y);
        }
    }
    else if blanco != noone {
        if instance_exists(blanco) {
            if random(1) < 0.1 {
                if point_distance(x, y, blanco.x, blanco.y) > m_vision {
                    blanco = noone;
                }
            }
        }
        else {
            blanco = noone;
        }
    }
    
    // IA
    if !s_colision(id) {
        // hay enemigo cerca, huir
        if blanco != noone {
            reloj_esquive -= dlt;
            if reloj_esquive <= 0 {
                reloj_esquive = random_range(1, 3);
                if point_distance(2048, 2048 + 250, x, y) > 1900 {
                    dir_hulle = point_direction(x, y, 2048, 2048 + 250);
                }
                else {
                    dir_hulle = point_direction(blanco.x, blanco.y, x, y);
                }
                dir_hulle += random_range(-90, 90);
            }
            var vel = m_velocidad * dlt;
            x += lengthdir_x(vel, dir_hulle);
            y += lengthdir_y(vel, dir_hulle);
        }
        // esta de dia
        else if hora < 127 {
            // el infante solo deambula
            if genero == 2 {
                if moverse {
                    var vel = m_velocidad * dlt;
                    x += lengthdir_x(vel, direction);
                    y += lengthdir_y(vel, direction);
                }
            }
            // el adulto trabaja
            else {
            switch material {
                case m_mat_nada:
                    // buscar fuente de materiales para ir por ellos
                    if trabajo == noone {
                        var sum = 0;
                        for (var i = 0; i < 3; i++) {
                            sum += o_control.materiales[i];
                        }
                        sum = max(1, sum);
                        var posibilit = ds_list_create();
                        ds_list_add(posibilit, m_mat_maiz, m_mat_madera, m_mat_metal);
                        var q;
                        for (var i = 0; i < 3; i++) {
                            q = ds_list_find_value(posibilit, i);
                            repeat round((1 - o_control.materiales[i] / sum) * 10) {
                                ds_list_add(posibilit, q);
                            }
                        }
                        ds_list_shuffle(posibilit);
                        var que = ds_list_find_value(posibilit, 0);
                        ds_list_destroy(posibilit);
                        var ttt = instance_number(o_recurso);
                        do {
                            trabajo = instance_find(o_recurso, irandom(ttt - 1));
                            if trabajo.material != que {
                                trabajo = noone;
                            }
                        }
                        until trabajo != noone;
                    }
                    // ajustar curso hacia el recurso
                    reloj_esquive -= dlt;
                    if reloj_esquive <= 0 {
                        reloj_esquive = random_range(1, 3);
                        dir_hulle = point_direction(x, y, trabajo.x, trabajo.y);
                        dir_hulle += random_range(-45, 45);
                    }
                    // ir hacia el recurso de vez en cuando
                    if moverse {
                        var vel = m_velocidad * dlt;
                        x += lengthdir_x(vel, dir_hulle);
                        y += lengthdir_y(vel, dir_hulle);
                    }
                    // desvincular trabajo
                    if trabajo.fogata {
                        trabajo = noone;
                    }
                    break;
                case m_mat_metal:
                case m_mat_hierro:
                case m_mat_maiz:
                case m_mat_pan:
                case m_mat_madera:
                case m_mat_tronco:
                    // buscar la fogata para entregar materiales
                    if trabajo == noone {
                        with o_recurso {
                            if fogata {
                                other.trabajo = id;
                                break;
                            }
                        }
                    }
                    // ajustar curso hacia la fogata
                    reloj_esquive -= dlt;
                    if reloj_esquive <= 0 {
                        reloj_esquive = random_range(1, 3);
                        dir_hulle = point_direction(x, y, trabajo.x, trabajo.y);
                        dir_hulle += random_range(-45, 45);
                    }
                    // ir hacia la fogata de vez en cuando
                    if moverse {
                        var vel = m_velocidad * dlt;
                        x += lengthdir_x(vel, dir_hulle);
                        y += lengthdir_y(vel, dir_hulle);
                    }
                    // desvincular trabajo
                    if !trabajo.fogata {
                        trabajo = noone;
                    }
                    break;
                case m_mat_medicina:
                    // buscar humanos para curarlos
                    if moverse {
                        var vel = m_velocidad * dlt;
                        x += lengthdir_x(vel, direction);
                        y += lengthdir_y(vel, direction);
                    }
                    break;
                case m_mat_escudo:
                case m_mat_escudin:
                    // buscar humanos para protegerlos
                    if moverse {
                        var vel = m_velocidad * dlt;
                        x += lengthdir_x(vel, direction);
                        y += lengthdir_y(vel, direction);
                    }
                    break;
                default: // bolsa, irse del mapa por el camino
                    if moverse {
                        var vel = m_velocidad * dlt;
                        x += lengthdir_x(vel, direction);
                        y += lengthdir_y(vel, direction);
                    }
                    break;
            } }
        }
        // esta de noche
        else {
            // buscar una casa acorde
            if hogar == noone {
                hogar = instance_find(o_casa,
                    irandom(instance_number(o_casa) - 1));
            }
            // ajustar curso hacia la fogata
            reloj_esquive -= dlt;
            if reloj_esquive <= 0 {
                reloj_esquive = random_range(1, 3);
                dir_hulle = point_direction(x, y, hogar.x, hogar.y);
                dir_hulle += random_range(-45, 45);
            }
            // ir hacia la casa
            if point_distance(x, y, hogar.x, hogar.y) > 150 {
                var vel = m_velocidad * dlt;
                x += lengthdir_x(vel, dir_hulle);
                y += lengthdir_y(vel, dir_hulle);
            }
        }
    }
}

// otras acciones oficiales de servidor
if servidor {
    
    // crecer si es infante
    if genero == 2 {
        reloj_adultez -= dlt;
        if reloj_adultez <= 0 {
            reloj_adultez = 0;
            genero = irandom(1);
            vida = m_vida;
        }
    }
    // obtener recursos si no es infante
    else {
        var otr = instance_place(x, y, o_recurso);
        if otr != noone {
            if otr.fogata {
                switch material {
                    case m_mat_pan:
                        o_control.materiales[0]++;
                        material = m_mat_nada;
                        break;
                    case m_mat_tronco:
                        o_control.materiales[1]++;
                        material = m_mat_nada;
                        break;
                    case m_mat_hierro:
                        o_control.materiales[2]++;
                        material = m_mat_nada;
                        break;
                }
            }
            else if otr.material != m_mat_nada and material < m_mat_escudin {
                material = otr.material;
                reloj_material = m_refinar_s;
            }
        }
        reloj_material -= dlt;
        if reloj_material <= 0 {
            reloj_material = m_refinar_s;
            switch material {
                case m_mat_metal:
                case m_mat_maiz:
                case m_mat_madera:
                    material++;
                    break;
            }
        }
    }
}

// resetear ind de herramienta sin municion
if random(1) < 0.1 {
    if ds_list_find_value(municiones, herramienta) == 0 {
        var ant = herramienta;
        do {
            herramienta++;
            if herramienta >= m_herr_total {
                herramienta = 0;
            }
        }
        until ant == herramienta or ds_list_find_value(municiones, herramienta) != 0;
        if ant == herramienta {
            herramienta = m_herr_nada;
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


