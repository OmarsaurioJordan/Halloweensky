s_randomize();
s_ventana();
date_set_timezone(timezone_utc);
clicdxy[0] = 0;
clicdxy[1] = 0;
__view_set( e__VW.XView, 0, (room_width + __view_get( e__VW.WView, 0 )) / 2 );
__view_set( e__VW.YView, 0, (room_height + __view_get( e__VW.HView, 0 )) / 2 );
instance_create(0, 0, o_mouse);
ini_open("config.ini");

globalvar dlt, servidor, player, socket, hora, dia, luna;
dlt = 0;
servidor = true;
player = noone;
reloj_respawn = m_respawn_s;

// para evitar disparos duplicados
listadisparos = ds_list_create();
repeat 127 {
    ds_list_add(listadisparos, "");
}

// locales
escala_vision = __view_get( e__VW.WView, 0 ) / 80;
desfase_vision = __view_get( e__VW.HView, 0 ) - __view_get( e__VW.WView, 0 );
rectw = __view_get( e__VW.WView, 0 );
recth = __view_get( e__VW.HView, 0 );

// editor
editor_objeto = "Arbol";
editor_tipo = 1;
modo_editor = false;

// gui
hora = 0; // 0:amanecer, 127:anochecer, 255:amanecer
dia = 1; // dias transcurridos sobreviviendo
luna = m_luna_creciente; // se obtiene con el dia
materiales[0] = 0; // comida
materiales[1] = 12; // madera
materiales[2] = 12; // hierro
materiales[3] = 0; // extra ???
estadisticas[0] = 0; // humanos
estadisticas[1] = 0; // monstruos
estadisticas[2] = 0; // astrales
listadonombres = ds_list_create(); // sincronia con losnombres serv/clie
listadoestavivo = ds_list_create(); // sincronia con estavivo serv/clie
nombre = ini_read_string("network", "nombre", "");
dialog_name = get_string_async("Write your player name, max 12 chars " +
    "(change requires restart)", nombre);

// conectar network
socket = network_create_socket_ext(network_socket_udp, m_puerto);
if socket < 0 {
    game_end();
    exit;
}
tiempo_inicio = date_current_datetime();
conexiones = ds_list_create(); // direcciones IP
estavivo = ds_list_create(); // idweb de monigote, 0 nulo
pinguser = ds_list_create(); // temporizador de desconexion
tiemposinicios = ds_list_create(); // tiempo_inicio
estaconectado = ds_list_create(); // true si ya ambos extremos ok
losnombres = ds_list_create(); // server guarda nombres
lasagujas = ds_list_create(); // agujas de los clientes para posicion
loseventos = ds_list_create(); // agujas de los clientes para eventos
losrespawns = ds_list_create(); // para reaparecer jugadores
reloj_broadcast = 0;
puerto_broadcast = 1;
ip_broadcast = ini_read_string("network", "broadcast", "192.168.1.");
dialog_ip = -1;

// envio network
reloj_entes = m_ping;
reloj_player = m_ping - 1;
reloj_gui = m_ping + 1;
aguja_entes = 0;
aguja_player = 0;
aguja_gui = 0;
aguja_evento = 0;
aguja_disparo = 0;

// crear mundo
//s_azar_cosas(0.1, o_arbol, 72);
//s_azar_cosas(0.2, o_decorado, 36);
alarm[0] = 1;

ini_close();

// dificultad
primer_oleada = true;
dificultad = 1; // aumenta cada lunacion
guion = ds_list_create();
ds_list_add(guion, m_grupo_zombi, m_grupo_humano, m_grupo_vampirico,
    m_grupo_infernal, m_grupo_antiguo, m_grupo_especial);
presentados = ds_list_create(); // listado de monstruos que no han aparecido
for (var i = 0; i <= m_ent_ente; i++) {
    if s_grupo_monster(i) != m_grupo_fantasmal {
        ds_list_add(presentados, i);
    }
}

// madera vs hierro
paraventa = irandom(m_herrx_medicina);
costo[m_herr_nada, 0] = 0; costo[m_herr_nada, 1] = 0;
costo[m_herr_guitarra, 0] = 5; costo[m_herr_guitarra, 1] = 1;
costo[m_herr_tambor, 0] = 7; costo[m_herr_tambor, 1] = 0;
costo[m_herr_explosivo, 0] = 4; costo[m_herr_explosivo, 1] = 1;
costo[m_herr_mina, 0] = 3; costo[m_herr_mina, 1] = 2;
costo[m_herr_antorcha, 0] = 3; costo[m_herr_antorcha, 1] = 0;
costo[m_herr_cuchillo, 0] = 1; costo[m_herr_cuchillo, 1] = 1;
costo[m_herr_mazo, 0] = 2; costo[m_herr_mazo, 1] = 6;
costo[m_herr_pico, 0] = 3; costo[m_herr_pico, 1] = 3;
costo[m_herr_hacha, 0] = 3; costo[m_herr_hacha, 1] = 4;
costo[m_herr_espada, 0] = 1; costo[m_herr_espada, 1] = 3;
costo[m_herr_baculo, 0] = 0; costo[m_herr_baculo, 1] = 4;
costo[m_herr_ballesta, 0] = 2; costo[m_herr_ballesta, 1] = 3;
costo[m_herr_lanza, 0] = 3; costo[m_herr_lanza, 1] = 1;
costo[m_herr_pistola, 0] = 1; costo[m_herr_pistola, 1] = 4;
costo[m_herr_escopeta, 0] = 1; costo[m_herr_escopeta, 1] = 6;
costo[m_herr_rifle, 0] = 1; costo[m_herr_rifle, 1] = 5;
costo[m_herr_metralla, 0] = 1; costo[m_herr_metralla, 1] = 7;
costo[m_herrx_escudin, 0] = 0; costo[m_herrx_escudin, 1] = 6;
costo[m_herrx_escudo, 0] = 0; costo[m_herrx_escudo, 1] = 8;
costo[m_herrx_medicina, 0] = 6; costo[m_herrx_medicina, 1] = 0;

// municion vs cadencia_s
costo[m_herr_nada, 2] = 0; costo[m_herr_nada, 3] = 0;
costo[m_herr_guitarra, 2] = 30; costo[m_herr_guitarra, 3] = 1;
costo[m_herr_tambor, 2] = 35; costo[m_herr_tambor, 3] = 2;
costo[m_herr_explosivo, 2] = 25; costo[m_herr_explosivo, 3] = 5;
costo[m_herr_mina, 2] = 25; costo[m_herr_mina, 3] = 6;
costo[m_herr_antorcha, 2] = 30; costo[m_herr_antorcha, 3] = 2.5;
costo[m_herr_cuchillo, 2] = 20; costo[m_herr_cuchillo, 3] = 1;
costo[m_herr_mazo, 2] = 80; costo[m_herr_mazo, 3] = 3;
costo[m_herr_pico, 2] = 60; costo[m_herr_pico, 3] = 2;
costo[m_herr_hacha, 2] = 70; costo[m_herr_hacha, 3] = 2;
costo[m_herr_espada, 2] = 40; costo[m_herr_espada, 3] = 1.5;
costo[m_herr_baculo, 2] = 20; costo[m_herr_baculo, 3] = 1.5;
costo[m_herr_ballesta, 2] = 25; costo[m_herr_ballesta, 3] = 1.5;
costo[m_herr_lanza, 2] = 20; costo[m_herr_lanza, 3] = 3;
costo[m_herr_pistola, 2] = 25; costo[m_herr_pistola, 3] = 1;
costo[m_herr_escopeta, 2] = 35; costo[m_herr_escopeta, 3] = 2.5;
costo[m_herr_rifle, 2] = 30; costo[m_herr_rifle, 3] = 2;
costo[m_herr_metralla, 2] = 40; costo[m_herr_metralla, 3] = 0.5;
costo[m_herrx_escudin, 2] = 0; costo[m_herrx_escudin, 3] = 2;
costo[m_herrx_escudo, 2] = 0; costo[m_herrx_escudo, 3] = 1;
costo[m_herrx_medicina, 2] = 0; costo[m_herrx_medicina, 3] = 3;


