# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Citrix's (deprecated) extensions to the ocaml standard library"
HOMEPAGE="
	https://xapi-project.github.io/stdext/
	https://github.com/xapi-project/stdext
"
SRC_URI="https://github.com/xapi-project/stdext/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/stdext-${PV}"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

DEPEND="
	<dev-lang/ocaml-4.14.0
	dev-ml/astring
	dev-ml/fd-send-recv
	dev-ml/logs
	dev-ml/ptime
	dev-ml/xapi-backtrace
"
RDEPEND="${DEPEND}"

src_install() {
	dune_src_install xapi-stdext-date
	dune_src_install xapi-stdext-encodings
	dune_src_install xapi-stdext-pervasives
	dune_src_install xapi-stdext-std
	dune_src_install xapi-stdext-threads
	dune_src_install xapi-stdext-unix
	dune_src_install xapi-stdext-zerocheck
}
