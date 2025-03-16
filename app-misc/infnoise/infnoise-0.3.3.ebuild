# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="infinite noise TRNG program"
HOMEPAGE="https://github.com/leetronics/infnoise"
SRC_URI="https://github.com/leetronics/infnoise/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-embedded/libftdi"
RDEPEND="${DEPEND}"

inherit udev

src_prepare() {
	default
	sed -i 's|PREFIX = $(DESTDIR)/usr/local|PREFIX=${DESTDIR}|' "${S}/software/Makefile.linux"
	sed -i '31s/ar/${AR}/' "${S}/software/Makefile.linux"
	sed -i '18s/$(CFLAGS)/$(CFLAGS) $(LDFLAGS)/' "${S}/software/Makefile.linux"
	sed -i '36s/$(CFLAGS)/$(CFLAGS) $(LDFLAGS)/' "${S}/software/Makefile.linux"
	sed -i '/^GIT_/d' "${S}/software/Makefile.linux"
}

src_compile() {
	local ftdi_cflags
	local ftdi_ldflags

	ftdi_cflags=$(pkg-config --cflags libftdi1)
	ftdi_ldflags=$(pkg-config --libs libftdi1)

	origCFLAGS="-fPIC -std=c99 -DLINUX -I Keccak -DGIT_VERSION=\\\"\\\" -DGIT_COMMIT=\\\"\\\" -DGIT_DATE=\\\"\\\""

	cd "${S}"/software
	emake -f Makefile.linux CFLAGS="${CFLAGS} ${origCFLAGS} ${ftdi_cflags}" LDFLAGS="${LDFLAGS}\
		${ftdi_ldflags}" -j$(nproc)
}

src_install() {
	newinitd "${FILESDIR}"/infnoise.initd infnoise

	cd "${S}"/software
	export DESTDIR="${D}"
	emake -f Makefile.linux install DESTDIR="${D}"
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
