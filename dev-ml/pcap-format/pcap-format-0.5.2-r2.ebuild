# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Read and write pcap-formatted network packet traces"
HOMEPAGE="https://github.com/mirage/ocaml-pcap"
SRC_URI="https://github.com/mirage/ocaml-pcap/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ocaml-pcap-${PV}"

LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt test"

RDEPEND="dev-ml/cstruct[ppx]"
DEPEND="
	${RDEPEND}
	test? (
		dev-ml/ounit
		dev-ml/mmap
	)
"

RESTRICT="!test? ( test )"
