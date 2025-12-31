s_idweb(id);

// visual y animacion
s_ani_ini(id, 1, 1);
reloj_pies = 0;
xi = x;
yi = y;

// para network sync
sacarlo = false;

// IA
reloj_errar = m_errar_s + random(m_errar_s);
moverse = choose(true, false);
direction = random(360);


