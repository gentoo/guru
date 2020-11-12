# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils qmake-utils xdg

DESCRIPTION="A lightweight file-manager for C Suite"
HOMEPAGE="https://gitlab.com/cubocore/coreapps/corefm"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/cubocore/coreapps/${PN}.git"
else
	SRC_URI="https://gitlab.com/cubocore/coreapps/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-v${PV}"
fi

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	dev-qt/qtconcurrent:5=
	dev-qt/qtdbus:5=
	dev-qt/qtwidgets:5=
	gui-libs/libcprime
	gui-libs/libcsys
"
RDEPEND="
	${DEPEND}
"

PATCHES=(
	"${FILESDIR}/${P}-urilist.patch"
)

src_prepare() {
	default

	sed -i 's/CSuite/X-CSuite/' "${PN}.desktop" || die
}

src_configure() {
	eqmake5
}

src_compile() {
	emake
}

src_install() {
	einstalldocs

	emake INSTALL_ROOT="${D}" install
}
