# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="A libary to build xml trees typechecked by OCaml"
HOMEPAGE="
	https://ocsigen.org/tyxml/
	https://github.com/ocsigen/tyxml
"
SRC_URI="https://github.com/ocsigen/tyxml/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt"

DEPEND="
	dev-ml/markup
	dev-ml/re
	dev-ml/ppxlib
	dev-ml/uutf
"
RDEPEND="${DEPEND}"
