/// @description s_dificultad();

var d = o_control.dificultad;
switch luna {
    case m_luna_creciente: return m_dificultad + ceil(power(d * 0.5, 0.8));
    case m_luna_llena: return m_dificultad + ceil(power(d, 0.75));
    case m_luna_menguante: return m_dificultad + ceil(power(d * 0.5, 0.8));
    case m_luna_negra: return m_dificultad + ceil(power(d * 2, 0.7));
}
return m_dificultad + ceil(power(d, 0.75));

