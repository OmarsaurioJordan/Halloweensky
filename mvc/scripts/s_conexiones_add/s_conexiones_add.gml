/// @description s_conexiones_add(ip, tiempo_ini, clear, nombre);
/// @param ip
/// @param  tiempo_ini
/// @param  clear
/// @param  nombre

with o_control {
    if argument2 {
        ds_list_clear(conexiones);
        ds_list_clear(estavivo);
        ds_list_clear(pinguser);
        ds_list_clear(tiemposinicios);
        ds_list_clear(estaconectado);
        ds_list_clear(losnombres);
        ds_list_clear(lasagujas);
        ds_list_clear(loseventos);
        ds_list_clear(losrespawns);
    }
    if nombre == argument3 {
        s_udp_shutdown(argument0, m_error_nombre);
    }
    else {
        var p = ds_list_find_index(conexiones, argument0);
        if p == -1 {
            if ds_list_find_index(losnombres, argument3) != -1 {
                s_udp_shutdown(argument0, m_error_nombre);
            }
            else {
                ds_list_add(conexiones, argument0);
                ds_list_add(estavivo, 0);
                ds_list_add(pinguser, m_ping);
                ds_list_add(tiemposinicios, argument1);
                ds_list_add(estaconectado, false);
                ds_list_add(losnombres, argument3);
                ds_list_add(lasagujas, 0);
                ds_list_add(loseventos, 0);
                ds_list_add(losrespawns, m_respawn_s);
                s_udp_hola(argument0, tiempo_inicio);
            }
        }
        else if ds_list_find_index(losnombres, argument3) == p {
            ds_list_replace(estaconectado, p, true);
        }
        else {
            s_udp_shutdown(argument0, m_error_nombre);
        }
    }
}

