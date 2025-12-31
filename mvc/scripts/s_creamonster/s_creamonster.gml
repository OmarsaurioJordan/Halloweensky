/// @description s_creamonster(tipo);
/// @param tipo
// ret: id de instancia

var aux = noone;
var dd = random(360);
var xx = 2048 + lengthdir_x(2000, dd);
var yy = 2048 + 250 + lengthdir_y(2000, dd);
switch argument0 {
    case m_ent_espectro:
    case m_ent_fantasma:
    case m_ent_errante:
    case m_ent_ente:
        aux = instance_create(xx, yy, o_astral);
        break;
    default:
        aux = instance_create(xx, yy, o_monstruo);
        break;
}
aux.tipo = argument0;
aux.sprite = s_sprite_monster(argument0);
// estadisticas de o_control
var i = ds_list_find_index(o_control.presentados, argument0);
if i != -1 {
    ds_list_delete(o_control.presentados, i);
}
return aux;

