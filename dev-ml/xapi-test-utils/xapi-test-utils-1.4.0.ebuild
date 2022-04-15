# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="An OCaml package with modules for easy unit testing"
HOMEPAGE="https://github.com/xapi-project/xapi-test-utils"
SRC_URI="https://github.com/xapi-project/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1-with-linking-exception"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

DEPEND=""
RDEPEND="
	${DEPEND}
	test? ( dev-ml/alcotest )
"

RESTRICT="!test? ( test )"
