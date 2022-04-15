# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="A simple on-disk fixed length queue"
HOMEPAGE="https://github.com/mirage/shared-block-ring"
SRC_URI="https://github.com/mirage/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RDEPEND="
	>=dev-ml/cstruct-6.0.0:=[ppx]
	dev-ml/lwt:=
	dev-ml/lwt_log:=
	dev-ml/cmdliner:=
	dev-ml/duration:=
	>=dev-ml/io-page-2.4.0:=
	dev-ml/logs:=
	>=dev-ml/mirage-block-2.0.1:=
	dev-ml/mirage-block-unix:=
	dev-ml/mirage-clock:=
	>=dev-ml/mirage-time-2.0.1:=
	>=dev-ml/ppx_sexp_conv-0.10.0:=
	dev-ml/result:=
	dev-ml/rresult:=
	dev-ml/sexplib:=
	dev-ml/sexplib0:=
"
DEPEND="
	${RDEPEND}
	test? ( >=dev-ml/ounit-2 )
"

RESTRICT="!test? ( test )"
PATCHES="${FILESDIR}/${P}-PR-62.patch"
