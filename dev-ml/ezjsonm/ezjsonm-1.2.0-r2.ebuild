# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

DESCRIPTION="An easy interface on top of the Jsonm library"
HOMEPAGE="https://github.com/mirage/ezjsonm"
SRC_URI="https://github.com/mirage/ezjsonm/releases/download/v${PV}/${PN}-v${PV}.tbz"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="lwt ocamlopt test"

DEPEND="
	dev-ml/hex
	>=dev-ml/jsonm-1.0.0
	dev-ml/sexplib0
	dev-ml/uutf

	lwt? ( dev-ml/lwt )
"
RDEPEND="
	${DEPEND}
	test? (
		dev-ml/alcotest
		dev-ml/js_of_ocaml
		net-libs/nodejs[npm]
		dev-ml/ppx_sexp_conv
	)
"

RESTRICT="!test? ( test )"
REQUIRED_USE="test? ( lwt )"

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
