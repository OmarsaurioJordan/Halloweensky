/// @description s_dado_tres(porcent1, porcent2);
/// @param porcent1
/// @param  porcent2
// ret: 1, 2, 3

var dado = random(1);
if dado < argument0 {
    return 1;
}
else if dado < argument0 + argument1 {
    return 2;
}
else {
    return 3;
}

