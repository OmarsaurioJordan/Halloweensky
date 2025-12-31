/// @description s_crafting(idweb, herramienta);
/// @param idweb
/// @param  herramienta

var aux = noone;
with o_humano {
    if idweb == argument0 {
        aux = id;
        break;
    }
}
if aux != noone { with aux {
    var que = argument1;
    var mok = o_control.costo[que, 0] <= o_control.materiales[1];
    var hok = o_control.costo[que, 1] <= o_control.materiales[2];
    if mok and hok and que != 0 and (que < m_herrx_escudin or material != que - 11) {
        o_control.materiales[1] -= o_control.costo[que, 0];
        o_control.materiales[2] -= o_control.costo[que, 1];
        if que < m_herrx_escudin {
            var act = ds_list_find_value(municiones, que);
            ds_list_replace(municiones, que, min(255, act + o_control.costo[que, 2]));
            herramienta = que;
            flag_herramienta = que;
        }
        else {
            material = que - 11;
        }
    }
} }

