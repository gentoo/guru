#!/bin/bash

# called by dracut
check() {
    return 0
}

# called by dracut
depends() {
    echo drm crypt
    return 0
}

# called by dracut
install() {
    inst_multiple "/etc/osk.conf" \
        "/usr/share/glvnd/egl_vendor.d/50_mesa.json" \
        "/usr/share/fonts/dejavu/DejaVuSans.ttf" \
        osk-sdl
    inst_simple $moddir/osk-sdl.sh /usr/bin/osk-sdl.sh
    inst_simple $moddir/osk-sdl-pp.service ${systemdsystemunitdir}/osk-sdl-pp.service
    inst_simple $moddir/osk-sdl-pp.path ${systemdsystemunitdir}/osk-sdl-pp.path
    systemctl -q --root "$initdir" add-wants sysinit.target osk-sdl-pp.path
    # mesa cogl libglvnd
    equery f mesa cogl libglvnd | grep ".so$" | while read -r so; do
      inst ${so}
    done

}
