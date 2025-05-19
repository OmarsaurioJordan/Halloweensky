///s_deme_disponible();
// ret: id de jugador disponible o noone

var res = noone;
var disponiblis = ds_list_create();
with o_humano {
    if genero != 2 and ds_list_find_index(o_control.estavivo, idweb) == -1 {
        ds_list_add(disponiblis, id);
    }
}
if !ds_list_empty(disponiblis) {
    ds_list_shuffle(disponiblis);
    res = ds_list_find_value(disponiblis, 0);
    res.vida = m_vida;
}
ds_list_destroy(disponiblis);
return res;

