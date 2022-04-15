# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

DESCRIPTION="Block implementations for mirage"
HOMEPAGE="https://github.com/mirage/mirage-block"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="combinators ocamlopt"

RDEPEND="
	dev-ml/cstruct
	dev-ml/lwt
	dev-ml/fmt

	combinators? (
		dev-ml/io-page
		dev-ml/logs
	)
"
DEPEND="${RDEPEND}"

src_compile() {
	local pkgs="mirage-block"
	use combinators && pkgs="${pkgs},mirage-block-combinators"
	dune build -p "${pkgs}" -j $(makeopts_jobs) || die
}

src_install() {
	dune_src_install mirage-block
	use combinators && dune_src_install mirage-block-combinators
}
