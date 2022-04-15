# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit findlib opam

MY_P="ocaml-${P}"

DESCRIPTION="OCaml bindings to libpci using Ctypes"
HOMEPAGE="https://github.com/simonjbeaumont/ocaml-pci"
SRC_URI="https://github.com/simonjbeaumont/ocaml-pci/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="
	sys-apps/pciutils
	dev-ml/ocaml-ctypes
"
DEPEND="
	${RDEPEND}
	dev-ml/ounit
"

RESTRICT="!test? ( test )"
OPAM_FILE=opam

src_configure() {
	myconf=(
		$(usex test '--enable-test' '')
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
	use test && emake test
}

src_install() {
	findlib_src_preinst
	emake install
}

src_test() {
	opam_src_test
}
