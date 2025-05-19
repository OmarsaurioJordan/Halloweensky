///s_intercambio(id1, id2);
// solo sucede en servidor

// es otro jugador, darle municion
if ds_list_find_index(o_control.estavivo, argument1) != -1 {
    var herr = argument0.herramienta;
    var mimu = ds_list_find_value(argument0.municiones, herr);
    var sumu = ds_list_find_value(argument1.municiones, herr);
    var addd = min(mimu, o_control.costo[herr, 2], 255 - sumu);
    sumu += addd;
    mimu -= addd;
    ds_list_replace(argument0.municiones, herr, mimu);
    ds_list_replace(argument1.municiones, herr, sumu);
}
// es un NPC
else {
    
}

