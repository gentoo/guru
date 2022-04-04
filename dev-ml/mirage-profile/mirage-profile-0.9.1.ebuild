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
IUSE="ocamlopt xen"

RDEPEND="
	dev-ml/mtime
	dev-ml/io-page
	dev-ml/ocplib-endian

	xen? (
		dev-ml/mirage-xen
		dev-ml/xenstore
	)
"
DEPEND="${RDEPEND}"

src_compile() {
	local pkgs="mirage-profile-unix,mirage-profile"
	use xen && pkgs="${pkgs},mirage-profile-xen"
	dune build --only-packages "${pkgs}" -j $(makeopts_jobs) --profile release || die
}

src_install() {
	dune_src_install mirage-profile
	dune_src_install mirage-profile-unix
	use xen && dune_src_install mirage-profile-xen
}
