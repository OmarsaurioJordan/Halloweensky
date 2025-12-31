// tipo de monstruo
tipo = m_ent_fantasma;

// visual y animacion
sprite = d_fantasma;
s_ani_ini(id, 2, 0);
xi = x;
yi = y;

// estadisticas
vida = m_vida;

// IA
reloj_errar = m_errar_s + random(m_errar_s);
moverse = choose(true, false);
direction = random(360);


