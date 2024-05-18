# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Write tests, let a fuzzer find failing cases"
HOMEPAGE="https://github.com/stedolan/crowbar"
SRC_URI="https://github.com/stedolan/crowbar/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RDEPEND="
	dev-ml/afl-persistent:=
	>=dev-ml/cmdliner-1.1.0:=
	dev-ml/ocplib-endian:=
"
DEPEND="
	${DEPEND}
	test? (
		dev-ml/calendar
		dev-ml/fpath
		dev-ml/pprint
		dev-ml/uucp
		dev-ml/uunf
		dev-ml/uutf
	)
"

RESTRICT="!test? ( test )"
