# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

MY_P="${PN}-v${PV}"

DESCRIPTION="Bindings to UNIX tuntap facilities"
HOMEPAGE="
	https://github.com/mirage/ocaml-tuntap
	https://opam.ocaml.org/packages/tuntap/
"
SRC_URI="https://github.com/mirage/ocaml-${PN}/releases/download/v${PV}/${MY_P}.tbz"
S="${WORKDIR}/${MY_P}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RDEPEND="
	dev-ml/cmdliner:=
	>=dev-ml/ipaddr-5.0.0:=
"
DEPEND="
	${RDEPEND}
	sys-kernel/linux-headers
	test? ( >=dev-ml/lwt-5.0.0 )
"

RESTRICT="!test? ( test )"
