# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg

MY_PN="GitQlient"

DESCRIPTION="Multi-platform Git client written with Qt"
HOMEPAGE="https://github.com/francescmm/GitQlient"
SRC_URI="https://github.com/francescmm/${MY_PN}/releases/download/v${PV}/${PN}_${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}_${PV}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-qt/qtbase:6[gui,network,widgets]"
RDEPEND="
	${DEPEND}
	dev-vcs/git
"

src_prepare() {
	default

	# Drop 'fatal' warning on version detection via git command:
	sed -i -e '/message("Submodule update:")/d' \
		-e "/system(git submodule update --init --recursive)/d" \
		-e "/GQ_SHA =/s| \$\$system(git rev-parse --short HEAD)||" \
		-e "/VERSION =/s| \$\$system(git describe --abbrev=0)||" "${MY_PN}".pro || die
}

src_configure() {
	eqmake6 PREFIX=/usr "${MY_PN}".pro
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}

pkg_postinst() {
	xdg_pkg_postinst
}
