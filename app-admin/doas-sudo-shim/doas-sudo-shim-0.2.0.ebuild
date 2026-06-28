# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="sudo shim that utilizes doas"
HOMEPAGE="https://github.com/jirutka/doas-sudo-shim"
SRC_URI="https://github.com/jirutka/doas-sudo-shim/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

BDEPEND="doc? ( dev-ruby/asciidoctor )"
RDEPEND="
	app-admin/doas
	!app-admin/sudo
"

src_compile() {
	if use doc; then
		emake man
	fi
}

src_install() {
	local targets="install-exec"
	use doc && targets+=" install-man"
	emake DESTDIR="${ED}" PREFIX=/usr ${targets}
	dodoc README.adoc LICENSE
}
