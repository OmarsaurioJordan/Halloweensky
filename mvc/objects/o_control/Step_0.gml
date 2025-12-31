/// @description Editor

if modo_editor {
    s_cam_zoom();
    if mouse_check_button_pressed(mb_left) and !keyboard_check(vk_shift) {
        if !collision_point(mouse_x, mouse_y, o_visible, true, false) {
            var aux;
            switch editor_objeto {
                case "Arbol":
                    aux = instance_create(mouse_x, mouse_y, o_arbol);
                    aux.tipo = editor_tipo;
                    break;
                case "Mobiliario":
                    aux = instance_create(mouse_x, mouse_y, o_mobiliario);
                    aux.tipo = editor_tipo;
                    break;
                case "Decorado":
                    aux = instance_create(mouse_x, mouse_y, o_decorado);
                    aux.tipo = editor_tipo;
                    break;
                case "Casa":
                    instance_create(mouse_x, mouse_y, o_casa);
                    break;
            }
        }
    }
    else if mouse_check_button(mb_left) and keyboard_check(vk_shift) {
        var otro = collision_point(mouse_x, mouse_y,
            o_bloque, true, false);
        if otro == noone {
            otro = collision_point(mouse_x, mouse_y,
                o_decorado, true, false);
        }
        if otro != noone {
            with otro {
                instance_destroy();
            }
        }
    }
    if keyboard_check_pressed(vk_anykey) {
        switch keyboard_key {
            case vk_up:
                switch editor_objeto {
                    case "Arbol":
                        editor_objeto = "Mobiliario";
                        break;
                    case "Mobiliario":
                        editor_objeto = "Decorado";
                        break;
                    case "Decorado":
                        editor_objeto = "Casa";
                        break;
                    case "Casa":
                        editor_objeto = "Arbol";
                        break;
                }
                editor_tipo = 1;
                break;
            case vk_down:
                switch editor_objeto {
                    case "Arbol":
                        editor_objeto = "Casa";
                        break;
                    case "Mobiliario":
                        editor_objeto = "Arbol";
                        break;
                    case "Decorado":
                        editor_objeto = "Mobiliario";
                        break;
                    case "Casa":
                        editor_objeto = "Decorado";
                        break;
                }
                editor_tipo = 1;
                break;
            case vk_left:
                switch editor_objeto {
                    case "Arbol":
                        editor_tipo--;
                        if editor_tipo < 0 {
                            editor_tipo = sprite_get_number(d_arbol) - 1;
                        }
                        break;
                    case "Mobiliario":
                        editor_tipo--;
                        if editor_tipo < 1 {
                            editor_tipo = sprite_get_number(d_pueblo) - 1;
                        }
                        break;
                    case "Decorado":
                        editor_tipo--;
                        if editor_tipo < 0 {
                            editor_tipo = sprite_get_number(d_decorado) - 1;
                        }
                        break;
                }
                break;
            case vk_right:
                switch editor_objeto {
                    case "Arbol":
                        editor_tipo++;
                        if editor_tipo >= sprite_get_number(d_arbol) {
                            editor_tipo = 0;
                        }
                        break;
                    case "Mobiliario":
                        editor_tipo++;
                        if editor_tipo >= sprite_get_number(d_pueblo) {
                            editor_tipo = 1;
                        }
                        break;
                    case "Decorado":
                        editor_tipo++;
                        if editor_tipo >= sprite_get_number(d_decorado) {
                            editor_tipo = 0;
                        }
                        break;
                }
                break;
        }
    }
}


