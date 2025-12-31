/// @description s_udp_entes();

var buf = buffer_create(10, buffer_grow, 1);
buffer_seek(buf, buffer_seek_start, 0);
buffer_write(buf, buffer_u16, m_network_id);
buffer_write(buf, buffer_u8, 2); // entes
buffer_write(buf, buffer_u8, o_control.aguja_entes);
o_control.aguja_entes++;
if o_control.aguja_entes > 255 {
    o_control.aguja_entes = 0;
}
// agregar entes
o_control.estadisticas[0] = instance_number(o_humano);
buffer_write(buf, buffer_u16, o_control.estadisticas[0]);
with o_humano {
    buffer_write(buf, buffer_u16, idweb);
    buffer_write(buf, buffer_u16, x);
    buffer_write(buf, buffer_u16, y);
    buffer_write(buf, buffer_u8, genero);
    buffer_write(buf, buffer_u8, herramienta);
    for (var e = 0; e < m_herr_total; e++) {
        buffer_write(buf, buffer_u8, ds_list_find_value(municiones, e));
    }
    buffer_write(buf, buffer_u8, material);
    buffer_write(buf, buffer_u8, vida);
    buffer_write(buf, buffer_s8, flag_herramienta);
    flag_herramienta = -1;
}
o_control.estadisticas[1] = instance_number(o_monstruo);
buffer_write(buf, buffer_u16, o_control.estadisticas[1]);
with o_monstruo {
    buffer_write(buf, buffer_u16, idweb);
    buffer_write(buf, buffer_u16, x);
    buffer_write(buf, buffer_u16, y);
    buffer_write(buf, buffer_u8, tipo);
}
buffer_write(buf, buffer_u16, instance_number(o_animal));
with o_animal {
    buffer_write(buf, buffer_u16, idweb);
    buffer_write(buf, buffer_u16, x);
    buffer_write(buf, buffer_u16, y);
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

