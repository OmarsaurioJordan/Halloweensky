/// @description Control

// conteo del tiempo
dlt = min(0.1, delta_time * 0.000001);
if servidor {
    var anth = hora;
    hora += dlt * m_vel_dia;
    // nuevo dia, amanecer
    if hora > 255 {
        hora -= 255;
        dia++;
        // luna
        var d = dia - 1;
        while d > 3 {
            d -= 4;
        }
        luna = d;
        // es nueva lunacion
        if luna == m_luna_creciente {
            if ds_list_empty(guion) {
                dificultad++;
            }
            else {
                ds_list_delete(guion, 0);
            }
        }
        // generacion humanos
        var puertas = instance_number(o_casa);
        var cupo = puertas * 2 - instance_number(o_humano);
        var gen;
        repeat cupo {
            if materiales[0] >= m_comida_humano {
                materiales[0] -= m_comida_humano;
                gen = instance_find(o_casa, irandom(puertas - 1));
                gen = instance_create(gen.x + random_range(-10, 10),
                    gen.y + random_range(-10, 10), o_humano);
                gen.genero = 2;
            }
            else {
                break;
            }
        }
        // codigo extra, no critico
        with o_humano {
            hogar = noone;
        }
    }
    // nueva noche, atardecer, generacion monstruos
    if anth < 127 and hora >= 127 {
        if primer_oleada {
            primer_oleada = false;
            // solo esqueletos
            s_oleada(s_dificultad(), false, m_ent_esqueleto, -1);
        }
        else if ds_list_empty(guion) {
            if !ds_list_empty(presentados) or random(1) < 0.5 {
                // agrupados hasta que todos se presenten
                s_oleada(s_dificultad(), true, -1, -1);
            }
            else {
                // todos mexclados
                s_oleada(s_dificultad(), false, -1, -1);
            }
        }
        else {
            // grupo especificos segun guion
            s_oleada(s_dificultad(), false, -1, ds_list_find_value(guion, 0));
        }
    }
}
else if random(1) < 0.1 {
    // luna para clientes
    var d = dia - 1;
    while d > 3 {
        d -= 4;
    }
    luna = d;
}

// hacer invisibles a los objetos fuera de vista
var vist = __view_get( e__VW.WView, 0 ) / 2;
var ppx = __view_get( e__VW.XView, 0 ) + vist;
var ppy = __view_get( e__VW.YView, 0 ) + vist + desfase_vision;
vist -= 16;
if !modo_editor {
    with o_visible {
        visible = point_distance(xi, yi, ppx, ppy) < vist;
    }
}

// posicionar la camara
if player == noone {
    s_cam_move();
}
else {
    var cmx = (player.x + o_mouse.x) / 2;
    var cmy = (player.y + o_mouse.y) / 2;
    var dist = point_distance(ppx, ppy, cmx, cmy);
    if dist > 16 {
        direction = point_direction(ppx, ppy, cmx, cmy);
        dist = min(m_velocidad * 2, dist * dlt * 2);
        __view_set( e__VW.XView, 0, __view_get( e__VW.XView, 0 ) + (lengthdir_x(dist, direction)) );
        __view_set( e__VW.YView, 0, __view_get( e__VW.YView, 0 ) + (lengthdir_y(dist, direction)) );
        s_cam_limit();
    }
}

// broadcast busca equipos
if reloj_broadcast != -1 {
    reloj_broadcast -= dlt;
    if reloj_broadcast <= 0 {
        s_udp_hola(ip_broadcast + string(puerto_broadcast), tiempo_inicio);
        puerto_broadcast++;
        if puerto_broadcast >= 255 {
            reloj_broadcast = -1;
        }
        else {
            reloj_broadcast = 0.05;
        }
        
    }
}

// disminuir ping
for (var i = ds_list_size(pinguser) - 1; i >= 0; i--) {
    var p = ds_list_find_value(pinguser, i) - dlt;
    if p <= 0 {
        s_conexiones_del(i);
    }
    else {
        ds_list_replace(pinguser, i, p);
    }
}

// enviar datos
if servidor {
    reloj_entes -= dlt;
    if reloj_entes <= 0 {
        reloj_entes = random_range(0.1, 0.2);
        s_udp_entes();
    }
    reloj_gui -= dlt;
    if reloj_gui <= 0 {
        reloj_gui = random_range(1, 2);
        s_udp_gui();
    }
}
else {
    reloj_player -= dlt;
    if reloj_player <= 0 {
        reloj_player = random_range(0.1, 0.2);
        if player != noone {
            s_udp_posicion(player);
        }
        else {
            s_udp_ping();
        }
    }
}

// obtener fantasmas
if random(1) < 0.1 {
    estadisticas[2] = instance_number(o_astral);
}

// respawn jugadores
if servidor {
    // jugador del servidor
    if player == noone {
        reloj_respawn -= dlt;
        if reloj_respawn <= 0 {
            player = s_deme_disponible();
            if player == noone {
                reloj_respawn = 1;
            }
            else {
                reloj_respawn = m_respawn_s;
            }
        }
    }
    // otros jugadores
    var rr;
    for (var i = 0; i < ds_list_size(losrespawns); i++) {
        if ds_list_find_value(estavivo, i) == 0 {
            rr = ds_list_find_value(losrespawns, i) - dlt;
            if rr <= 0 {
                var quien = s_deme_disponible();
                if quien == noone {
                    ds_list_replace(losrespawns, i, 1);
                }
                else {
                    ds_list_replace(losrespawns, i, m_respawn_s);
                    ds_list_replace(estavivo, i, quien.idweb);
                }
            }
            else {
                ds_list_replace(losrespawns, i, rr);
            }
        }
    }
}

// comandos
if keyboard_check_pressed(vk_anykey) {
    switch keyboard_key {
        
        case vk_escape: // salir
            game_end();
            break;
        
        case vk_f1: // ayuda y titulo
            break;
        
        case vk_f2: // cambio IP
            if dialog_ip == -1 {
                dialog_ip = get_string_async("Type the LAN IP " +
                    "(change requires restart), " +
                    "def: 192.168.1.x", ip_broadcast + "x");
            }
            break;
        
        case vk_f3: // manual PDF
            break;
    }
}


