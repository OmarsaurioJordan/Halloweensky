///s_udp_posicion(ind_player);

var buf = buffer_create(11, buffer_fixed, 1);
buffer_seek(buf, buffer_seek_start, 0);
buffer_write(buf, buffer_u16, m_network_id);
buffer_write(buf, buffer_u8, 4); // posicion
buffer_write(buf, buffer_u8, o_control.aguja_player);
o_control.aguja_player++;
if o_control.aguja_player > 255 {
    o_control.aguja_player = 0;
}
with argument0 {
    buffer_write(buf, buffer_u16, idweb);
    // variables sobre las cuales el usuario tiene privilegios
    buffer_write(buf, buffer_u16, x);
    buffer_write(buf, buffer_u16, y);
    buffer_write(buf, buffer_u8, herramienta);
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

