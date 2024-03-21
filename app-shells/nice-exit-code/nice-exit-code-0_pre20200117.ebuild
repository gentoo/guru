# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

COMMIT="de7ac733d28705b5e9989b9c8231ac88eb33d841"

DESCRIPTION="ZSH plugin that maps exit status code to human readable string"
HOMEPAGE="https://github.com/bric3/nice-exit-code"
SRC_URI="https://github.com/bric3/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="
	app-shells/zsh
"

DOCS=( README.md )

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
