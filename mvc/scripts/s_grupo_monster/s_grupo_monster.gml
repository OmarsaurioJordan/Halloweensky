/// @description s_grupo_monster(tipo_monster);
/// @param tipo_monster

switch argument0 {
    case m_ent_diablo: return m_grupo_infernal;
    case m_ent_bruja: return m_grupo_vampirico;
    case m_ent_esqueleto: return m_grupo_zombi;
    case m_ent_lobo: return m_grupo_vampirico;
    case m_ent_vampiro: return m_grupo_vampirico;
    case m_ent_alien: return m_grupo_especial;
    case m_ent_calabaza: return m_grupo_infernal;
    case m_ent_robot: return m_grupo_especial;
    case m_ent_frankenstein: return m_grupo_zombi;
    case m_ent_momia: return m_grupo_antiguo;
    case m_ent_payaso: return m_grupo_humano;
    case m_ent_asesino: return m_grupo_humano;
    case m_ent_munneco: return m_grupo_vampirico;
    case m_ent_sucubo: return m_grupo_humano;
    case m_ent_incubo: return m_grupo_humano;
    case m_ent_gordo: return m_grupo_antiguo;
    case m_ent_pulpo: return m_grupo_antiguo;
    case m_ent_abominacion: return m_grupo_zombi;
    case m_ent_monstruo: return m_grupo_infernal;
    case m_ent_insecto: return m_grupo_especial;
    case m_ent_tronco: return m_grupo_antiguo;
    case m_ent_siames: return m_grupo_vampirico;
    case m_ent_espectro: return m_grupo_fantasmal;
    case m_ent_harpia: return m_grupo_infernal;
    case m_ent_fantasma: return m_grupo_fantasmal;
    case m_ent_errante: return m_grupo_fantasmal;
    case m_ent_aranna: return m_grupo_especial;
    case m_ent_ente: return m_grupo_fantasmal;
    case m_ent_animal: return m_grupo_player;
    case m_ent_cucaracha: return m_grupo_player;
    case m_ent_ave: return m_grupo_player;
    case m_ent_humano: return m_grupo_player;
}
return m_grupo_player;

