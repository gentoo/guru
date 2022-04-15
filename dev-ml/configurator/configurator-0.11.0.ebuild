# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

DESCRIPTION="Helper library for gathering system configuration"
HOMEPAGE="https://github.com/janestreet/configurator"
SRC_URI="https://github.com/janestreet/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

RDEPEND="
	dev-ml/stdio
	dev-ml/base
"
DEPEND="${RDEPEND}"

src_compile() {
	dune upgrade || die
	dune build -p configurator -j $(makeopts_jobs) @install || die
}

src_install() {
	dune_src_install configurator
}
