# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit findlib opam

MY_P="ocaml-${P}"

DESCRIPTION="OCaml module for native access to the systemd facilities"
HOMEPAGE="https://github.com/juergenhoetzel/ocaml-systemd"
SRC_URI="https://github.com/juergenhoetzel/ocaml-${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="LGPL-3-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

RDEPEND="sys-apps/systemd"
DEPEND="
	${RDEPEND}
	dev-ml/ocamlbuild
"

OPAM_FILE=opam

src_configure() {
	myconf=(
		--prefix "/usr"
		--destdir "${D}"
		--libdir "/usr/$(get_libdir)"
		--docdir "/usr/share/doc/${PF}"
		--htmldir "/usr/share/doc/${PF}/html"
		--override debug false
		--override is_native $(usex ocamlopt true false)
	)
	./configure "${myconf[@]}" || die
}

src_compile() {
	emake
}

src_install() {
	findlib_src_preinst
	emake install
}
