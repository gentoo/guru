# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop java-pkg-2 xdg

MY_PV=${PV/_p/-patch}
DESCRIPTION="Turn-based historical strategy game, a remake of Civ V"
HOMEPAGE="https://github.com/yairm210/Unciv"
SRC_URI="https://github.com/yairm210/Unciv/releases/download/${MY_PV}/Unciv.jar -> ${P}.jar"
S="${WORKDIR}"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="-* ~amd64" # the jar also should work on arm{,64} but I am unable to test that

RDEPEND=">=virtual/jre-11:*" # could be more
BDEPEND="app-arch/unzip"

declare -r IMG_PATH="ExtraImages/Icon.png"

src_unpack() {
	cp "${DISTDIR}/${P}.jar" "${WORKDIR}"
	unzip ${P}.jar ${IMG_PATH} || die "Extracting icon failed"
}

src_install() {
	java-pkg_newjar "${P}.jar"
	java-pkg_dolauncher "${PN}" --jar "${PN}.jar"
	newicon --size 32 ${IMG_PATH} unciv.png || die "Installing icon failed"
	# this desktop file is better than upstream's
	make_desktop_entry "${PN}" Unciv-bin unciv "Game;StrategyGame" "Terminal=false"
}

pkg_preinst() {
	java-pkg-2_pkg_preinst
	xdg_pkg_preinst
}
