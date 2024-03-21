# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

COMMIT="7c34b558cca374b6c8727fc08868f2bc044fd162"

DESCRIPTION="A slightly better history for zsh"
HOMEPAGE="https://github.com/larkery/zsh-histdb"
SRC_URI="https://github.com/larkery/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="
	app-shells/zsh
	dev-db/sqlite
"

DOCS=( README.org )

S="${WORKDIR}/${PN}-${COMMIT}"

src_install() {
	einstalldocs
	rm -rf "LICENSE" "${DOCS[@]}" || die
	dodir "/usr/share/zsh/plugins"
	insinto "/usr/share/zsh/plugins/${PN}"
	doins -r .
}

pkg_postinst() {
	einfo "To use this module please read the README"
}
