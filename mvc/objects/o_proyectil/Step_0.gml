// eliminacion
reloj_fin -= dlt;
if reloj_fin <= 0 {
    instance_destroy();
    exit;
}

// movimiento
var lejos = m_velproy * dlt;
var paso = lejos / max(1, ceil(lejos / 18));
if paso != 0 {
    var otr;
    for (var p = paso; p <= lejos; p += paso) {
        x += lengthdir_x(p, direction);
        y += lengthdir_y(p, direction);
        if place_meeting(x, y, o_bloque) {
            instance_destroy();
            exit;
        }
        else if dehumano {
            otr = instance_place(x, y, o_monstruo);
            if otr != noone {
                
            }
            else {
                otr = instance_place(x, y, o_astral);
                if otr != noone {
                    
                }
            }
        }
        else {
            otr = instance_place(x, y, o_humano);
            if otr != noone {
                
            }
        }
    }
}
depth = -y;
if dehumano and (tipo == 12 or tipo == 13) {
    var vist = __view_get( e__VW.WView, 0 ) / 2;
    var ppx = __view_get( e__VW.XView, 0 ) + vist;
    var ppy = __view_get( e__VW.YView, 0 ) + vist + o_control.desfase_vision;
    var d = point_direction(x, y, ppx, ppy);
    xi = x + lengthdir_x(125, d);
    yi = y + lengthdir_y(125, d);
}
else {
    xi = x;
    yi = y;
}


