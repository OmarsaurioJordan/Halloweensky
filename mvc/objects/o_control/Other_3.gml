/// @description Save

if socket >= 0 {
    network_destroy(socket);
}

// save

if !modo_editor {
    exit;
}
if file_exists("mapa.ini") {
    file_delete("mapa.ini");
}
ini_open("mapa.ini");

var n = 0;
with o_arbol {
    ini_write_string("o_arbol", "x" + string(n), string(x));
    ini_write_string("o_arbol", "y" + string(n), string(y));
    ini_write_string("o_arbol", "t" + string(n), string(tipo));
    n++;
}

n = 0;
with o_mobiliario {
    ini_write_string("o_mobiliario", "x" + string(n), string(x));
    ini_write_string("o_mobiliario", "y" + string(n), string(y));
    ini_write_string("o_mobiliario", "t" + string(n), string(tipo));
    n++;
}

n = 0;
with o_decorado {
    ini_write_string("o_decorado", "x" + string(n), string(x));
    ini_write_string("o_decorado", "y" + string(n), string(y));
    ini_write_string("o_decorado", "t" + string(n), string(tipo));
    n++;
}

n = 0;
with o_casa {
    ini_write_string("o_casa", "x" + string(n), string(x));
    ini_write_string("o_casa", "y" + string(n), string(y));
    n++;
}

ini_close();


