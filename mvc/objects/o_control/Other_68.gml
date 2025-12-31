/// @description UDP

var receive_ip = ds_map_find_value(async_load, "ip");
var buf = ds_map_find_value(async_load, "buffer");
buffer_seek(buf, buffer_seek_start, 0);
if buffer_read(buf, buffer_u16) == m_network_id {
    switch buffer_read(buf, buffer_u8) {
        
        case 0: // hola
            var version = buffer_read(buf, buffer_u8);
            var otro_inicio = buffer_read(buf, buffer_f64);
            var otro_nombre = buffer_read(buf, buffer_string);
            if tiempo_inicio == otro_inicio {
                // nada, es el mismo PC
            }
            else if version > m_version {
                show_message("Error, obsolete version");
                game_end();
            }
            else if version < m_version {
                s_udp_shutdown(receive_ip, m_error_version);
            }
            else if servidor {
                if otro_inicio < tiempo_inicio {
                    // otro es servidor
                    servidor = false;
                    s_conexiones_add(receive_ip, otro_inicio, true, otro_nombre);
                }
                else {
                    // sigue siendo servidor y agrega al cliente
                    s_conexiones_add(receive_ip, otro_inicio, false, otro_nombre);
                }
            }
            else if otro_inicio < tiempo_inicio {
                var okey = ds_list_empty(conexiones);
                if !okey {
                    okey = otro_inicio < ds_list_find_value(tiemposinicios, 0);
                }
                if okey {
                    // otro es servidor
                    s_conexiones_add(receive_ip, otro_inicio, true, otro_nombre);
                }
            }
            else if ds_list_empty(conexiones) {
                // ahora es servidor
                servidor = true;
                s_conexiones_add(receive_ip, otro_inicio, true, otro_nombre);
            }
            break;
        
        case 1: // shutdown
            var cod = buffer_read(buf, buffer_u8);
            switch cod {
                case m_error_version:
                    show_message("Error, obsolete version");
                    break;
                case m_error_nombre:
                    show_message("Error, repeated name in the network");
                    break;
            }
            game_end();
            break;
        
        case 2: // entes
            if !servidor {
                var aguja = buffer_read(buf, buffer_u8);
                if aguja > aguja_entes or (aguja_entes - aguja) > 127 {
                    aguja_entes = aguja;
                }
                else {
                    break;
                }
                // leer humanos
                var tot = buffer_read(buf, buffer_u16);
                estadisticas[0] = tot;
                with o_humano {
                    sacarlo = true;
                }
                var receive, aux, munis;
                repeat tot {
                    receive[0] = buffer_read(buf, buffer_u16); // idweb
                    receive[1] = buffer_read(buf, buffer_u16); // x
                    receive[2] = buffer_read(buf, buffer_u16); // y
                    receive[3] = buffer_read(buf, buffer_u8); // genero
                    receive[4] = buffer_read(buf, buffer_u8); // herramienta
                    for (var e = 0; e < m_herr_total; e++) { // municiones
                        munis[e] = buffer_read(buf, buffer_u8);
                    }
                    receive[5] = buffer_read(buf, buffer_u8); // material
                    receive[6] = buffer_read(buf, buffer_u8); // vida
                    receive[7] = buffer_read(buf, buffer_s8); // flag_herramienta
                    aux = noone;
                    with o_humano {
                        if idweb == receive[0] {
                            if player != id {
                                x = receive[1];
                                y = receive[2];
                                herramienta = receive[4];
                            }
                            sacarlo = false;
                            aux = id;
                            break;
                        }
                    }
                    if aux == noone {
                        aux = instance_create(receive[1], receive[2], o_humano);
                        aux.idweb = receive[0];
                        aux.herramienta = receive[4];
                    }
                    with aux {
                        genero = receive[3];
                        for (var e = 0; e < m_herr_total; e++) {
                            ds_list_replace(municiones, e, munis[e]);
                        }
                        material = receive[5];
                        vida = receive[6];
                        if receive[7] != -1 {
                            herramienta = receive[7];
                        }
                    }
                }
                with o_humano {
                    if sacarlo {
                        instance_destroy();
                    }
                }
                // leer monstruos
                tot = buffer_read(buf, buffer_u16);
                estadisticas[1] = tot;
                with o_monstruo {
                    sacarlo = true;
                }
                repeat tot {
                    receive[0] = buffer_read(buf, buffer_u16); // idweb
                    receive[1] = buffer_read(buf, buffer_u16); // x
                    receive[2] = buffer_read(buf, buffer_u16); // y
                    receive[3] = buffer_read(buf, buffer_u8); // tipo
                    aux = noone;
                    with o_monstruo {
                        if idweb == receive[0] {
                            x = receive[1];
                            y = receive[2];
                            sacarlo = false;
                            if tipo != receive[3] {
                                tipo = receive[3];
                                sprite = s_sprite_monster(receive[3]);
                            }
                            aux = id;
                            break;
                        }
                    }
                    if aux == noone {
                        aux = instance_create(receive[1], receive[2], o_monstruo);
                        aux.tipo = receive[3];
                        aux.sprite = s_sprite_monster(receive[3]);
                        aux.idweb = receive[0];
                    }
                }
                with o_monstruo {
                    if sacarlo {
                        instance_destroy();
                    }
                }
                // leer animales
                tot = buffer_read(buf, buffer_u16);
                with o_animal {
                    sacarlo = true;
                }
                repeat tot {
                    receive[0] = buffer_read(buf, buffer_u16); // idweb
                    receive[1] = buffer_read(buf, buffer_u16); // x
                    receive[2] = buffer_read(buf, buffer_u16); // y
                    aux = noone;
                    with o_animal {
                        if idweb == receive[0] {
                            x = receive[1];
                            y = receive[2];
                            sacarlo = false;
                            aux = id;
                            break;
                        }
                    }
                    if aux == noone {
                        aux = instance_create(receive[1], receive[2], o_animal);
                        aux.idweb = receive[0];
                    }
                }
                with o_animal {
                    if sacarlo {
                        instance_destroy();
                    }
                }
                // resetear ping
                var p = ds_list_find_index(conexiones, receive_ip);
                if p != -1 {
                    ds_list_replace(pinguser, p, m_ping);
                }
            }
            break;
        
        case 3: // gui
            if !servidor {
                var aguja = buffer_read(buf, buffer_u8);
                if aguja > aguja_gui or (aguja_gui - aguja) > 127 {
                    aguja_gui = aguja;
                }
                else {
                    break;
                }
                // leer datos
                hora = buffer_read(buf, buffer_u8);
                dia = buffer_read(buf, buffer_u16);
                for (var i = 0; i < array_length_1d(materiales); i++) {
                    materiales[i] = buffer_read(buf, buffer_u16);
                }
                // crear lista
                ds_list_clear(listadonombres);
                ds_list_clear(listadoestavivo);
                var tot = buffer_read(buf, buffer_u8);
                var receive;
                repeat tot {
                    receive[0] = buffer_read(buf, buffer_string);
                    receive[1] = buffer_read(buf, buffer_u16);
                    if nombre == receive[0] {
                        if receive[1] == 0 {
                            player = noone;
                        }
                        else {
                            with o_humano {
                                if idweb == receive[1] {
                                    player = id;
                                    break;
                                }
                            }
                        }
                    }
                    else {
                        ds_list_add(listadonombres, receive[0]);
                        ds_list_add(listadoestavivo, receive[1]);
                    }
                }
            }
            break;
        
        case 4: // posicion
            if servidor {
                var aguja = buffer_read(buf, buffer_u8);
                var receive;
                receive[0] = buffer_read(buf, buffer_u16); // idweb
                receive[1] = buffer_read(buf, buffer_u16); // x
                receive[2] = buffer_read(buf, buffer_u16); // y
                receive[3] = buffer_read(buf, buffer_u8); // herramienta
                var i = ds_list_find_index(conexiones, receive_ip);
                if i == -1 {
                    break;
                }
                if ds_list_find_value(estavivo, i) != receive[0] {
                    break;
                }
                var a = ds_list_find_value(lasagujas, i);
                if aguja > a or (a - aguja) > 127 {
                    ds_list_replace(lasagujas, i, aguja);
                }
                else {
                    break;
                }
                with o_humano {
                    if idweb == receive[0] {
                        x = receive[1];
                        y = receive[2];
                        herramienta = receive[3];
                        break;
                    }
                }
                // resetear ping
                var p = ds_list_find_index(conexiones, receive_ip);
                if p != -1 {
                    ds_list_replace(pinguser, p, m_ping);
                }
            }
            break;
        
        case 5: // ping solamente
            var p = ds_list_find_index(conexiones, receive_ip);
            if p != -1 {
                ds_list_replace(pinguser, p, m_ping);
            }
            break;
        
        case 6: // crafting
            if servidor {
                var aguja = buffer_read(buf, buffer_u8);
                var receive;
                receive[0] = buffer_read(buf, buffer_u16); // idweb
                receive[1] = buffer_read(buf, buffer_u8); // herramienta
                var i = ds_list_find_index(conexiones, receive_ip);
                if i == -1 {
                    break;
                }
                if ds_list_find_value(estavivo, i) != receive[0] {
                    break;
                }
                var a = ds_list_find_value(loseventos, i);
                if aguja > a or (a - aguja) > 127 {
                    ds_list_replace(loseventos, i, aguja);
                }
                else {
                    break;
                }
                s_crafting(receive[0], receive[1]);
            }
            break;
        
        case 7: // disparo
            var aguja = buffer_read(buf, buffer_u8);
            var receive;
            receive[0] = buffer_read(buf, buffer_u16); // x
            receive[1] = buffer_read(buf, buffer_u16); // y
            receive[2] = buffer_read(buf, buffer_u16); // direccion
            receive[3] = buffer_read(buf, buffer_u8); // tipo
            receive[4] = buffer_read(buf, buffer_u8); // dehumano
            receive[5] = buffer_read(buf, buffer_u16); // origen idweb
            // verificar que no se repite
            var ticket = string(receive[5]) + "_" + string(aguja);
            if ds_list_find_index(listadisparos, ticket) != -1 {
                break;
            }
            ds_list_add(listadisparos, ticket);
            ds_list_delete(listadisparos, 0);
            s_udp_disparo(receive[0], receive[1], receive[2],
                receive[3], receive[4], receive[5], false);
            // funciones propias del servidor
            if servidor {
                // disminuir municion
                with o_humano {
                    if idweb == receive[5] {
                        var mmm = ds_list_find_value(municiones, receive[3]);
                        ds_list_replace(municiones, receive[3], max(0, mmm - 1));
                        break;
                    }
                }
                // re-envio
                var tell = ds_map_find_value(async_load, "size");
                var ipp;
                for (var c = 0; c < ds_list_size(conexiones); c++) {
                    ipp = ds_list_find_value(conexiones, c);
                    if ipp != receive_ip {
                        network_send_udp_raw(socket, ipp, m_puerto, buf, tell);
                    }
                }
            }
            break;
        
        case 8: // intercambio
            if servidor {
                var aguja = buffer_read(buf, buffer_u8);
                var receive;
                receive[0] = buffer_read(buf, buffer_u16); // idweb1
                receive[1] = buffer_read(buf, buffer_u16); // idweb2
                var i = ds_list_find_index(conexiones, receive_ip);
                if i == -1 {
                    break;
                }
                if ds_list_find_value(estavivo, i) != receive[0] {
                    break;
                }
                var a = ds_list_find_value(loseventos, i);
                if aguja > a or (a - aguja) > 127 {
                    ds_list_replace(loseventos, i, aguja);
                }
                else {
                    break;
                }
                var t = 0;
                for (var i = 0; i < 2; i++) {
                    with o_humano {
                        if idweb == receive[i] {
                            receive[i] = id;
                            t++;
                            break;
                        }
                    }
                }
                if t == 2 {
                    s_intercambio(receive[0], receive[1]);
                }
            }
            break;
    }
}
buffer_delete(buf);


