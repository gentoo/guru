# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

DESCRIPTION="Flow implementations for Mirage"
HOMEPAGE="https://github.com/mirage/mirage-flow"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="combinators ocamlopt test unix"

RDEPEND="
	combinators? ( dev-ml/mirage-clock )
	dev-ml/cstruct
	dev-ml/fmt
	dev-ml/logs
	dev-ml/lwt
"
DEPEND="
	${RDEPEND}
	test? ( dev-ml/alcotest )
"

REQUIRED_USE="test? ( combinators unix )"
RESTRICT="!test? ( test )"

src_compile() {
	local pkgs="mirage-flow"
	for u in combinators unix ; do
		if use ${u} ; then
			pkgs="${pkgs},mirage-flow-${u}"
		fi
	done
	dune build -p "${pkgs}" -j $(makeopts_jobs) || die
}

src_install() {
	dune_src_install mirage-flow
	use combinators && dune_src_install mirage-flow-combinators
	use unix && dune_src_install mirage-flow-unix
}
