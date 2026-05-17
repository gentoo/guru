# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

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

OCAML_SUBPACKAGES=(
	ezjsonm
)

src_prepare() {
	default

	use lwt && OCAML_SUBPACKAGES+=( ezjsonm-lwt )

	# test libs and binaries are built unconditionally otherwise
	rm lib_test/dune
}

src_compile() {
	dune-compile ${OCAML_SUBPACKAGES[@]}
}

src_install() {
	dune-install ${OCAML_SUBPACKAGES[@]}
}
