# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Bigstring intrinsics and fast blits based on memcpy/memmove"
HOMEPAGE="https://github.com/inhabitedtype/bigstringaf"
SRC_URI="https://github.com/inhabitedtype/bigstringaf/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-ml/dune-configurator-3.0:=
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	test? (
		dev-ml/alcotest:=
	)
"
