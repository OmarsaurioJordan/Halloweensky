if player == id {
    player = noone;
}
var p = ds_list_find_index(o_control.estavivo, idweb);
if p != -1 {
    ds_list_replace(o_control.estavivo, p, 0);
}
ds_list_destroy(municiones);


