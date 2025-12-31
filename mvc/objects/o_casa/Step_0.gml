// cambiar pivote de la casa para visibilidad
var vist = __view_get( e__VW.WView, 0 ) / 2;
var ppx = __view_get( e__VW.XView, 0 ) + vist;
var ppy = __view_get( e__VW.YView, 0 ) + vist + o_control.desfase_vision;
direction = point_direction(x, y, ppx, ppy);
xi = x + lengthdir_x(48, direction);
yi = y + lengthdir_y(48, direction);


