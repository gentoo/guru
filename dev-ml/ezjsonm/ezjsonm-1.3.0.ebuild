# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

DESCRIPTION="An easy interface on top of the Jsonm library"
HOMEPAGE="https://github.com/mirage/ezjsonm"
SRC_URI="https://github.com/mirage/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="lwt +ocamlopt"

DEPEND="
	dev-ml/ocaml-hex:=[ocamlopt?]
	>=dev-ml/jsonm-1.0.0:=[ocamlopt?]
	dev-ml/sexplib0:=[ocamlopt?]
	dev-ml/uutf:=[ocamlopt?]

	lwt? ( dev-ml/lwt:=[ocamlopt?] )
"
RDEPEND="${DEPEND}"

RESTRICT="test"

src_prepare() {
	default
	# test libs and binaries are built unconditionally otherwise
	rm lib_test/dune
}

src_compile() {
	local pkgs="ezjsonm"
	if use lwt ; then
		pkgs="${pkgs},ezjsonm-lwt"
	fi
	dune build --only-packages "${pkgs}" -j $(makeopts_jobs) --profile release || die
}

src_install() {
	dune_src_install ezjsonm
	use lwt && dune_src_install ezjsonm-lwt
}
