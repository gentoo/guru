# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info

DESCRIPTION="Dynamic Kernel Module Support"
HOMEPAGE="https://github.com/dell/dkms"
SRC_URI="https://github.com/dell/dkms/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"

IUSE="systemd"

CONFIG_CHECK="~MODULES"

RDEPEND="
	sys-apps/kmod
	virtual/linux-sources
	systemd? ( sys-apps/systemd )
"

# Error: unknown Linux distribution ID gentoo
RESTRICT="test"

src_prepare() {
	# Install uncompressed version of man files
	sed -i  -e '\_gzip -9 $(MAN)/dkms.8_d' Makefile || die
	default
}

src_compile() {
	# Nothing to do here
	return
}

src_test() {
	./run_test.sh || die "Tests failed"
}

src_install() {
	if use systemd; then
		emake install-redhat DESTDIR="${ED}" LIBDIR="${ED}"/usr/$(get_libdir)/
	else
		emake install DESTDIR="${ED}" LIBDIR="${ED}"/usr/$(get_libdir)/
	fi
	einstalldocs
	keepdir /var/lib/dkms
}
