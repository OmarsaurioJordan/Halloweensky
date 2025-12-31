/// @description Open

if !file_exists("mapa.ini") {
    exit;
}
ini_open("mapa.ini");

var xx, yy, aux;
var n = 0;
while ini_key_exists("o_arbol", "x" + string(n)) {
    xx = real(ini_read_string("o_arbol", "x" + string(n), "0"));
    yy = real(ini_read_string("o_arbol", "y" + string(n), "0"));
    aux = instance_create(xx, yy, o_arbol);
    aux.tipo = real(ini_read_string("o_arbol", "t" + string(n), "0"));
    if aux.tipo <= 6 {
        //aux.tipo = irandom(6);
    }
    n++;
}

n = 0;
while ini_key_exists("o_mobiliario", "x" + string(n)) {
    xx = real(ini_read_string("o_mobiliario", "x" + string(n), "0"));
    yy = real(ini_read_string("o_mobiliario", "y" + string(n), "0"));
    aux = instance_create(xx, yy, o_mobiliario);
    aux.tipo = real(ini_read_string("o_mobiliario", "t" + string(n), "0"));
    n++;
}

n = 0;
while ini_key_exists("o_decorado", "x" + string(n)) {
    xx = real(ini_read_string("o_decorado", "x" + string(n), "0"));
    yy = real(ini_read_string("o_decorado", "y" + string(n), "0"));
    aux = instance_create(xx, yy, o_decorado);
    aux.tipo = real(ini_read_string("o_decorado", "t" + string(n), "0"));
    if aux.tipo >= 1 and aux.tipo <= 6 {
        //aux.tipo = irandom_range(1, 6);
    }
    n++;
}

n = 0;
while ini_key_exists("o_casa", "x" + string(n)) {
    xx = real(ini_read_string("o_casa", "x" + string(n), "0"));
    yy = real(ini_read_string("o_casa", "y" + string(n), "0"));
    instance_create(xx, yy, o_casa);
    n++;
}

ini_close();

// crear fauna natural y recursos

repeat instance_number(o_casa) {
    instance_create(random(room_width), random(room_height), o_animal);
}

with o_casa {
    aux = instance_create(x + random_range(-10, 10),
        y + random_range(-10, 10), o_humano);
    aux.genero = irandom(1);
}

with o_arbol {
    if tipo == 7 {
        aux = instance_create(x, y, o_recurso);
        aux.material = m_mat_madera;
    }
    else if tipo == 9 {
        aux = instance_create(x, y, o_recurso);
        aux.material = m_mat_metal;
    }
}
with o_mobiliario {
    if tipo == 1 {
        aux = instance_create(x, y, o_recurso);
        aux.material = m_mat_maiz;
    }
    else if tipo == 2 {
        aux = instance_create(x, y, o_recurso);
        aux.fogata = true;
        instance_create(x, y, o_luz);
    }
}

with o_decorado {
    if tipo == 7 {
        instance_create(x, y, o_luz);
    }
}


