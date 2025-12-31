/// @description s_udp_disparo(x, y, direccion, tipo, dehumano, origen, eshost);
/// @param x
/// @param  y
/// @param  direccion
/// @param  tipo
/// @param  dehumano
/// @param  origen
/// @param  eshost
// ret: id de o_proyectil

var aux = instance_create(argument0, argument1, o_proyectil);
aux.direction = argument2;
aux.tipo = argument3;
aux.dehumano = argument4;
aux.origen = argument5; // idweb
aux.eshost = argument6;
if argument6 {
    var buf = buffer_create(14, buffer_fixed, 1);
    buffer_seek(buf, buffer_seek_start, 0);
    buffer_write(buf, buffer_u16, m_network_id);
    buffer_write(buf, buffer_u8, 7); // disparo
    buffer_write(buf, buffer_u8, o_control.aguja_disparo);
    o_control.aguja_disparo++;
    if o_control.aguja_disparo > 255 {
        o_control.aguja_disparo = 0;
    }
    buffer_write(buf, buffer_u16, argument0);
    buffer_write(buf, buffer_u16, argument1);
    buffer_write(buf, buffer_u16, argument2);
    buffer_write(buf, buffer_u8, argument3);
    buffer_write(buf, buffer_u8, argument4);
    buffer_write(buf, buffer_u16, argument5);
    // envio
    var tell = buffer_tell(buf);
    with o_control {
        for (var i = 0; i < ds_list_size(conexiones); i++) {
            network_send_udp_raw(socket, ds_list_find_value(conexiones, i),
                m_puerto, buf, tell);
        }
    }
    buffer_delete(buf);
}
return aux;

