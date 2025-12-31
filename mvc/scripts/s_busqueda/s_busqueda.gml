/// @description s_busqueda(id, vision, objetivo);
/// @param id
/// @param  vision
/// @param  objetivo
//ret: unidad encontrada o noone

var aux;
var blanco = noone;
var lista = ds_priority_create();
with argument2 {
    aux = point_distance(x, y, argument0.x, argument0.y);
    if aux <= argument1 {
        ds_priority_add(lista, id, aux);
    }
}
while !ds_priority_empty(lista) {
    aux = ds_priority_delete_min(lista);
    if !collision_line(aux.x, aux.y, argument0.x, argument0.y, o_bloque, true, false) {
        blanco = aux;
        break;
    }
}
ds_priority_destroy(lista);
return blanco;

