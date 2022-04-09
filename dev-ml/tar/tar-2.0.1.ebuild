# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

MYPN="ocaml-${PN}"

DESCRIPTION="Pure OCaml library to read and write tar files"
HOMEPAGE="https://github.com/mirage/ocaml-tar"
SRC_URI="https://github.com/mirage/${MYPN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MYPN}-${PV}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="mirage ocamlopt test unix"

RDEPEND="
	dev-ml/camlp-streams
	dev-ml/cstruct
	dev-ml/re
	dev-ml/lwt

	mirage? (
		dev-ml/io-page
		dev-ml/mirage-block
		dev-ml/mirage-kv
		dev-ml/ptime
	)
"
DEPEND="
	${RDEPEND}
	test? (
		dev-ml/mirage-block-unix
		>=dev-ml/ounit-2[lwt]
	)
"

RESTRICT="!test? ( test )"
REQUIRED_USE="
	test? ( mirage unix )
"

src_compile() {
	local pkgs="tar"
	for u in mirage unix ; do
		if use ${u} ; then
			pkgs="${pkgs},tar-${u}"
		fi
	done
	dune build -p "${pkgs}" -j $(makeopts_jobs) || die
}

src_install() {
	dune_src_install tar
	use mirage && dune_src_install tar-mirage
	use unix && dune_src_install tar-unix
}
