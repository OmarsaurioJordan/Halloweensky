///s_conexiones_del(ind);

with o_control {
    ds_list_delete(conexiones, argument0);
    ds_list_delete(estavivo, argument0);
    ds_list_delete(pinguser, argument0);
    ds_list_delete(tiemposinicios, argument0);
    ds_list_delete(estaconectado, argument0);
    ds_list_delete(losnombres, argument0);
    ds_list_delete(lasagujas, argument0);
    ds_list_delete(loseventos, argument0);
    ds_list_delete(losrespawns, argument0);
    if ds_list_empty(conexiones) {
        servidor = true;
    }
}

