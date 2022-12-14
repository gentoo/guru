# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

DESCRIPTION="Pure OCaml Wayland protocol library"
HOMEPAGE="
	https://github.com/talex5/ocaml-wayland
	https://opam.ocaml.org/packages/wayland/
"
SRC_URI="https://github.com/talex5/ocaml-wayland/archive/v${PV}.tar.gz -> ocaml-${P}.tar.gz"
S="${WORKDIR}/ocaml-${P}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RDEPEND="
	dev-ml/base:=
	>=dev-ml/cmdliner-1.1.1:=
	>=dev-ml/cstruct-6.0.0:=
	>=dev-ml/fmt-0.8.0:=
	>=dev-ml/logs-0.7.0:=
	>=dev-ml/lwt-5.4.0:=
	>=dev-ml/xmlm-1.3.0:=
	>=dev-ml/dune-2.8.0:=
"

DEPEND="
	${RDEPEND}
	dev-ml/ocaml-doc
	test? (
		>=dev-ml/alcotest-lwt-1.2.3:=
		dev-ml/ounit2
		>=dev-ml/ppx_sexp_conv-0.9.0
	)
"

RESTRICT="!test? ( test )"

src_compile() {
	local pkgs="wayland"
	dune build -p "${pkgs}" -j $(makeopts_jobs) || die
}

src_install() {
	dune_src_install wayland
}
