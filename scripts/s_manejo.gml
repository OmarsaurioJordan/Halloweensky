///s_manejo(id);

with argument0 {
    if keyboard_check(vk_up) or keyboard_check(ord('W')) {
        if keyboard_check(vk_left) or keyboard_check(ord('A')) {
            direction = 135;
        }
        else if keyboard_check(vk_right) or keyboard_check(ord('D')) {
            direction = 45;
        }
        else {
            direction = 90;
        }
    }
    else if keyboard_check(vk_down) or keyboard_check(ord('S')) {
        if keyboard_check(vk_left) or keyboard_check(ord('A')) {
            direction = 225;
        }
        else if keyboard_check(vk_right) or keyboard_check(ord('D')) {
            direction = 315;
        }
        else {
            direction = 270;
        }
    }
    else if keyboard_check(vk_left) or keyboard_check(ord('A')) {
        direction = 180;
    }
    else if keyboard_check(vk_right) or keyboard_check(ord('D')) {
        direction = 0;
    }
    else {
        direction = 1;
    }
}

