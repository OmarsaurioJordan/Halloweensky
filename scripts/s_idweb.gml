///s_idweb(id);

with argument0 {
    idweb = 0;
    while idweb == 0 {
        idweb = irandom_range(1, 65535);
        with o_movil {
            if idweb == argument0.idweb and id != argument0 {
                argument0.idweb = 0;
                break;
            }
        }
    }
}

