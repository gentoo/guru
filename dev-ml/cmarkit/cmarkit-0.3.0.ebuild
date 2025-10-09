# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit findlib

DESCRIPTION="Cmarkit parses the CommonMark specification"
HOMEPAGE="https://erratique.ch/software/cmarkit"
SRC_URI="https://github.com/dbuenzli/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

RDEPEND="
	>=dev-lang/ocaml-4.14.0
"
DEPEND="${RDEPEND}
	dev-ml/findlib
	dev-ml/ocamlbuild
	dev-ml/topkg
	>=dev-ml/result-1.5:=[ocamlopt?]
"

DOCS=( README.md CHANGES.md )

src_compile() {
	ocaml pkg/pkg.ml build --with-cmdliner false || die
}

src_install() {
	findlib_src_preinst

	local nativelibs=""
	use ocamlopt && nativelibs="$(echo _build/src/${PN}.cm{x,xa,xs,ti} _build/src/${PN}.a)"
	ocamlfind install ${PN} _build/pkg/META _build/src/${PN}.mli _build/src/${PN}.cm{a,i} ${nativelibs} || die

}
