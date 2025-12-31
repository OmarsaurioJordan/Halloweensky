s_idweb(id);

// tipo de monstruo
tipo = m_ent_esqueleto;

// visual y animacion
sprite = d_esqueleto;
s_ani_ini(id, 3, 1);
reloj_pies = 0;
xi = x;
yi = y;

// estadisticas
vida = m_vida;

// para network sync
sacarlo = false;

// IA
reloj_errar = m_errar_s + random(m_errar_s);
moverse = choose(true, false);
direction = random(360);


