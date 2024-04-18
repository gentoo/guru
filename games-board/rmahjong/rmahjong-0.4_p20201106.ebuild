# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

inherit desktop python-single-r1 toolchain-funcs xdg

# Tarball from py3 port branch:
# https://github.com/spirali/rmahjong/tree/py3
# At least "Furiten", "Red fives" rules aren't implemented.
PKG_sha="7a37ade640bc24eb2cc9f0ad6c7ce26773be2856"

DESCRIPTION="Riichi Mahjong, the Japanese variant of the Chinese game Mahjong for 4 players"
HOMEPAGE="https://github.com/spirali/rmahjong"

# PNG icon is taken from Kmahjongg project (GPL-2), renamed to avoid pkgs conflicts
SRC_URI="
	https://github.com/spirali/${PN}/archive/${PKG_sha}.tar.gz -> ${P}.tar.gz
	https://github.com/KDE/kmahjongg/raw/master/icons/48-apps-kmahjongg.png -> kmahjongg_${PN}.png"

S="${WORKDIR}/${PN}-${PKG_sha}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="mirror !test? ( test )"

RDEPEND="
	${PYTHON_DEPS}
	dev-python/pygame[X,opengl]
	$(python_gen_cond_dep '
		dev-python/pygame[${PYTHON_USEDEP}]
		dev-python/pyopengl[${PYTHON_USEDEP}]
	')
"

src_prepare(){
	default

	# Disable logging as application log into directory where user access is denied
	sed -i "/logging.basicConfig/d" "${S}/client/client.py" || die
	sed -i "/logging.basicConfig/d" "${S}/server/server.py" || die
	sed -i "/logging.info/d" "${S}/server/server.py" || die

	cat > "${S}/rmahjong" <<- EOF || die
		#!/bin/sh
		cd "$(python_get_sitedir)/${PN}" && ./start.sh
	EOF

	# pass compiler and CFLAGS to 'Bot' makefile
	sed -i -e 's:gcc:'"$(tc-getCC)"':g' bot/makefile \
		-e 's:CFLAGS=-Wall -O3 -march=native:CFLAGS='"${CFLAGS}"':' \
		-e 's:\$(ARG):\$(ARG) '"${LDFLAGS}"':' || die
}

src_compile() {
	# Build bots
	cd "${S}/bot/" || die
	emake
}

src_test() {
	cd "${S}/server/" || die
	"${EPYTHON}" test.py -v || die
}

src_install() {
	python_moduleinto ${PN}
	python_domodule {client/,server/,start.sh}
	chmod 755 "${D}"/$(python_get_sitedir)/${PN}/start.sh
	chmod 755 "${D}"/$(python_get_sitedir)/${PN}/server/run_server.sh

	python_moduleinto ${PN}/bot
	python_domodule bot/bot
	chmod 755 "${D}"/$(python_get_sitedir)/${PN}/bot/bot

	python_optimize

	dobin rmahjong
	doicon -s 48 "${DISTDIR}/kmahjongg_${PN}.png"
	make_desktop_entry "${PN}" "RMahjong" "kmahjongg_${PN}" "Game;BoardGame;"
}
