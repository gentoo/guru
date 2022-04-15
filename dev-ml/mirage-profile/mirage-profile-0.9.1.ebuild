# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune multiprocessing

DESCRIPTION="Collect profiling information"
HOMEPAGE="https://github.com/mirage/mirage-profile"
SRC_URI="https://github.com/mirage/mirage-profile/archive/v${PV}.tar.gz -> mirage-profile-${PV}.tar.gz"
S="${WORKDIR}/mirage-profile-${PV}"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="ocamlopt unix" # xen

RDEPEND="
	dev-ml/cstruct
	dev-ml/lwt
	dev-ml/ocplib-endian

	unix? ( dev-ml/mtime )
"
#	xen? (
#		dev-ml/io-page[xen]
#		dev-ml/mirage-xen
#		dev-ml/mirage-xen-minios
#		dev-ml/xenstore
#	)
DEPEND="
	${RDEPEND}
	dev-ml/cstruct[ppx]
"

src_compile() {
	local pkgs="mirage-profile"
#	use xen && pkgs="${pkgs},mirage-profile-xen"
	use unix && pkgs="${pkgs},mirage-profile-unix"
	dune build -p "${pkgs}" -j $(makeopts_jobs) || die
}

src_install() {
	dune_src_install mirage-profile
	use unix && dune_src_install mirage-profile-unix
#	use xen && dune_src_install mirage-profile-xen
}
