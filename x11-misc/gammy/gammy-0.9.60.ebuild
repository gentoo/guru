# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop qmake-utils xdg

DESCRIPTION="Adaptive screen brightness/temperature"
HOMEPAGE="https://github.com/Fushko/gammy"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Fushko/${PN}.git"
else
	SRC_URI="https://github.com/Fushko/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtdbus:5
	dev-qt/qtwidgets:5
	x11-libs/libXxf86vm
"
DEPEND="
	${RDEPEND}
	media-gfx/imagemagick
"

src_configure() {
	eqmake5 PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake INSTALL_ROOT="${D}" install

	local sizes="128 16 32 64"
	cd ./icons || die
	for size in ${sizes}; do
		convert "${size}x${size}ball.ico" "${size}x${size}ball.png" || die
		newicon -s "${size}" "${size}x${size}ball.png" "${PN}.png"
	done

	make_desktop_entry "${PN}" "${PN^}" "${PN}" "Graphics;Settings"
}
