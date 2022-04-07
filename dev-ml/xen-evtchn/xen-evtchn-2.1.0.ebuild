# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

MY_P="${PN}-v${PV}"

DESCRIPTION="Xen event channel interface for Mirage"
HOMEPAGE="https://github.com/mirage/ocaml-evtchn"
SRC_URI="https://github.com/mirage/ocaml-evtchn/releases/download/v${PV}/${MY_P}.tbz"
S="${WORKDIR}/${MY_P}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test unix"

RDEPEND="
	dev-ml/lwt
	dev-ml/lwt-dllist
	dev-ml/cmdliner

	unix? ( app-emulation/xen )
"
DEPEND="
	${RDEPEND}
	test? ( dev-ml/ounit )
"

RESTRICT="!test? ( test )"
REQUIRED_USE="test? ( unix )"

src_compile() {
	local pkgs="xen-evtchn"
	use unix && pkgs="${pkgs},xen-evtchn-unix"
	dune build -p "${pkgs}" -j $(makeopts_jobs) || die
}

src_install() {
	dune_src_install xen-evtchn
	use unix && dune_src_install xen-evtchn-unix
}
