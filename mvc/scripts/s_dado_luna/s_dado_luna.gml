/// @description s_dado_luna(grupo_verificable);
/// @param grupo_verificable
// ret: 1, 2, 3

var res = 0;
while res == 0 {
    switch luna {
        case m_luna_creciente: res = s_dado_tres(0.9, 0.1); break;
        case m_luna_llena: res = s_dado_tres(0.7, 0.2); break;
        case m_luna_menguante: res = s_dado_tres(0.5, 0.3); break;
        case m_luna_negra: res = s_dado_tres(0.3, 0.4); break;
    }
    if argument0 == -1 {
        break;
    }
    else {
        for (var i = 0; i <= m_ent_ente; i++) {
            if s_letalidad_monster(i) == res and s_grupo_monster(i) == argument0 {
                return res;
            }
        }
        res = 0;
    }
}
return res;

