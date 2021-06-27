# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

COMMIT="69fb2d943a8664d5a587c967ac828f9ed5acd7ce"

DESCRIPTION="Lightweight On-Screen-Keyboard based on SDL2"
HOMEPAGE="https://gitlab.com/postmarketOS/osk-sdl"
SRC_URI="https://gitlab.com/postmarketOS/osk-sdl/-/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
RESTRICT="test"

RDEPEND="
	app-portage/gentoolkit
	media-libs/cogl
	media-fonts/dejavu
	media-libs/libglvnd
	media-libs/libsdl2[kms,haptic]
	media-libs/mesa
	media-libs/sdl2-ttf
	sys-fs/cryptsetup
	sys-kernel/dracut
"

BDEPEND="app-text/scdoc"

S="${WORKDIR}/${PN}-${COMMIT}"

src_prepare() {
	default
	sed -e s/ttf-dejavu/dejavu/ -i osk.conf || die "Failed to sed"
}

src_install() {
	meson_src_install
	insinto /etc
	doins osk.conf
	insinto /etc/dracut.conf.d/
	doins "${FILESDIR}"/osk-sdl-pp.conf
	insinto /usr/lib/dracut/modules.d/50osk-sdl
	doins "${FILESDIR}"/osk-sdl-pp.path
	doins "${FILESDIR}"/osk-sdl-pp.service
	exeinto /usr/lib/dracut/modules.d/50osk-sdl
	doexe "${FILESDIR}"/module-setup.sh
	doexe "${FILESDIR}"/osk-sdl.sh
}

pkg_postinst() {
	einfo "For more info on how to test osk-sdl, and how to report problems, see: ${HOMEPAGE}"
	einfo "To use osk-sdl to unlock encrypted root at bootime, check osk-sdl-pp.conf in /etc/dracut.conf.d"
	einfo "and add these boot option 'root=/dev/mapper/root cryptroot=/dev/path/to/encrypted_partition' "
}
