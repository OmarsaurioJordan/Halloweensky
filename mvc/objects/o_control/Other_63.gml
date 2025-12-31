/// @description Message

var key = ds_map_find_value(async_load, "id");
if key == dialog_ip {
    dialog_ip = -1;
    if ds_map_find_value(async_load, "status") {
        var txt = ds_map_find_value(async_load, "result");
        if txt != ip_broadcast + "x" {
            txt = s_split(string_replace(txt, "x", ""), ".", true);
            if is_array(txt) {
                if array_length_1d(txt) == 3 {
                    for (var i = 0; i < 3; i++) {
                        txt[i] = string_digits(txt[i]);
                        if txt[i] == "" {
                            txt[i] = "0";
                        }
                        txt[i] = string(clamp(floor(real(txt[i])), 0, 255));
                    }
                    ini_open("config.ini");
                    ini_write_string("network", "broadcast",
                        txt[0] + "." + txt[1] + "." + txt[2] + ".");
                    ini_close();
                    game_end();
                }
            }
        }
    }
}
else if key == dialog_name {
    dialog_name = -1;
    if ds_map_find_value(async_load, "status") {
        var txt = ds_map_find_value(async_load, "result");
        txt = string_lettersdigits(txt);
        if txt != "" {
            txt = string_copy(txt, 1, min(string_length(txt), 12));
        }
        if txt != nombre {
            ini_open("config.ini");
            ini_write_string("network", "nombre", txt);
            ini_close();
            game_end();
        }
    }
}


