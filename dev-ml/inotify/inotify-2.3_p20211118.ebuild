# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

COMMIT="b340204c72ae3ff27def6e116c1998485fc3227e"
MYPN="ocaml-${PN}"

DESCRIPTION="OCaml bindings for inotify"
HOMEPAGE="
	https://github.com/whitequark/ocaml-inotify
	https://opam.ocaml.org/packages/inotify/
"
SRC_URI="https://github.com/whitequark/${MYPN}/archive/${COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/${MYPN}-${COMMIT}"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RDEPEND="dev-lang/ocaml:=[ocamlopt?]"
DEPEND="
	${RDEPEND}
	test? (
		dev-ml/ounit2
		dev-ml/ocaml-fileutils
		dev-ml/lwt
	)
"

RESTRICT="!test? ( test )"
