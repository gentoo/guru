# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Indentation tool for OCaml, to be used from editors like Emacs and Vim."
HOMEPAGE="
	http://www.typerex.org/ocp-indent.html
	https://github.com/OCamlPro/ocp-indent
"
SRC_URI="https://github.com/OCamlPro/ocp-indent/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"

SLOT="0/${PV}"

KEYWORDS="~amd64"
IUSE="ocamlopt test"

RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-ml/cmdliner-1.0.0:=
"

DEPEND="
	${RDEPEND}
"
