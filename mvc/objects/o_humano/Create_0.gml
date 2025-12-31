s_idweb(id);

// crecimiento
reloj_adultez = m_adultez_s;

// visual y animacion
genero = irandom(2);
s_ani_ini(id, 3, 1);
reloj_pies = 0;
xi = x;
yi = y;

// estadisticas
municiones = ds_list_create();
for (var e = 0; e < m_herr_total; e++) {
    ds_list_add(municiones, 0);
}
herramienta = m_herr_nada;
material = m_mat_nada;
vida = m_vida;

// ataque
reloj_cadencia = 0;

// para network sync
sacarlo = false;
flag_herramienta = -1;

// crafting
reloj_material = 0;

// iluminacion
reloj_luz = random_range(0.5, 2);
radio = random_range(0.8, 1.2);

// IA
reloj_errar = m_errar_s + random(m_errar_s);
moverse = choose(true, false);
direction = random(360);
blanco = noone; // enemigo visto
reloj_esquive = 0;
dir_hulle = random(360);
trabajo = noone; // o_recurso
hogar = noone; // o_casa donde dormir


