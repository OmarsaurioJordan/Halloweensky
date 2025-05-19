///s_udp_shutdown(ip, ind_error);

var buf = buffer_create(4, buffer_fixed, 1);
buffer_seek(buf, buffer_seek_start, 0);
buffer_write(buf, buffer_u16, m_network_id);
buffer_write(buf, buffer_u8, 1); // shutdown
buffer_write(buf, buffer_u8, argument1);
network_send_udp_raw(socket, argument0, m_puerto, buf, buffer_tell(buf));
buffer_delete(buf);

