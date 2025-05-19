///s_udp_crafting(idweb, herramienta);

var buf = buffer_create(7, buffer_fixed, 1);
buffer_seek(buf, buffer_seek_start, 0);
buffer_write(buf, buffer_u16, m_network_id);
buffer_write(buf, buffer_u8, 6); // crafting
buffer_write(buf, buffer_u8, o_control.aguja_evento);
o_control.aguja_evento++;
if o_control.aguja_evento > 255 {
    o_control.aguja_evento = 0;
}
buffer_write(buf, buffer_u16, argument0);
buffer_write(buf, buffer_u8, argument1);
// envio
var tell = buffer_tell(buf);
with o_control {
    for (var i = 0; i < ds_list_size(conexiones); i++) {
        network_send_udp_raw(socket, ds_list_find_value(conexiones, i),
            m_puerto, buf, tell);
    }
}
buffer_delete(buf);

