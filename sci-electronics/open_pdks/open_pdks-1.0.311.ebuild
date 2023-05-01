# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit check-reqs python-any-r1

DESCRIPTION="PDK installer for open-source EDA tools and toolchains"
HOMEPAGE="https://github.com/RTimothyEdwards/open_pdks"
SRC_URI="https://github.com/RTimothyEdwards/open_pdks/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+sky130"

DEPEND="
	dev-lang/tcl:0=
	dev-lang/tk:0=
	>=sci-electronics/magic-8.3.277:=
	sky130? ( sci-electronics/skywater-pdk:= )
"
BDEPEND="${PYTHON_DEPS}"

CHECKREQS_DISK_BUILD="40G"
CHECKREQS_DISK_USR="10G"

src_prepare() {
	default
	# TODO: install helper python[tk] files
	# sed -i 's/\$(datadir)/\$(DESTDIR)\$(datadir)/g' Makefile.in || due
}

src_configure() {
	cd scripts || die
	local myeconfargs=(
		--enable-magic
		$(use_enable sky130 sky130-pdk /usr/share/pdk/skywater-pdk-source)
		$(use_with sky130 sky130-variants all)
		# Pending deps
		--disable-alpha-sky130
		--disable-xschem-sky130
		--disable-netgen
		--disable-irsim
		--disable-openlane
		--disable-qflow
		--disable-xschem
	)

	econf "${myeconfargs[@]}"
}
