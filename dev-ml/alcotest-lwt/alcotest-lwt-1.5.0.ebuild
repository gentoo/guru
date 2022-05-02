# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

DESCRIPTION="Lwt-based helpers for Alcotest"
HOMEPAGE="https://github.com/mirage/alcotest"
SRC_URI="https://github.com/mirage/alcotest/archive/${PV}.tar.gz -> alcotest-${PV}.tar.gz"
S="${WORKDIR}/alcotest-${PV}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RDEPEND="
	dev-ml/fmt:=
	~dev-ml/alcotest-${PV}:=
	dev-ml/lwt:=
	dev-ml/logs:=
"
DEPEND="
	${RDEPEND}
	test? (
		<dev-ml/cmdliner-1.1.0:=
		dev-ml/re:=
	)
"

RESTRICT="!test? ( test )"

src_compile() {
	dune build --only-packages alcotest-lwt -j $(makeopts_jobs) || die
}

src_install() {
	dune_src_install alcotest-lwt
}
