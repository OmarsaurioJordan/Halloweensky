///s_cambio_fogata(suma);
// ret: true si hubo cambio

var foga = s_en_fogata();
if foga {
    with o_control {
        if argument0 {
            paraventa++;
            if paraventa > m_herrx_medicina {
                paraventa = 0;
            }
        }
        else {
            paraventa--;
            if paraventa < 0 {
                paraventa = m_herrx_medicina;
            }
        }
    }
}
return foga;

