# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MYPN="ocaml-${PN}"

DESCRIPTION="OCaml bindings for inotify"
HOMEPAGE="
	https://github.com/whitequark/ocaml-inotify
	https://opam.ocaml.org/packages/inotify/
"
SRC_URI="https://github.com/whitequark/${MYPN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MYPN}-${PV}"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RDEPEND=">=dev-lang/ocaml-4.03:=[ocamlopt?]"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-ml/ounit2-2.0
		>=dev-ml/ocaml-fileutils-0.4.4
		dev-ml/lwt
	)
"

RESTRICT="!test? ( test )"
