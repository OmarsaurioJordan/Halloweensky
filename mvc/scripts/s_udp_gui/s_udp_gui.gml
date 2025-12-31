/// @description s_udp_gui();

var buf = buffer_create(16, buffer_grow, 1);
buffer_seek(buf, buffer_seek_start, 0);
buffer_write(buf, buffer_u16, m_network_id);
buffer_write(buf, buffer_u8, 3); // gui
buffer_write(buf, buffer_u8, o_control.aguja_gui);
o_control.aguja_gui++;
if o_control.aguja_gui > 255 {
    o_control.aguja_gui = 0;
}
// agregar informacion
with o_control {
    buffer_write(buf, buffer_u8, hora);
    buffer_write(buf, buffer_u16, dia);
    for (var i = 0; i < array_length_1d(materiales); i++) {
        buffer_write(buf, buffer_u16, materiales[i]);
    }
    // cargar lista
    var tot = ds_list_size(conexiones);
    buffer_write(buf, buffer_u8, tot + 1);
    buffer_write(buf, buffer_string, nombre);
    if player == noone {
        buffer_write(buf, buffer_u16, 0);
    }
    else {
        with player {
            buffer_write(buf, buffer_u16, idweb);
        }
    }
    for (var i = 0; i < tot; i++) {
        buffer_write(buf, buffer_string, ds_list_find_value(losnombres, i));
        buffer_write(buf, buffer_u16, ds_list_find_value(estavivo, i));
    }
}
// envio
var tell = buffer_tell(buf);
with o_control {
    for (var i = 0; i < ds_list_size(conexiones); i++) {
        network_send_udp_raw(socket, ds_list_find_value(conexiones, i),
            m_puerto, buf, tell);
    }
}
buffer_delete(buf);

