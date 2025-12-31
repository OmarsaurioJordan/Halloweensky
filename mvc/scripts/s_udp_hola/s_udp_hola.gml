/// @description s_udp_hola(ip, tiempo);
/// @param ip
/// @param  tiempo

var buf = buffer_create(12, buffer_grow, 1);
buffer_seek(buf, buffer_seek_start, 0);
buffer_write(buf, buffer_u16, m_network_id);
buffer_write(buf, buffer_u8, 0); // hola
buffer_write(buf, buffer_u8, m_version);
buffer_write(buf, buffer_f64, argument1);
buffer_write(buf, buffer_string, o_control.nombre);
network_send_udp_raw(socket, argument0, m_puerto, buf, buffer_tell(buf));
buffer_delete(buf);

